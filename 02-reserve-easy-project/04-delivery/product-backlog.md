# ReserveEasy Product Backlog

**Last Updated:** February 8, 2026  
**Product Owner:** [Your Name]  
**Team Velocity:** ~21 story points per 2-week sprint

---

## Backlog Structure

This backlog is prioritized using the **MoSCoW** method combined with **RICE scoring**.

**Legend:**

- **Status:** 🚀 In Progress | ✅ Done | 📝 Ready | 💡 Needs Refinement
- **Priority:** P0 (Must-Have) | P1 (Should-Have) | P2 (Nice-to-Have)
- **Story Points:** Fibonacci scale (1, 2, 3, 5, 8, 13, 21)

---

## Sprint 15 (Current) - Goal: Enable Booking Modifications

| Status | ID     | User Story                                                                                                | Priority | Points | Assignee |
| ------ | ------ | --------------------------------------------------------------------------------------------------------- | -------- | ------ | -------- |
| 🚀     | US-045 | As a diner, I want to change my reservation time, so I can adjust if my plans change                      | P0       | 8      | Alex     |
| 🚀     | US-046 | As a diner, I want to increase my party size, so I can accommodate an extra guest                         | P0       | 5      | Maya     |
| 📝     | US-047 | As a restaurant manager, I want to see modification requests, so I can approve/deny based on availability | P0       | 8      | Jordan   |

**Sprint Commitment:** 21 points

---

## Upcoming Sprints (Sprint 16-18)

### Epic 1: Guest Booking Flow (Must-Have for MVP)

#### US-001: Search Restaurants

**As a** diner,  
**I want** to search for restaurants by cuisine and location,  
**So that** I can find a place that matches my preferences.

**Acceptance Criteria:**

- GIVEN I'm on the homepage
- WHEN I enter "Italian" in cuisine and "Manhattan" in location
- THEN I see a list of Italian restaurants in Manhattan sorted by relevance
- AND I can filter by price range ($, $$, $$$, $$$$)
- AND I can sort by distance, rating, or availability

**Priority:** P0 (MVP blocker)  
**Story Points:** 8  
**RICE Score:** 3200 (Reach: 10,000 | Impact: 3 | Confidence: 100% | Effort: 2.5 weeks)  
**Status:** 📝 Ready

---

#### US-002: View Restaurant Details

**As a** diner,  
**I want** to see restaurant photos, menu, and reviews,  
**So that** I can decide if it's a good fit before booking.

**Acceptance Criteria:**

- GIVEN I click on a restaurant from search results
- WHEN the restaurant page loads
- THEN I see name, address, phone, cuisine type, price range
- AND I see at least 3 photos (or placeholder if unavailable)
- AND I see hours of operation
- AND I see a "Check Availability" button

**Priority:** P0  
**Story Points:** 5  
**Status:** 📝 Ready  
**Dependencies:** US-001 (Search must exist first)

---

#### US-003: Check Real-Time Availability

**As a** diner,  
**I want** to see which time slots are available on my desired date,  
**So that** I can pick a time that works for me.

**Acceptance Criteria:**

- GIVEN I select a date and party size on the restaurant page
- WHEN I click "Check Availability"
- THEN I see available time slots in 30-minute increments (e.g., 17:00, 17:30, 18:00)
- AND unavailable slots are grayed out or hidden
- AND I can select a different date to check other days

**Technical Notes:**

- Query `bookings` table to calculate available capacity
- Implement optimistic locking to prevent double-bookings
- Cache availability for 30 seconds to reduce DB load

**Priority:** P0  
**Story Points:** 13 (Complex - involves real-time DB queries)  
**Status:** 💡 Needs Refinement (Discuss caching strategy)

---

#### US-004: Create Booking (Guest)

**As a** guest diner (not logged in),  
**I want** to complete a booking without creating an account,  
**So that** I can reserve quickly without friction.

**Acceptance Criteria:**

- GIVEN I selected a time slot
- WHEN I click "Book This Time"
- THEN I see a form with fields: Name, Email, Phone, Special Requests (optional)
- AND all fields validate (email format, phone format)
- WHEN I submit
- THEN I see a confirmation page with booking details and confirmation code
- AND I receive an SMS within 30 seconds

**Priority:** P0  
**Story Points:** 8  
**Status:** 📝 Ready

---

#### US-005: SMS Confirmation

**As a** diner,  
**I want** to receive SMS confirmation immediately after booking,  
**So that** I have proof of my reservation and peace of mind.

**Acceptance Criteria:**

- GIVEN I complete a booking
- WHEN payment/booking is confirmed
- THEN I receive an SMS within 30 seconds to my provided phone number
- AND the SMS includes: restaurant name, date, time, party size, confirmation code
- AND the SMS includes a link to view/modify the booking

**Technical Notes:**

- Integrate Twilio SMS API
- Handle SMS delivery failures gracefully (retry 3 times, then fallback to email)
- Log delivery status to `bookings` table (`sms_sent`, `sms_delivered`)

**Priority:** P0  
**Story Points:** 5  
**Status:** 📝 Ready  
**Dependencies:** US-004

---

### Epic 2: Reservation Management (Should-Have for MVP)

#### US-006: View My Reservations

**As a** registered diner,  
**I want** to see a list of my upcoming and past reservations,  
**So that** I can keep track of where I'm dining.

**Priority:** P1  
**Story Points:** 5  
**Status:** 📝 Ready

---

#### US-007: Cancel Booking

