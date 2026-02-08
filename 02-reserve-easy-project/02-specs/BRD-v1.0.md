# Business Requirements Document (BRD)

# ReserveEasy v1.0

**Document Owner:** Product Management Team  
**Status:** Approved  
**Version:** 1.0  
**Last Updated:** February 1, 2026

---

## Executive Summary

**Project Name:** ReserveEasy

**Purpose:** Build a two-sided marketplace connecting diners with restaurants for seamless, guaranteed table reservations.

**Business Problem:**

- **For Diners:** Booking restaurant tables requires 5+ minutes of phone calls, often during work hours, with no confirmation
- **For Restaurants:** 30% no-show rate costs the US restaurant industry $17 billion annually

**Proposed Solution:** A mobile-optimized web platform where diners can book instantly with SMS confirmation, and restaurants capture deposits to reduce no-shows.

**Expected Outcome:**

- **Year 1:** Onboard 500 restaurants, facilitate 120,000 bookings, generate $1.2M revenue
- **Impact for Diners:** Reduce booking time from 5 minutes to <60 seconds
- **Impact for Restaurants:** Reduce no-shows from 30% to <5%

**Investment Required:** $450k (6 engineers × 6 months + marketing)

**ROI:** Break-even in Month 9, 3x return by end of Year 2

---

## Business Objectives

| #   | Objective                                      | Success Metric                  | Target (Year 1) |
| --- | ---------------------------------------------- | ------------------------------- | --------------- |
| 1   | Establish market presence in NYC casual dining | Restaurants onboarded           | 500             |
| 2   | Drive booking volume                           | Monthly active bookers (MAB)    | 15,000          |
| 3   | Generate revenue                               | Gross booking value (GBV)       | $12M            |
| 4   | Build sustainable unit economics               | Customer Acquisition Cost (CAC) | <$30            |
| 5   | Achieve product-market fit                     | Net Promoter Score (NPS)        | >40             |

---

## Stakeholder Analysis

### Primary Stakeholders

| Stakeholder            | Interest                        | Influence | Engagement Strategy                                                |
| ---------------------- | ------------------------------- | --------- | ------------------------------------------------------------------ |
| **Restaurant Owners**  | Reduce no-shows, fill tables    | High      | Weekly check-ins, dedicated support, incentives for early adopters |
| **Diners (Customers)** | Convenient booking              | Medium    | User research, NPS surveys, referral program                       |
| **Investors**          | ROI, growth trajectory          | High      | Monthly board updates, transparent metrics dashboard               |
| **Engineering Team**   | Technical feasibility, workload | High      | Involve in scoping, clear priorities, no scope creep               |

### Secondary Stakeholders

- **Legal/Compliance:** GDPR, payment security (PCI DSS)
- **Finance:** Revenue recognition, accounting for commissions
- **Customer Support:** FAQs, escalation procedures

---

## Scope

### In-Scope (MVP - v1.0)

✅ **For Diners:**

- Search restaurants by cuisine, location, price
- View real-time table availability
- Book tables as guest or registered user
- Receive SMS confirmation
- Modify/cancel reservations (up to 2 hours before)
- Pay $10 deposit for parties of 6+ (refunded on completion)

✅ **For Restaurants:**

- Partner dashboard to manage table inventory
- View upcoming reservations
- Manual table assignment
- Analytics: no-show rate, peak hours, average party size

✅ **Technical:**

- Web application (mobile-responsive)
- PostgreSQL database
- Stripe payment processing
- Twilio SMS integration
- AWS hosting

---

### Out-of-Scope (Future Roadmap)

❌ **V1.0 Will NOT Include:**

- Native mobile apps (iOS/Android) → v2.0
- Waitlist management → v2.0
- Restaurant reviews/ratings → v2.5
- Multi-party bookings (coordinating groups) → v3.0
- Integration with POS systems → v3.0
- Loyalty points program → TBD based on user feedback

---

## User Requirements

### Primary Persona: Busy Diner Sarah

- Age: 28, Marketing Professional
- Location: Manhattan
- Tech-Savvy: Uses apps for everything (Uber, Seamless, Spotify)

**Jobs to Be Done:**

1. "When planning dinner with friends, I want guaranteed seating so I avoid the embarrassment of not getting a table."
2. "When my plans change, I want to modify my reservation quickly so I don't lose my booking."
3. "When I book, I want instant confirmation so I don't worry whether it went through."

