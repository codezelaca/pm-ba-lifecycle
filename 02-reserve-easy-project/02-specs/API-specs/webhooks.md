# Webhooks Documentation

**Purpose:** Document webhooks for third-party integrations (SMS delivery status, payment events)

---

## Overview

ReserveEasy uses **webhooks** to receive real-time notifications from external services (Twilio for SMS, Stripe for payments). This allows us to track delivery status and payment confirmations asynchronously.

**What is a Webhook?**  
A webhook is a callback HTTP POST request sent from Service A → Service B when an event occurs.

**Example:** When Twilio delivers an SMS, it calls our webhook endpoint to report status.

---

## Webhook Endpoints

### 1. Twilio SMS Delivery Status

**Endpoint:** `POST /api/v1/webhooks/twilio/sms-status`  
**Purpose:** Receive SMS delivery status updates from Twilio

---

#### Request from Twilio

When Twilio delivers (or fails to deliver) an SMS, it sends:

```http
POST /api/v1/webhooks/twilio/sms-status
Content-Type: application/x-www-form-urlencoded

MessageSid=SM1234567890abcdef
SmsSid=SM1234567890abcdef
AccountSid=AC1234567890abcdef
From=+15551234567
To=+15559876543
MessageStatus=delivered
ApiVersion=2010-04-01
```

**Key Fields:**

- `MessageSid`: Unique identifier for this SMS
- `MessageStatus`: One of: `queued`, `sent`, `delivered`, `failed`, `undelivered`
- `To`: Recipient phone number
- `From`: Sender phone number (our Twilio number)

---

#### Our Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "status": "received"
}
```

Twilio expects a `200 OK` response. If we return an error, Twilio will retry the webhook up to 3 times.

---

#### What We Do With This Data

1. **Look up booking by phone number:**

   ```sql
   SELECT id FROM bookings
   WHERE customer_phone = '+15559876543'
     AND status = 'confirmed'
   ORDER BY created_at DESC
   LIMIT 1;
   ```

2. **Update booking record:**

   ```sql
   UPDATE bookings
   SET sms_delivered = true,
       sms_delivered_at = NOW()
   WHERE id = 12345;
   ```

3. **If status = 'failed':**
   - Log error
   - Trigger email fallback
   - Alert support team

---

### 2. Stripe Payment Webhook

**Endpoint:** `POST /api/v1/webhooks/stripe/payment-events`  
**Purpose:** Receive payment confirmation, refund status

---

#### Request from Stripe

When a payment succeeds or fails:

```http
POST /api/v1/webhooks/stripe/payment-events
Content-Type: application/json
Stripe-Signature: t=1234567890,v1=abc123...

{
  "id": "evt_1234567890",
  "object": "event",
  "type": "payment_intent.succeeded",
  "data": {
    "object": {
      "id": "pi_1234567890",
      "amount": 6000,
      "currency": "usd",
      "status": "succeeded",
      "metadata": {
        "booking_id": "12345"
      }
    }
  }
}
```

**Event Types We Handle:**

- `payment_intent.succeeded` → Payment captured successfully
- `payment_intent.payment_failed` → Payment declined
- `charge.refunded` → Refund processed

---

#### Security: Verifying Stripe Signature

Stripe signs webhooks using HMAC SHA256. We must verify the signature to prevent spoofing.

```javascript
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

app.post("/api/v1/webhooks/stripe/payment-events", (req, res) => {
  const sig = req.headers["stripe-signature"];
  const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;

  let event;
  try {
    event = stripe.webhooks.constructEvent(req.body, sig, webhookSecret);
  } catch (err) {
    console.error("Webhook signature verification failed:", err.message);
    return res.status(400).send(`Webhook Error: ${err.message}`);
  }

  // Process event
  if (event.type === "payment_intent.succeeded") {
    const paymentIntent = event.data.object;
    const bookingId = paymentIntent.metadata.booking_id;

    // Update booking status
    updateBookingPaymentStatus(bookingId, "paid");
  }

  res.json({ received: true });
});
```

---

#### What We Do With Payment Events

**On `payment_intent.succeeded`:**

1. Update booking: `deposit_paid = true`
2. Send confirmation SMS
3. Log payment in `transactions` table

**On `payment_intent.payment_failed`:**

1. Mark booking as `payment_pending`
2. Send email: "Your payment failed. Please update your card."
3. Hold booking for 2 hours, then auto-cancel

**On `charge.refunded`:**

1. Update booking: `deposit_refunded = true, refunded_at = NOW()`
2. Send email: "Your $60 deposit has been refunded"

---

## Webhook Security Best Practices

### 1. Verify Signatures

Always verify that webhooks come from the actual service (Twilio, Stripe), not an attacker.

**Twilio:** Check `X-Twilio-Signature` header  
**Stripe:** Check `Stripe-Signature` header

---

### 2. Use HTTPS Only

Webhooks must be sent to `https://` endpoints, never `http://`.

---

### 3. Return 200 Quickly

Process webhooks **asynchronously**. Don't make the webhook caller wait.

**Bad:**

```javascript
app.post("/webhook", async (req, res) => {
  await sendEmail(); // Slow! Twilio times out after 10 seconds
  res.send("OK");
});
```

