# Definition of Ready (DoR)

**Purpose:** Checklist to ensure user stories are ready for sprint planning.

---

## What is Definition of Ready?

A user story is **"Ready"** when it meets all criteria below. Only ready stories should be brought into sprint planning.

**Why it matters:** Prevents wasted time discussing incomplete stories, reduces mid-sprint surprises.

---

## DoR Checklist

### 1. Story is Properly Formatted

- [ ] Follows INVEST criteria (Independent, Negotiable, Valuable, Estimable, Small, Testable)
- [ ] Written from user's perspective: "As a [persona], I want [goal], so that [benefit]"
- [ ] Has a clear title (concise, descriptive)

---

### 2. Acceptance Criteria Defined

- [ ] Acceptance criteria written in **GIVEN-WHEN-THEN** format
- [ ] At least 3 acceptance criteria (covers happy path + edge cases)
- [ ] Criteria are specific and testable (not vague)

**Example:**

- ❌ Bad: "User can book a table"
- ✅ Good: "GIVEN availability exists, WHEN user selects 7pm and clicks 'Book', THEN confirmation page displays within 3 seconds"

---

### 3. Business Value is Clear

- [ ] Story answers: "Why are we building this?"
- [ ] Success metric defined (e.g., "Reduce cancellation rate by 5pp")
- [ ] Linked to business objective or OKR

---

### 4. Dependencies Identified

- [ ] Technical dependencies documented (e.g., "Requires API endpoint XYZ")
- [ ] External dependencies noted (e.g., "Waiting for Stripe approval")
- [ ] No blockers exist (or blockers have mitigation plan)

---

### 5. Design Assets Available (if UI work)

- [ ] Wireframes or mockups approved by stakeholders
- [ ] Design system components specified (buttons, forms, colors)
- [ ] Mobile and desktop designs provided

---

### 6. Technical Feasibility Confirmed

- [ ] Engineering team reviewed and confirmed it's possible
- [ ] Spike completed (if uncertainty existed)
- [ ] Technical approach agreed upon (no debates mid-sprint)

---

### 7. Estimated by the Team

- [ ] Story points assigned (Fibonacci scale: 1, 2, 3, 5, 8)
- [ ] Team consensus on estimate (no one thinks it's "way off")
- [ ] If 8+ points → Story should be split into smaller stories

---

### 8. Test Cases Defined (Optional, but Recommended)

- [ ] QA has reviewed and understands how to test
- [ ] Edge cases identified (e.g., invalid input, concurrency)
- [ ] Test data requirements documented

---

## Example: Ready vs Not Ready

### ❌ NOT Ready

**User Story:** "As a user, I want to modify my booking"

**Problems:**

- No acceptance criteria
- Not specific (modify time? party size? both?)
- No designs
- Not estimated

---

### ✅ Ready

**User Story:** "As a diner, I want to change my reservation time, so I can adjust if my plans change"

**Acceptance Criteria:**

- GIVEN I have a booking >2 hours away, WHEN I click "Modify" and select a new time, THEN my booking is updated and I receive SMS confirmation within 30 seconds
- GIVEN new time is unavailable, WHEN I try to modify, THEN I see error "This time is no longer available" with list of alternatives
- GIVEN booking is <2 hours away, WHEN I click "Modify", THEN I see error "Cannot modify within 2 hours of booking time"

**Business Value:** Reduce cancellations from 15% → 10% (users cancel because they can't easily change details)

**Dependencies:** PATCH /api/v1/bookings/{id} endpoint (in progress, Sprint 14)

**Design:** [Figma link to modify modal]

**Estimate:** 5 points

**Test Cases:** Drafted in TC-MOD-001 through TC-MOD-005

---

## Who Enforces DoR?

**Product Owner:** Responsible for ensuring stories meet DoR before sprint planning

**Scrum Master:** Facilitates refinement sessions, coaches team on DoR

**Team:** Can reject stories that aren't ready ("Let's defer this until next sprint when designs are done")

---

## When to Check DoR?

**During Backlog Refinement (Mid-Sprint):**

- Team reviews upcoming stories
- Identifies gaps (missing designs, unclear acceptance criteria)
- Product Owner fills gaps before sprint planning

**At Sprint Planning:**

- Final check: "Are these stories ready to commit to?"
- If NO → Defer to backlog, bring in a different story

---

[⬅️ Back to Toolkit](../README.md) | [Definition of Done →](definition-of-done.md)
