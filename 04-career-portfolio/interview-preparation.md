# Interview Preparation Guide

**For PM & BA Candidates**

---

## Overview

This guide covers the most common interview types, questions, and frameworks to help you land your dream PM or BA role.

---

## Interview Types

### 1. Behavioral Interviews

**What they test:** Past behavior predicts future behavior

**Framework:** STAR Method

| Component     | What to Include               |
| ------------- | ----------------------------- |
| **S**ituation | Context, your role, timeline  |
| **T**ask      | What you were responsible for |
| **A**ction    | Specific steps YOU took       |
| **R**esult    | Quantified outcome, learnings |

---

#### Common Behavioral Questions

1. **Tell me about a time you had to prioritize competing demands.**

**Strong Answer Structure:**

> **Situation:** "At [Company], I was PM for a product with 3 stakeholders pushing for urgent features simultaneously—Sales wanted a CRM integration, Support wanted a ticket export, and Legal needed a compliance update."
>
> **Task:** "I had to decide which to prioritize with only 2 weeks of engineering capacity."
>
> **Action:** "I used RICE scoring to objectively evaluate each. Compliance had highest impact (blocked $2M deal), medium reach, high confidence, and lowest effort. I presented data to stakeholders, got alignment, and sequenced: Compliance first, CRM second, Export deferred."
>
> **Result:** "Shipped compliance in 1 week, unblocked the deal, and CRM followed. Sales initially pushed back but accepted when I showed the $2M at stake."

---

2. **Tell me about a time you failed.**

**Key:** Show self-awareness and learning

> "I launched a feature without sufficient user research. The feature had low adoption (15% vs 60% target). I learned to always validate with 5+ user interviews before committing engineering resources. Since then, my feature adoption rate is consistently 70%+."

---

3. **Tell me about a conflict with a stakeholder.**

**Key:** Focus on resolution, not blame

> "Engineering estimated 8 weeks for a feature I quoted to executives as 4 weeks. Instead of forcing the timeline, I dug into concerns, found we could descope 2 nice-to-have elements, and negotiated 5 weeks. Both sides felt heard."

---

### 2. Product Sense Interviews

**What they test:** How you think about products, users, and business

---

#### Question Type 1: Product Design

**"Design a product for [X]"**

**Framework:**

1. **Clarify** - Ask questions (who, what, why)
2. **Users** - Define 2-3 personas
3. **Pain Points** - List top problems
4. **Prioritize** - Pick 1 problem to solve first
5. **Solutions** - Brainstorm 3 solutions
6. **Recommend** - Pick one, explain tradeoffs
7. **Metrics** - How would you measure success?

**Example:** "Design a parking app for a city"

> "Let me clarify—is this for drivers finding spots, or for the city to manage parking revenue? [Answer: Drivers]"
>
> **Personas:** Daily commuters, occasional visitors, delivery drivers
>
> **Pain Points:** Can't find spots, don't know prices, forget where parked
>
> **Prioritize:** Finding spots (highest frequency, universal)
>
> **Solutions:** (A) Real-time spot availability map, (B) Reservation system, (C) AI prediction
>
> **Recommend:** Start with (A) availability map—lowest effort, broadest impact
>
> **Metrics:** Time to find parking (reduce from 15 min → 5 min)

---

#### Question Type 2: Product Improvement

**"How would you improve [existing product]?"**

**Framework:**

1. **Clarify** - What part? For whom?
2. **Understand** - Current user journey
3. **Identify** - 3 friction points
4. **Prioritize** - Pick highest-impact opportunity
5. **Propose** - 2-3 solutions
6. **Trade-offs** - Pros/cons of each
7. **Metrics** - Success criteria

**Example:** "How would you improve Instagram?"

> "I'll focus on improving content creator retention on Instagram."
>
> **Pain Points:** Hard to grow audience, unclear analytics, competition from TikTok
>
> **Prioritize:** Unclear analytics (actionable, buildable)
>
> **Solution:** "Creator Insights Dashboard" showing content performance trends
>
> **Metrics:** Creator posting frequency (+10%), Creator churn (-5%)

---

### 3. Technical Interviews

**For PM roles at technical companies**

---

#### Question Type 1: System Design (High-Level)

**"How would you design [system]?"**

**Framework:**

1. **Requirements** - Functional and non-functional
2. **Components** - Frontend, backend, database
3. **Data Flow** - How data moves through system
4. **Scale** - How it handles growth
5. **Trade-offs** - CAP theorem, etc.

**Example:** "Design a URL shortener"

> **Requirements:**
>
> - Functional: Shorten URL, redirect, track clicks
> - Non-functional: <100ms redirect, 99.9% uptime
>
> **Components:**
>
> - API: POST /shorten, GET /{shortCode}
> - Database: Key-value store (shortCode → originalURL)
> - Cache: Redis for hot URLs
>
> **Data Flow:** User hits short URL → Load balancer → Cache check → DB lookup → Redirect
>
> **Scale:** 1 billion URLs, 10k requests/sec → Shard by shortCode hash