**Good:**

```javascript
app.post("/webhook", (req, res) => {
  queue.push(req.body); // Add to job queue
  res.send("OK"); // Return immediately
});

// Separate worker processes queue
worker.process(async (job) => {
  await sendEmail(job.data);
});
```

---

### 4. Idempotency

Webhooks may be sent **multiple times** (if response is slow or times out). Handle duplicates gracefully.

```javascript
// Check if we've already processed this event
const existingEvent = await db.webhookEvents.findOne({
  event_id: event.id,
});

if (existingEvent) {
  console.log("Duplicate event, ignoring");
  return res.json({ received: true });
}

// Store event ID to prevent re-processing
await db.webhookEvents.create({
  event_id: event.id,
  processed_at: new Date(),
});

// Now process the event
processEvent(event);
```

---

## Testing Webhooks Locally

### Using ngrok (Local Tunnel)

Twilio and Stripe need a public URL to send webhooks. Use `ngrok` to expose localhost:

```bash
# Install ngrok
brew install ngrok

# Start your local server
npm run dev  # Runs on localhost:3000

# Create tunnel
ngrok http 3000

# ngrok will give you a URL like:
# https://abc123.ngrok.io
```

**Configure Webhook URL:**

- Twilio: Set SMS Status Callback to `https://abc123.ngrok.io/api/v1/webhooks/twilio/sms-status`
- Stripe: Add webhook endpoint `https://abc123.ngrok.io/api/v1/webhooks/stripe/payment-events`

---

### Stripe CLI (Recommended for Stripe)

Stripe provides a CLI tool that forwards webhook events to localhost:

```bash
# Install Stripe CLI
brew install stripe/stripe-cli/stripe

# Login
stripe login

# Forward events to local server
stripe listen --forward-to localhost:3000/api/v1/webhooks/stripe/payment-events

# Trigger test event
stripe trigger payment_intent.succeeded
```

---

## Monitoring Webhooks

### Twilio Webhook Logs

View in Twilio Console:

1. Go to **Programmable SMS → SMS Logs**
2. Click on a message
3. See "Webhook Responses" section
4. Check HTTP status code (should be 200)

---

### Stripe Webhook Logs

View in Stripe Dashboard:

1. Go to **Developers → Webhooks**
2. Click on your endpoint
3. See "Recent Deliveries"
4. Status codes, response times, retry attempts

---

## Error Handling

| Error Scenario                     | Response Code             | Service Behavior                              |
| ---------------------------------- | ------------------------- | --------------------------------------------- |
| Webhook processed successfully     | 200 OK                    | No retry                                      |
| Temporary error (database timeout) | 500 Internal Server Error | Retry 3 times with exponential backoff        |
| Invalid signature                  | 400 Bad Request           | No retry (security issue)                     |
| Unknown event type                 | 200 OK (but log warning)  | No retry (we might not handle this event yet) |

**Retry Schedule (Twilio & Stripe):**

- Attempt 1: Immediate
- Attempt 2: +1 minute
- Attempt 3: +5 minutes
- Attempt 4: +30 minutes
- Give up after 4 attempts

---

## Example: Complete Twilio SMS Webhook Handler

```javascript
const crypto = require("crypto");

app.post("/api/v1/webhooks/twilio/sms-status", async (req, res) => {
  // 1. Verify signature (security)
  const twilioSignature = req.headers["x-twilio-signature"];
  const url = `https://api.reserveeasy.com/api/v1/webhooks/twilio/sms-status`;
  const params = req.body;

  const expectedSignature = crypto
    .createHmac("sha1", process.env.TWILIO_AUTH_TOKEN)
    .update(
      url +
        Object.keys(params)
          .sort()
          .map((k) => k + params[k])
          .join(""),
    )
    .digest("base64");

  if (twilioSignature !== expectedSignature) {
    console.error("Invalid Twilio signature");
    return res.status(403).send("Forbidden");
  }

  // 2. Extract data
  const { MessageSid, MessageStatus, To } = req.body;

  // 3. Update database (async, non-blocking)
  queue.add("update-sms-status", {
    messageSid: MessageSid,
    status: MessageStatus,
    phone: To,
  });

  // 4. Return 200 immediately
  res.status(200).json({ status: "received" });
});

// Worker (separate process)
queue.process("update-sms-status", async (job) => {
  const { messageSid, status, phone } = job.data;

  // Find booking
  const booking = await db.bookings.findOne({
    customer_phone: phone,
    status: "confirmed",
    order: [["created_at", "DESC"]],
  });

  if (!booking) {
    console.warn(`No booking found for phone ${phone}`);
    return;
  }

  // Update delivery status
  await db.bookings.update(
    {
      sms_delivered: status === "delivered",
      sms_status: status,
      sms_delivered_at: new Date(),
    },
    {
      where: { id: booking.id },
    },
  );

  // If failed, trigger email fallback
  if (status === "failed" || status === "undelivered") {
    await sendEmailConfirmation(booking);
  }
});
```

---

[← Back to API Specs](../02-specs/) | [Booking API →](booking-api.yaml)
