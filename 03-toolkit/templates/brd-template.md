# Business Requirements Document (BRD) Template

**Use this template to document business requirements for any project.**

---

## Document Control

| Field              | Value                                |
| ------------------ | ------------------------------------ |
| **Document Owner** | [Your Name, Role]                    |
| **Project Name**   | [Project Name]                       |
| **Version**        | [1.0]                                |
| **Status**         | [Draft / Under Review / Approved]    |
| **Last Updated**   | [Date]                               |
| **Approvers**      | [List stakeholders who must approve] |

---

## 1. Executive Summary

[3-4 sentences summarizing the entire document. Answer: What are we building, why, and what's the expected outcome?]

**Example:**

> This BRD proposes building a mobile-responsive restaurant reservation platform to connect diners with casual dining restaurants. The platform addresses a $17B annual loss from no-shows by implementing a deposit system. Expected outcome: Onboard 500 restaurants in Year 1, generate $1.2M revenue, and achieve <5% no-show rate.

---

## 2. Business Problem

**Current State:**  
[Describe the pain point or gap that exists today]

**Impact:**  
[Quantify the problem - revenue lost, time wasted, customer complaints, etc.]

**Example:**

> **Current State:** Diners spend 5+ minutes on hold when booking restaurants via phone, and receive no confirmation, causing anxiety.  
> **Impact:** 30% of reservations are no-shows, costing the US restaurant industry $17 billion annually.

---

## 3. Business Objectives

[List 3-5 SMART goals: Specific, Measurable, Achievable, Relevant, Time-bound]

| #   | Objective                  | Success Metric          | Target            | Timeline  |
| --- | -------------------------- | ----------------------- | ----------------- | --------- |
| 1   | [What you want to achieve] | [How you'll measure it] | [Specific number] | [By when] |
| 2   |                            |                         |                   |           |
| 3   |                            |                         |                   |           |

**Example:**
| # | Objective | Success Metric | Target | Timeline |
|---|-----------|---------------|--------|----------|
| 1 | Establish presence in NYC casual dining market | Restaurants onboarded | 500 | Year 1 |
| 2 | Drive booking volume | Monthly Active Bookers (MAB) | 15,000 | Month 12 |
| 3 | Generate revenue | Gross Booking Value (GBV) | $12M | Year 1 |

---

## 4. Stakeholder Analysis

### Primary Stakeholders

| Stakeholder | Interest               | Influence (Low/Med/High)   | Engagement Strategy        |
| ----------- | ---------------------- | -------------------------- | -------------------------- |
| [Name/Role] | [What they care about] | [How much power they have] | [How often to communicate] |

**Example:**
| Stakeholder | Interest | Influence | Engagement Strategy |
|-------------|----------|----------|---------------------|
| Restaurant Owners | Reduce no-shows, fill tables | High | Weekly check-ins, dedicated support |
| Diners (End Users) | Convenient booking | Medium | NPS surveys, user research |
| Engineering Team | Technical feasibility | High | Daily standups, involve in scoping |

### RACI Matrix (Optional)

[For key decisions, clarify who is Responsible, Accountable, Consulted, Informed]

---

## 5. Scope

### In-Scope (What We're Building)

✅ [Feature/Capability 1]  
✅ [Feature/Capability 2]  
✅ [Feature/Capability 3]

**Example:**
✅ Guest users can search restaurants and book tables  
✅ SMS confirmation sent within 30 seconds  
✅ Deposit required for parties of 6+ to reduce no-shows

---

### Out-of-Scope (Explicitly NOT Included)

❌ [Feature/Capability that is deferred]  
❌ [Feature/Capability that is explicitly excluded]

**Example:**
❌ Native mobile apps (iOS/Android) → v2.0  
❌ Restaurant reviews/ratings → v2.5  
❌ Loyalty points program → TBD

---

## 6. Requirements

### Business Requirements

[High-level business needs]

**BR-001: [Requirement Title]**  
**Description:** [What is needed and why]  
**Rationale:** [Business justification]  
**Success Criteria:** [How we'll know it's successful]

**Example:**
**BR-001: Revenue Model**  
**Description:** Platform shall generate revenue through a 10% commission on completed bookings.  
**Rationale:** Industry standard is 15-20%; our lower rate is competitive for market entry.  
**Success Criteria:** $1.2M revenue in Year 1 (10,000 bookings × $120 avg × 10%)

---

### User Requirements

[What users need to accomplish their goals]

**Persona 1: [Name]**

- **Need 1:** [What they must be able to do]
- **Need 2:**

**Example:**
**Persona: Busy Diner**

- Book a table in <60 seconds on mobile
- Receive instant SMS confirmation
- Modify reservation up to 2 hours before

---

### Functional Requirements

[Specific system behaviors - usually derives from user requirements]

**FR-001:** System shall allow users to search restaurants by cuisine and location  
**FR-002:** System shall display real-time table availability  
**FR-003:** System shall send SMS confirmation within 30 seconds of booking

---

### Non-Functional Requirements

[Quality attributes: performance, security, scalability]

**NFR-001: Performance**

- Page load time < 2 seconds on 4G connection
- API response time < 500ms (p95)

**NFR-002: Security**

- PCI DSS Level 1 compliant (credit card data encrypted)
- HTTPS only, no plain HTTP

**NFR-003: Availability**

- 99.5% uptime (measured monthly)

---

## 7. Success Criteria

### Definition of Done (Launch Readiness)

- [ ] [Criteria 1: e.g., 50 restaurants onboarded]
- [ ] [Criteria 2: e.g., 0 P0 bugs in UAT]
- [ ] [Criteria 3: e.g., Security audit passed]

---

### Key Performance Indicators (KPIs)

| KPI           | Baseline        | Target (Month 3) | Measurement Method |
| ------------- | --------------- | ---------------- | ------------------ |
| [Metric name] | [Current value] | [Goal]           | [How tracked]      |

**Example:**
| KPI | Baseline | Target (Month 3) | Measurement |
|-----|----------|------------------|-------------|
| Booking Conversion Rate | 0% (new product) | 20% | (Bookings / Restaurant Views) × 100 |
| No-Show Rate | 30% (industry avg) | <10% | SQL query on bookings table |

---

## 8. Assumptions & Constraints

### Assumptions

[Things you're assuming to be true - if wrong, the plan changes]

1. [Assumption 1]
2. [Assumption 2]

**Example:**

1. Restaurants have wi-fi/tablets to manage reservations in real-time
2. Customers have smartphones for SMS confirmations
3. Stripe payment gateway remains available

---

### Constraints

[Limitations you must work within]

| Constraint   | Impact                       | Mitigation                  |
| ------------ | ---------------------------- | --------------------------- |
| [Limitation] | [How it affects the project] | [How you'll work around it] |

**Example:**
| Constraint | Impact | Mitigation |
|------------|--------|------------|
| Budget: $450k total | Can't build native apps in v1 | Mobile-responsive web app |
| Timeline: 6 months | Must prioritize ruthlessly | MoSCoW framework for features |

---

## 9. Risks & Mitigation

| Risk                  | Probability  | Impact       | Mitigation Strategy               |
| --------------------- | ------------ | ------------ | --------------------------------- |
| [What could go wrong] | Low/Med/High | Low/Med/High | [How you'll prevent or handle it] |

**Example:**
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Restaurants refuse 10% commission | Medium | High | Offer first 3 months free, tiered pricing |
| SMS gateway fails (Twilio downtime) | Low | Medium | Email fallback, monitor delivery rates |

---

## 10. Dependencies

### External Dependencies

- **Dependency 1:** [What you rely on from outside parties]
  - Vendor/Partner: [Who]
  - Impact if delayed: [What happens]

**Example:**

- **Twilio API:** SMS delivery
  - Vendor: Twilio
  - Impact if delayed: No SMS confirmations → poor UX, fall back to email

---

### Internal Dependencies

- [Team/Department] must deliver [deliverable] by [date]

**Example:**

- Engineering must deliver API by Month 4
- Legal must approve Terms of Service by Month 3

---

## 11. Open Questions

[Issues that need stakeholder decisions before you can proceed]

1. **Question:** [What needs to be decided?]  
   **Options:**
   - Option A: [Description, pros/cons]
   - Option B: [Description, pros/cons]  
     **Recommendation:** [Your suggested answer]  
     **Decision Owner:** [Who decides]  
     **Decision Deadline:** [By when]

**Example:**

1. **Question:** Should deposit be $10 flat or $10/person?  
   **Options:**
   - A: $10 flat (simpler, less friction)
   - B: $10/person (scales with party size)  
     **Recommendation:** Option A for v1, test and iterate  
     **Decision Owner:** VP Product  
     **Deadline:** Feb 15, 2026

---

## 12. Approval

| Role                  | Name | Signature | Date |
| --------------------- | ---- | --------- | ---- |
| Product Owner         |      |           |      |
| Engineering Lead      |      |           |      |
| Finance/CFO           |      |           |      |
| Legal (if applicable) |      |           |      |

---

## 13. Appendices

### Appendix A: Market Research

[Link to detailed research findings, personas, competitive analysis]

### Appendix B: User Personas

[Link or embed persona profiles]

### Appendix C: Glossary

[Define technical terms or acronyms]

---

[⬅️ Back to Toolkit](../README.md)