**Pain Points:**

- Calling restaurants wastes 10 minutes during workday
- No confirmation → anxiety
- Hard to modify reservations (have to call back)

---

### Secondary Persona: Restaurant Manager Raj

- Age: 42, Manages 50-seat Bistro in Brooklyn
- Revenue Focus: $500k annual, $200k profit
- Challenge: 30% no-show rate = $60k lost revenue/year

**Jobs to Be Done:**

1. "When managing my floor, I want to maximize table turnover so I can serve more customers and increase revenue."
2. "When a customer no-shows, I want to minimize financial impact so my margins don't suffer."
3. "When analyzing performance, I want historical data on peak hours so I can staff appropriately."

**Pain Points:**

- Phone interruptions during dinner rush
- No way to enforce no-show penalties
- Lost revenue from empty tables

---

## Business Requirements

### BR-001: Revenue Model

**Requirement:** The platform shall generate revenue through a 10% commission on completed bookings.

**Rationale:** Industry standard (OpenTable charges 15-20%). Our lower rate is competitive for market entry.

**Formula:**

```
Revenue = Booking Value × 10%
Example: $50/person × 4 people = $200 → $20 commission
```

**Conditions:**

- Commission charged only if booking is completed (diner shows up)
- Partial commission if party size changes (e.g., booked for 4, showed up with 3)
- Commission waived if restaurant cancels

---

### BR-002: No-Show Reduction

**Requirement:** The platform shall reduce restaurant no-show rates to <5% through deposit requirements and automated reminders.

**Current State:** Industry average is 30% no-shows

**Mechanism:**

1. Require $10/person deposit for parties of 6+ (high-risk bookings)
2. Send SMS reminder 24 hours before booking
3. Send SMS reminder 2 hours before booking
4. Allow easy cancellation (> 24 hours) to avoid unnecessary no-shows

**Success Metric:** Monthly no-show rate < 5%

---

### BR-003: Time-to-Book

**Requirement:** The booking flow shall be completable in <60 seconds on mobile.

**Current State:** Phone booking averages 5 minutes (hold time + questions)

**User Flow:**

1. Search restaurant (10 sec)
2. Select date/time (10 sec)
3. Enter name/email/phone (30 sec)
4. Confirm (10 sec)

**Constraints:**

- Maximum 5 form fields before booking confirmation
- Auto-populate returning user info
- Support Apple Pay / Google Pay for faster payment

---

### BR-004: Availability Accuracy

**Requirement:** Table availability displayed to users shall be accurate within 30 seconds of real-time changes.

**Rationale:** Inaccurate availability → double-bookings or false "sold out" messages → poor UX

**Technical Implementation:**

- Real-time database queries (no caching of availability)
- Optimistic locking to prevent double-bookings
- Graceful fallback if tables booked between viewing and confirming

---

## Success Criteria

### Launch Readiness (Definition of Done for MVP)

**Must-Have:**

- [ ] 50 restaurant partners onboarded with at least 10 tables each
- [ ] Web app passes UAT (User Acceptance Testing) with 0 critical bugs
- [ ] SMS delivery rate > 95%
- [ ] Payment processing functional (test transactions successful)
- [ ] Security audit passed (OWASP Top 10 compliance)
- [ ] Support documentation and FAQs published

**Performance Benchmarks:**

- Page load time < 2 seconds (4G connection)
- Booking API response time < 500ms
- 99.5% uptime during beta period

---

### Post-Launch Success (Month 1-3)

| Metric                   | Target                 | Measurement                                  |
| ------------------------ | ---------------------- | -------------------------------------------- |
| Monthly Active Bookers   | 1,000 → 5,000 → 10,000 | SQL query on bookings table                  |
| Booking Conversion Rate  | >20%                   | (Bookings / Restaurant Views) × 100          |
| Restaurant Retention     | >80%                   | % of restaurants still active after 3 months |
| Customer Support Tickets | <5% of bookings        | Zendesk ticket count / total bookings        |
| No-Show Rate             | <10%                   | SQL: no_show count / total bookings          |

---

## Assumptions & Constraints

### Assumptions

1. **Restaurants have wi-fi/tablets:** Need internet access to manage reservations in real-time
2. **Customers have smartphones:** SMS confirmation requires mobile phone
3. **Stripe available:** Payment processing relies on third-party (Stripe)
4. **Legal cleared:** Business model doesn't violate monopoly/anti-trust laws

