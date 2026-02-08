# North Star Metric

**For ReserveEasy**

---

## What is a North Star Metric?

Your **North Star Metric (NSM)** is the single most important metric that best captures the core value your product delivers to customers.

**Characteristics of a good NSM:**

- ✅ Measures customer value (not just revenue)
- ✅ Reflects product usage and engagement
- ✅ Leads to revenue (but isn't revenue itself)
- ✅ Simple to understand and communicate

---

## ReserveEasy's North Star Metric

### **Monthly Completed Bookings (MCB)**

**Definition:** Total number of restaurant reservations that were **made AND the diner showed up** in a given month.

**Why this metric?**

- Represents value to **BOTH sides** of the marketplace:
  - **Diners:** Successfully got a table
  - **Restaurants:** Filled seats, earned revenue
- Directly correlates with our commission revenue
- Excludes cancelled bookings and no-shows (which create no value)

**Formula:**

```
MCB = COUNT(bookings WHERE status = 'completed' AND MONTH(booking_date) = current_month)
```

---

## North Star vs Other Metrics

| Metric                       | Why NOT North Star?                        |
| ---------------------------- | ------------------------------------------ |
| **Total Signups**            | Vanity metric - users might never book     |
| **Gross Booking Value ($$)** | Focuses on revenue, not core product value |
| **Restaurant Partners**      | Supply-side metric, doesn't measure usage  |
| **Pageviews**                | Doesn't reflect actual bookings            |
| **Booking Conversion Rate**  | Important but doesn't capture scale        |

**Our NSM captures both SCALE (total volume) and QUALITY (completed, not cancelled).**

---

## North Star Decomposition

NSM = **visitors** × **booking conversion** × **show-up rate**

```
Monthly Completed Bookings =
    (Monthly Website Visitors) ×
    (% who book) ×
    (% who show up)

Example:
100,000 visitors × 5% booking rate × 95% show-up rate = 4,750 MCB
```

**Lever Analysis:**

1. **Increase visitors:** SEO, paid ads, partnerships
2. **Increase booking conversion:** Simplify flow, trust signals
3. **Increase show-up rate:** Deposit system, SMS reminders

---

## Current Performance

| Month             | MCB   | Growth MoM |
| ----------------- | ----- | ---------- |
| Jan 2026 (Launch) | 1,200 | -          |
| Feb 2026          | 3,500 | +192%      |
| Mar 2026          | 5,000 | +43%       |
| Apr 2026 (Target) | 7,500 | +50%       |

**Year 1 Goal:** 15,000 MCB by December 2026

---

## Supporting Metrics (Input Metrics)

These metrics **drive** the North Star:

### Acquisition

- Monthly Unique Visitors
- Traffic Sources (organic, paid, referral)
- Cost per Acquisition (CPA)

### Activation

- % of visitors who search
- % of searchers who view a restaurant
- % of viewers who check availability

### Conversion

- Booking Conversion Rate (bookings / restaurant views)
- Form Abandonment Rate
- Payment Success Rate

### Retention

- Show-Up Rate (95% target)
- Repeat Booking Rate (% who book again within 30 days)
- Monthly Active Bookers (MAB)

---

## Dashboard Query

```sql
-- North Star Metric: Monthly Completed Bookings
SELECT
    DATE_TRUNC('month', booking_date) AS month,
    COUNT(*) AS monthly_completed_bookings
FROM bookings
WHERE status = 'completed'  -- Diner showed up
  AND booking_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '11 months')
GROUP BY month
ORDER BY month DESC;

-- Output:
-- month       | monthly_completed_bookings
-- ------------+---------------------------
-- 2026-04-01  | 7200
-- 2026-03-01  | 5000
-- 2026-02-01  | 3500
-- 2026-01-01  | 1200
```

---

## How We Track It

**Daily Dashboard:**

- Real-time MCB counter (current month)
- Projection: "On track to hit 7,500 MCB this month" (based on daily run-rate)

**Weekly Review:**

- Compare to last week, last month
- Analyze drop-offs in funnel (which lever to pull?)

**Monthly Business Review:**

- MCB vs target
- Decomposition: Which input metrics drove growth?
- Action items for next month

---

## North Star in Decision-Making

**Example 1: Feature Prioritization**

Should we build **"Table Preferences"** (window seat, booth) vs **"SMS Reminders"**?

- **Table Preferences:** Improves satisfaction, but unclear impact on MCB
- **SMS Reminders:** Reduces no-shows → directly increases show-up rate → increases MCB

**Decision:** Ship SMS reminders first (clearer NSM impact)

---

**Example 2: Marketing Channel**

Should we invest in **Instagram ads** vs **Google Search Ads**?

| Channel   | Cost | Expected Visitors | Booking Conversion | MCB Impact |
| --------- | ---- | ----------------- | ------------------ | ---------- |
| Instagram | $10k | 50,000            | 2% (lower intent)  | +950 MCB   |
| Google    | $10k | 20,000            | 8% (high intent)   | +1,520 MCB |

**Decision:** Google Search Ads (higher MCB per dollar)

---

## Avoiding North Star Pitfalls

### Pitfall 1: Gaming the Metric

**Bad:** Incentivize restaurants to mark no-shows as "completed" → inflates MCB falsely

**Prevention:** Cross-check with payment data, audit random bookings

---

### Pitfall 2: Ignoring Quality

**Bad:** Drive MCB growth with low-quality restaurants → High no-show rates, poor reviews

**Prevention:** Track secondary metric "NPS" (Net Promoter Score) to ensure quality

---

### Pitfall 3: Short-Term Focus

**Bad:** Run aggressive promotions to spike MCB this month, but no retention

**Prevention:** Track "Repeat MCB" (bookings from users who booked before)

---

## Related Metrics Framework (AARRR)

NSM fits into the broader pirate metrics:

| Stage           | Metric                            | Target  |
| --------------- | --------------------------------- | ------- |
| **Acquisition** | Monthly Visitors                  | 100,000 |
| **Activation**  | % who complete first booking      | 20%     |
| **Retention**   | % who book again in 30 days       | 35%     |
| **Revenue**     | Monthly Recurring Revenue (MRR)   | $120k   |
| **Referral**    | % of bookings from referred users | 15%     |

**North Star (MCB)** primarily measures **Activation + Retention**.

---

[← Back to Analytics](../05-analytics/) | [Schema →](schema.sql) | [Queries →](queries/)