**As a** diner,  
**I want** to cancel my reservation,  
**So that** I can free up the table if my plans change.

**Acceptance Criteria:**

- GIVEN I have an upcoming booking
- WHEN I click "Cancel Reservation"
- THEN I see a confirmation dialog: "Are you sure? This cannot be undone"
- WHEN I confirm
- THEN booking status changes to "cancelled"
- AND I receive an SMS: "Your reservation at [restaurant] on [date] has been cancelled"
- AND if I paid a deposit >24 hours before, it's refunded within 3-5 business days

**Business Rules:**

- Cancellations >24 hours before: full refund
- Cancellations 2-24 hours before: 50% refund
- Cancellations <2 hours before: no refund

**Priority:** P0  
**Story Points:** 8  
**Status:** 📝 Ready

---

### Epic 3: Deposit System (Should-Have for MVP)

#### US-010: Require Deposit for Large Parties

**As a** restaurant manager,  
**I want** to collect a $10/person deposit for parties of 6+,  
**So that** I reduce the financial risk of no-shows.

**Acceptance Criteria:**

- GIVEN a diner is booking for 6+ people
- WHEN they reach the payment step
- THEN they see: "Deposit required: $60 (refundable if you show up)"
- AND they can pay via Stripe (credit card)
- AND deposit is refunded automatically when booking is marked "completed"

**Priority:** P1  
**Story Points:** 13 (Involves Stripe integration, refund logic)  
**Status:** 💡 Needs Refinement

---

### Epic 4: Restaurant Partner Dashboard (Should-Have)

#### US-015: View Upcoming Reservations (Restaurant)

**As a** restaurant manager,  
**I want** to see today's and tomorrow's reservations in a dashboard,  
**So that** I can plan staffing and table assignments.

**Acceptance Criteria:**

- GIVEN I log into the restaurant portal
- WHEN I navigate to "Reservations"
- THEN I see a list of upcoming bookings sorted by time
- AND each booking shows: time, party size, customer name, phone, special requests
- AND I can filter by date

**Priority:** P1  
**Story Points:** 5  
**Status:** 📝 Ready

---

#### US-016: Mark Booking as No-Show

**As a** restaurant host,  
**I want** to mark a booking as "no-show" if the diner doesn't arrive,  
**So that** we can track no-show rates and penalize repeat offenders.

**Priority:** P1  
**Story Points:** 3  
**Status:** 📝 Ready

---

#### US-017: View Analytics (No-Show Rate)

**As a** restaurant manager,  
**I want** to see my no-show rate over the last 30 days,  
**So that** I can measure the impact of ReserveEasy.

**Acceptance Criteria:**

- GIVEN I navigate to "Analytics"
- THEN I see a chart showing no-show % by week
- AND I see the total number of no-shows vs confirmed bookings

**Priority:** P2  
**Story Points:** 8 (Involves charting library, SQL queries)  
**Status:** 💡 Needs Refinement

---

## Icebox (Low Priority / Future Consideration)

These features have been deprioritized but may be revisited:

| ID     | User Story                                             | Reason for Deferral                          |
| ------ | ------------------------------------------------------ | -------------------------------------------- |
| US-050 | As a diner, I want to leave a review after dining      | Not core to booking flow; can add in v2      |
| US-051 | As a diner, I want to earn loyalty points for bookings | Complex, requires separate points system; v3 |
| US-052 | As a diner, I want to join a waitlist if fully booked  | MVP focuses on reservations only; v2.5       |

---

## Backlog Refinement Notes

**Last Refinement Session:** Feb 5, 2026

**Key Decisions:**

1. **US-003 (Availability):** Decided to implement 30-second caching to balance real-time accuracy with performance
2. **US-010 (Deposits):** Deferred to Sprint 17 due to Stripe integration complexity
3. **US-017 (Analytics):** Moved to P2 after discussing with stakeholders; nice-to-have but not MVP blocker

**Next Refinement:** Feb 12, 2026 (mid-Sprint 15)

---

## RICE Scoring Matrix (Sample)

| Story                   | Reach (users/mo) | Impact (1-3) | Confidence (%) | Effort (weeks) | RICE Score |
| ----------------------- | ---------------- | ------------ | -------------- | -------------- | ---------- |
| US-001 (Search)         | 10,000           | 3 (Massive)  | 100%           | 2              | 3,200      |
| US-003 (Availability)   | 8,000            | 3 (Massive)  | 80%            | 3              | 2,133      |
| US-004 (Create Booking) | 8,000            | 3 (Massive)  | 100%           | 2              | 4,000      |
| US-017 (Analytics)      | 500              | 1 (Low)      | 70%            | 2              | 175        |

**Prioritization Rule:** Sort by RICE score descending → build highest-value features first.

---

## Definition of Ready (for a story to enter a sprint)

- [ ] Acceptance criteria defined
- [ ] Story points estimated by team
- [ ] Dependencies identified
- [ ] Design mockups attached (if UI change)
- [ ] Technical approach discussed
- [ ] No blockers

---

## Definition of Done (for a story to be considered complete)

- [ ] Code written and peer-reviewed
- [ ] Unit tests passing (>80% coverage)
- [ ] Manual testing completed (QA sign-off)
- [ ] Documentation updated (API docs, README)
- [ ] Deployed to staging and verified
- [ ] Product Owner accepted

---

[← Back to Project](../README.md) | [Sprint Plans →](sprints/) | [Analytics →](../05-analytics/)