**Risk if wrong:** If Assumption #3 fails (Stripe decides to exit restaurant vertical), need backup payment processor (Square, Braintree)

---

### Constraints

| Constraint                                     | Impact                           | Mitigation                                                      |
| ---------------------------------------------- | -------------------------------- | --------------------------------------------------------------- |
| **Budget:** $450k total                        | Can't build native apps in v1    | Mobile-responsive web app (80% of traffic is mobile web anyway) |
| **Timeline:** 6 month deadline                 | Feature scope must stay tight    | MoSCoW prioritization, defer "nice-to-haves"                    |
| **Team:** 6 engineers                          | Limited capacity for experiments | Focus on 1 use case (reservations), not reviews/loyalty         |
| **Regulation:** Must comply with GDPR, PCI DSS | Legal review adds 2 weeks        | Start legal review in Month 2, parallel track                   |

---

## Risks & Mitigation

| Risk                                         | Probability | Impact | Mitigation                                                                     |
| -------------------------------------------- | ----------- | ------ | ------------------------------------------------------------------------------ |
| **Restaurants refuse commission model**      | Medium      | High   | Offer first 3 months free, tiered pricing                                      |
| **Diners don't adopt (prefer calling)**      | Low         | High   | Incentivize with $5 first-booking credit                                       |
| **Technical: SMS gateway fails**             | Low         | Medium | Fallback to email, monitor delivery rates                                      |
| **Competitive: OpenTable undercuts pricing** | Medium      | High   | Differentiate on UX (faster booking), focus on casual dining (not fine dining) |
| **Legal: Payment regulation changes**        | Low         | High   | Engage compliance lawyer, build flexible payment abstraction                   |

---

## Dependencies

### External Dependencies

1. **Stripe API:** Payment processing (deposit collection/refunds)
   - **Risk:** Stripe downtime → Can't process bookings
   - **SLA:** 99.95% uptime per Stripe agreement

2. **Twilio API:** SMS delivery
   - **Risk:** SMS not delivered → Customer anxiety
   - **Fallback:** Email backup notification

3. **Restaurant Partners:** Need to onboard 50 before launch
   - **Risk:** Chicken-and-egg problem (no restaurants → no diners)
   - **Mitigation:** Sales team starts outreach in Month 1

---

### Internal Dependencies

1. **Engineering:** API and database ready by Month 4
2. **Design:** UI mockups approved by Month 2
3. **Legal:** Privacy policy + Terms of Service by Month 3
4. **Marketing:** Landing page live by Month 2 for early signups

---

## Open Questions (For Stakeholder Review)

> [!IMPORTANT]
> **Requires Decision by Feb 15, 2026**

1. **Deposit Amount:** Should it be $10 flat or $10/person?
   - **Option A:** $10 flat (simpler, less friction)
   - **Option B:** $10/person (scales with party size, higher commitment)
   - **Recommendation:** Start with Option A, test and iterate

2. **Cancellation Policy:** How late can a user cancel and still get a refund?
   - **Option A:** 24 hours before (restaurant-friendly)
   - **Option B:** 2 hours before (user-friendly)
   - **Recommendation:** 24 hours (aligns with industry, reduces no-shows)

3. **Free Trial for Restaurants:** Should we waive commission for the first 3 months?
   - **Pro:** Easier to onboard restaurants
   - **Con:** $120k revenue delayed
   - **Recommendation:** First 100 bookings free per restaurant (capped incentive)

---

## Approval

| Role             | Name | Signature    | Date     |
| ---------------- | ---- | ------------ | -------- |
| VP Product       | TBD  | ****\_\_**** | **\_\_** |
| Engineering Lead | TBD  | ****\_\_**** | **\_\_** |
| CFO              | TBD  | ****\_\_**** | **\_\_** |

---

## Appendices

### Appendix A: Market Research Summary

- TAM (Total Addressable Market): $13B US restaurant reservation market
- SAM (Serviceable Available Market): $3B casual dining segment
- SOM (Serviceable Obtainable Market): $50M (Year 1 target: NYC only)

### Appendix B: Competitive Analysis

See [Market Analysis](../01-discovery/market-analysis.md)

### Appendix C: User Research Artifacts

- Persona Profiles: [User Personas](../01-discovery/user-personas.md)
- Interview Notes: `/research/interviews/`

---

[← Back to Project](../README.md) | [Next: Functional Spec →](FSD-booking-mod.md)
