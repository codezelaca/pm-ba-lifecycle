# Case Study Framework

**How to analyze and present PM/BA case studies**

---

## Overview

Case studies are the gold standard for demonstrating your PM/BA capabilities. This framework helps you structure case studies for portfolio, interviews, or internal presentations.

---

## The CIRCLES Framework for Product Cases

Use **CIRCLES** for product design and improvement cases:

| Letter | Step               | Key Questions                                      |
| ------ | ------------------ | -------------------------------------------------- |
| **C**  | Comprehend         | What is the product? Who uses it? What does it do? |
| **I**  | Identify Users     | Who are the key personas? Which to focus on?       |
| **R**  | Report Needs       | What are their pain points and goals?              |
| **C**  | Cut Scope          | Which problem to prioritize? Why?                  |
| **L**  | List Solutions     | What are 3-5 possible solutions?                   |
| **E**  | Evaluate Tradeoffs | Pros/cons of each? Which to recommend?             |
| **S**  | Summarize          | What's the recommendation? How to measure success? |

---

## The STAR Framework for Behavioral Cases

Use **STAR** for past experience cases:

| Letter | Step      | What to Include                    |
| ------ | --------- | ---------------------------------- |
| **S**  | Situation | Context, timeline, your role       |
| **T**  | Task      | What you were responsible for      |
| **A**  | Action    | Specific steps YOU took (not "we") |
| **R**  | Result    | Quantified outcome, learnings      |

---

## Case Study Template

### 1. Executive Summary (1 paragraph)

_[2-3 sentences capturing the entire case: problem, approach, result]_

**Example:**

> Booking conversion on ReserveEasy dropped 20% in March 2026. Through funnel analysis, I identified payment form abandonment as the root cause. By reverting to the previous form design and implementing A/B testing protocols, we recovered 95% of lost bookings within 2 weeks, recovering $180k in monthly GMV.

---

### 2. Context & Problem (1-2 paragraphs)

**What was the situation?**

- Company/product background
- Timeframe
- Your role and scope

**What was the problem or opportunity?**

- Quantify the impact (revenue, users, efficiency)
- How was it discovered?
- Why did it matter?

**Example:**

> ReserveEasy is a restaurant reservation platform serving 500 restaurants and 50k monthly active users. In March 2026, our North Star Metric (Monthly Completed Bookings) dropped from 5,000 to 4,000 — a 20% decline.
>
> As the PM, I owned the booking flow and was responsible for diagnosing and fixing the issue.

---

### 3. Discovery & Analysis (2-3 paragraphs)

**What did you investigate?**

- Data analysis (funnel, cohorts, A/B test results)
- User research (interviews, surveys, session replays)
- Stakeholder input

**What did you find?**

- Root cause identification
- Supporting evidence
- Alternative hypotheses ruled out

**Example:**

> I started with funnel analysis, querying our analytics database:
>
> ```sql
> SELECT step, conversion_rate
> FROM booking_funnel
> WHERE date BETWEEN '2026-02-01' AND '2026-03-31'
> ORDER BY step;
> ```
>
> Results showed that drop-off at Step 4 (Payment) increased from 15% to 40% after our March 1 release. I cross-referenced with release notes and found we'd deployed a new payment form UI.
>
> To validate, I analyzed session replays (Hotjar) and found users struggling with the new credit card input validation, which was erroring on valid card numbers.

---

### 4. Solution & Decision-Making (2-3 paragraphs)

**What options did you consider?**

- List 2-4 alternatives
- Tradeoffs of each

**How did you decide?**

- Framework used (RICE, ICE, etc.)
- Stakeholder alignment process
- Timeline and constraints

**What did you implement?**

- Specific solution details
- Scope (MVP vs full solution)

**Example:**

> I identified three options:
>
> | Option             | Pros                 | Cons                             |
> | ------------------ | -------------------- | -------------------------------- |
> | Revert to old form | Fast, safe           | Delays new form improvements     |
> | Fix validation bug | Addresses root cause | Takes 1 week to diagnose         |
> | Hybrid form        | Best UX              | 3 weeks, delays revenue recovery |
>
> Given the revenue impact ($180k/month at risk), I recommended Option 1 (revert) as an immediate fix, followed by proper A/B testing for the new form.
>
> I presented the analysis to VP Product, got approval within 4 hours, and Engineering deployed the revert the same day.

---

### 5. Results & Impact (1-2 paragraphs)

**What happened?**

- Quantified outcomes (before/after)
- Timeline to impact
- Secondary effects

**How did you measure success?**

- Metrics tracked
- Statistical significance (if applicable)

**Example:**

> Within 48 hours of the revert:
>
> - Payment step conversion recovered from 60% → 87% (target: 85%)
> - Monthly Completed Bookings returned to 4,800 (95% of baseline)
> - Estimated recovered revenue: $180k/month
>
> The A/B test framework I implemented post-mortem ensured future UX changes would be validated before full rollout.

---

### 6. Learnings & Reflections (1 paragraph)

**What would you do differently?**
**What did you learn about product/process?**
**How did this change your approach going forward?**

**Example:**

> This experience taught me the importance of feature flags and gradual rollouts. We now deploy all payment-related changes behind feature flags with 5% → 25% → 100% rollout over 1 week, with automated regression alerts.
>
> I also learned to escalate revenue-impacting issues faster — the problem existed for 5 days before I was alerted.

---

## Formatting Tips

### For Portfolios:

- Use visuals (charts, diagrams, screenshots)
- Link to actual artifacts (sanitized)
- Keep to 1-2 pages max

### For Interviews:

- Practice 3-5 minute verbal version
- Have data points memorized
- Prepare for follow-up questions

### For Presentations:

- Use slide deck (10 slides max)
- Lead with the result
- End with learnings + Q&A

---

## Sample Case Study Outline

**Title:** Reducing Booking Drop-off by 25% at ReserveEasy

1. **Overview** (1 slide)
   - Problem: 20% decline in bookings
   - Solution: Payment form revert + A/B testing framework
   - Result: 95% recovery in 2 days

2. **Context** (1 slide)
   - Product intro, my role

3. **Problem Statement** (1 slide)
   - Metric decline with timeline

4. **Analysis** (2 slides)
   - Funnel data
   - Session replay findings

5. **Options Evaluated** (1 slide)
   - Decision matrix

6. **Solution** (1 slide)
   - What we shipped

7. **Results** (1 slide)
   - Before/after metrics

8. **Learnings** (1 slide)
   - What changed going forward

---

## Common Case Study Mistakes

### ❌ Don't:

- Focus only on "we" — show YOUR contribution
- Skip the data — quantify everything
- Present only the happy path — show ambiguity and tradeoffs
- Over-explain context — keep it tight
- Forget learnings — show growth mindset

### ✅ Do:

- Lead with results (interviewers are busy)
- Show your analytical process
- Explain WHY you made decisions
- Be honest about what didn't work
- Connect to broader impact

---

## Practice Exercise

**Take a past project and structure it using this framework:**

1. Write the Executive Summary (3 sentences)
2. Define the Problem with metrics
3. Describe your Discovery process
4. List 3 Options you considered
5. Explain your Decision with tradeoffs
6. Quantify the Results
7. Reflect on Learnings

**Time target:** 30 minutes for first draft

---

[⬅️ Back to Portfolio](../README.md) | [Interview Prep →](interview-preparation.md)