---

#### Question Type 2: API Design

**"Design an API for [feature]"**

**Example:** "Design an API for booking a restaurant table"

> ```
> POST /api/v1/bookings
> {
>   "restaurant_id": 42,
>   "date": "2026-02-15",
>   "time": "19:00",
>   "party_size": 4,
>   "customer": {
>     "name": "John Doe",
>     "phone": "+15551234567",
>     "email": "john@example.com"
>   }
> }
>
> Response 201:
> {
>   "booking_id": 12345,
>   "confirmation_code": "ABC123",
>   "status": "confirmed"
> }
> ```

---

### 4. Estimation Interviews (Fermi Problems)

**"How many [X] are in [Y]?"**

**Framework:**

1. **Clarify** scope
2. **Break down** into smaller, estimable pieces
3. **Estimate** each piece with reasoning
4. **Calculate** final answer
5. **Sanity check** - does it seem reasonable?

**Example:** "How many piano tuners are in New York City?"

> **Breakdown:**
>
> - NYC population: 8 million
> - Households: 8M / 2.5 people = 3.2M households
> - % with pianos: 5% = 160,000 pianos
> - Tunings per piano per year: 2
> - Total tunings: 320,000/year
> - Tunings per tuner per day: 4
> - Working days: 250
> - Tunings per tuner per year: 1,000
> - **Piano tuners needed: 320,000 / 1,000 = 320 tuners**

---

### 5. Case Study Interviews

**30-60 minute deep dive into a business problem**

**Framework:**

1. **Read carefully** - Understand all provided data
2. **Structure** - Break problem into components
3. **Analyze** - Use data to support conclusions
4. **Recommend** - Clear action with tradeoffs
5. **Present** - Communicate clearly

**Example Case:** "Booking conversion dropped 20% last month. Diagnose and recommend."

> **Structure:**
>
> - Acquisition: Traffic down? → Check analytics
> - Activation: Funnel drop-off? → Check step-by-step conversion
> - Technical: Bugs? → Check error logs
> - External: Seasonality? Competition?
>
> **Analysis:**
>
> - Found: 80% of drop-off at payment step
> - Root cause: New credit card form has higher abandonment
> - Evidence: Form introduced March 1, drop started March 1
>
> **Recommendation:** Revert to old form, A/B test improvements

---

## PM vs BA Interview Differences

| Aspect          | PM Interview                     | BA Interview                         |
| --------------- | -------------------------------- | ------------------------------------ |
| **Focus**       | Vision, strategy, prioritization | Requirements, process, documentation |
| **Common Q**    | "How would you prioritize...?"   | "How do you gather requirements?"    |
| **Technical**   | System design, metrics           | Data modeling, SQL, process mapping  |
| **Deliverable** | PRD discussion                   | BRD/FSD walkthrough                  |

---

## Questions to Ask Interviewers

### About the Role

- "What does success look like in the first 90 days?"
- "What's the biggest challenge the team is facing?"
- "How does PM/BA collaborate with engineering here?"

### About the Product

- "What's the current North Star metric?"
- "What's on the roadmap for the next quarter?"
- "What's a recent feature that didn't work as expected?"

### About the Team

- "How large is the product team?"
- "What's the PM-to-engineer ratio?"
- "How are decisions made when there's disagreement?"

---

## Red Flags to Watch For

⚠️ **"We don't really have a product process"** - May mean chaos  
⚠️ **"The PM does everything"** - Burnout risk  
⚠️ **"We're pre-product-market fit"** - High ambiguity, may not suit everyone  
⚠️ **High turnover in PM team** - Ask why

---

## Practice Resources

### Mock Interview Platforms

- [Exponent](https://www.tryexponent.com) - PM interview prep
- [Pramp](https://www.pramp.com) - Free peer practice
- [IGotAnOffer](https://igotanoffer.com) - Case studies

### Reading

- _Cracking the PM Interview_ by Gayle Laakmann McDowell
- _Decode and Conquer_ by Lewis Lin
- _The Product Book_ by Product School

---

## 30-Day Interview Prep Plan

| Week       | Focus           | Activities                             |
| ---------- | --------------- | -------------------------------------- |
| **Week 1** | Behavioral      | Write 10 STAR stories, practice aloud  |
| **Week 2** | Product Sense   | 1 product design + 1 improvement daily |
| **Week 3** | Technical       | API design, metrics, basic SQL         |
| **Week 4** | Mock Interviews | 3 mock interviews, refine weak areas   |

---

[⬅️ Back to Portfolio](../README.md) | [Resume Templates →](resume-templates.md)
