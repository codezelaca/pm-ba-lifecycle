# Bug Report: SMS Confirmation Fails for International Numbers

**Bug ID:** BUG-234  
**Reported By:** QA Team  
**Date Reported:** February 3, 2026  
**Environment:** Production  
**Affected Version:** v1.2.0

---

## Summary

SMS confirmations are not being sent to users with international (non-US/Canada) phone numbers, leaving them without booking proof.

---

## Severity Classification

**Severity:** 🔴 **P1 (High)**

**Justification:**

- Affects 15% of users (international customers)
- Core feature broken (SMS confirmation)
- Workaround exists (email fallback triggers after 2 min)
- Does not block bookings, but creates poor UX

**Not P0 because:** Booking still completes, email fallback works (albeit slowly)

---

## Impact

**Users Affected:** ~750 bookings/month (15% of 5,000 total)

**Business Impact:**

- Users call support asking "Did my booking go through?" (+50 tickets/week)
- Poor NPS from international travelers
- Blocks expansion to EU market

---

## Steps to Reproduce

1. Navigate to `https://app.reserveeasy.com`
2. Complete booking flow for any restaurant
3. At booking form, enter international phone number:
   - **Example 1 (UK):** +44 7911 123456
   - **Example 2 (India):** +91 98765 43210
   - **Example 3 (Australia):** +61 412 345 678
4. Submit booking
5. Check phone for SMS

---

## Expected Behavior

**What should happen:**

- SMS delivered within 30 seconds to the provided international number
- SMS contains: restaurant name, date, time, party size, confirmation code, link

---

## Actual Behavior

**What actually happens:**

- SMS never arrives (even after 10 minutes)
- No error message shown to user
- User sees confirmation page (misleading - they think SMS coming)
- Email fallback triggers after 2 minutes (too long - user already anxious)

---

## Screenshot/Video

![SMS Status Dashboard](https://via.placeholder.com/600x300?text=Screenshot:+Twilio+Dashboard+showing+failed+delivery)

**Twilio Dashboard Error:**

```
Error Code: 21211
Message: "The 'To' phone number +44XXXXXXXXXX is not a valid, SMS-capable inbound phone number."
```

---

## Technical Details

### Browser Console Errors

None - frontend doesn't detect the issue.

---

### Network Request (API Call)

**Endpoint:** `POST /api/v1/notifications/sms`

**Request Payload:**

```json
{
  "to": "+447911123456",
  "message": "Your booking at Bella Italia on 02/15/2026 at 7:00 PM for 4 guests is confirmed. Code: ABC123. Modify: https://app.reserveeasy.com/bookings/XYZ"
}
```

**Response (500 Internal Server Error):**

```json
{
  "error": "SMS delivery failed",
  "details": "Twilio error 21211: Invalid destination number"
}
```

---

### Server Logs

```
[2026-02-03 19:34:12] ERROR [SMSService] Twilio API error
Error Code: 21211
Message: The 'To' phone number +447911123456 is not a valid, SMS-capable inbound phone number.
Account SID: AC1234567890abcdef
Request ID: RM1234567890abcdef
```

---

## Root Cause Analysis

**Identified Issue:**
Twilio account is configured with **US/Canada Geographic Permissions only**. International SMS is disabled by default.

**Why It Wasn't Caught Earlier:**

- Dev/Staging environments use US test numbers only
- UAT testers were all US-based
- International users started booking after EU marketing campaign launch

---

## Reproduction Rate

**Frequency:** 100% reproducible with international numbers

**Affected Phone Number Formats:**

- ✅ **Works:** US (+1), Canada (+1)
- ❌ **Fails:** UK (+44), India (+91), Australia (+61), All EU countries (+3X series), etc.

---

## Suggested Fix

### Option 1: Enable International SMS in Twilio (Recommended)

**Steps:**

1. Log into Twilio Console
2. Navigate to **Settings > Geo Permissions**
3. Enable SMS for:
   - Europe (all countries)
   - Asia Pacific (India, Australia, Singapore, etc.)
   - Latin America (if targeting)
4. Test with +44, +91 numbers

**Cost Impact:** International SMS costs $0.05-0.15/message vs $0.0075 for US → ~10x cost  
**Mitigation:** Only send SMS for high-value bookings (deposit required), use email for others

---

### Option 2: Detect International Numbers & Use Email Only

**Implementation:**

```javascript
if (phoneNumber.startsWith("+1")) {
  sendSMS(phoneNumber);
} else {
  sendEmail(email); // International users get email instead
}
```

**Pros:** No additional Twilio cost  
**Cons:** Poor UX for international users (email slower, less likely to check)

---

## Recommendation

**Proceed with Option 1** - Enable international SMS for better UX. Cost increase is ~$40/month (800 intl bookings × $0.05) which is acceptable given $120k monthly revenue.

---

## Priority & Timeline

**Assigned To:** Backend Team (Sarah, Lead Engineer)  
**Target Fix Date:** February 8, 2026 (before EU marketing push)  
**Dependencies:** None - Twilio config change only

---

## Verification Plan

**After fix deployed:**

1. **Manual Test:**
   - Complete booking with +44 7911 123456 (UK number using Twilio test mode)
   - Verify SMS delivered within 30 seconds

2. **Automated Test:**
   - Add integration test for international SMS delivery
   - Run nightly

3. **Monitor:**
   - Track SMS delivery rate by country code for 7 days
   - Alert if delivery rate <95%

---

## Related Issues

- [BUG-189](BUG-189-email-delay.md) - Email fallback takes 2 minutes (should be 30 seconds)
- [FEATURE-067](#) - Allow users to choose SMS vs Email preference

---

## Sign-Off

**Bug Verified By QA:** ******\_\_\_****** Date: **\_\_\_**  
**Fix Deployed to Production:** ******\_\_\_****** Date: **\_\_\_**  
**Bug Closed:** ******\_\_\_****** Date: **\_\_\_**

---

[← Back to QA](../master-test-plan.md) | [All Bug Reports →](../)
