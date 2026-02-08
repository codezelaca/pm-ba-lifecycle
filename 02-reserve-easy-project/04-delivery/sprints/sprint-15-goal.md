# Sprint 15 Goal

**Sprint Duration:** Feb 3 - Feb 16, 2026 (2 weeks)  
**Team Velocity:** 21 story points (avg of last 3 sprints)

---

## Sprint Goal

**"Enable users to modify their reservations"**

This sprint focused on reducing cancellations by letting users change booking details (time, party size) without calling the restaurant.

---

## Committed User Stories

| ID     | User Story                                                   | Points | Assignee | Status         |
| ------ | ------------------------------------------------------------ | ------ | -------- | -------------- |
| US-045 | As a diner, I want to change my reservation time             | 8      | Alex     | ✅ Done        |
| US-046 | As a diner, I want to increase my party size                 | 5      | Maya     | ✅ Done        |
| US-047 | As a restaurant manager, I want to see modification requests | 8      | Jordan   | 🚧 In Progress |

**Total Committed:** 21 points

---

## Technical Tasks Breakdown

### US-045: Change Reservation Time

- [x] Add "Modify" button to booking confirmation page (Frontend - Alex)
- [x] Create `PATCH /api/v1/bookings/{id}` endpoint (Backend - Jordan)
- [x] Check real-time availability before allowing change (Backend - Jordan)
- [x] Send updated SMS confirmation (Backend - Maya)
- [x] Write unit tests (Backend - Jordan)
- [x] UAT test cases (QA - Sam)

---

### US-046: Increase Party Size

- [x] Add party size selector to modify modal (Frontend - Alex)
- [x] Implement deposit adjustment logic (Backend - Maya)
- [x] Integrate Stripe incremental authorization (Backend - Maya)
- [x] Write integration tests (Backend - Maya)

---

### US-047: Restaurant Dashboard Notifications

- [ ] Add "Recent Modifications" section to dashboard (Frontend - Alex)
- [ ] Real-time websocket notification when booking changed (Backend - Jordan)
- [ ] Email notification to restaurant (Backend - Jordan)

---

## Definition of Done

- [x] Code peer-reviewed and merged to `main`
- [x] Unit tests pass (coverage > 80%)
- [x] Manual QA completed on staging
- [x] No P0 or P1 bugs
- [x] Documentation updated (API docs, README)
- [x] Product Owner accepted

---

## Sprint Metrics

### Burndown

| Day    | Remaining Points                         |
| ------ | ---------------------------------------- |
| Day 1  | 21                                       |
| Day 3  | 18                                       |
| Day 5  | 13 (US-046 done)                         |
| Day 7  | 8                                        |
| Day 10 | 8 (US-047 blocked by database migration) |
| Day 14 | 0 (US-047 unblocked, completed)          |

---

## Retrospective Highlights

### What Went Well 🎉

- Pair programming on deposit logic reduced bugs (0 defects found in QA!)
- Early stakeholder demo (Day 7) caught UX issue before full build

### What Could Improve 🔧

- Database migration delayed US-047 by 3 days → Plan migrations earlier
- Last-minute design change to modify modal → Lock designs before sprint

### Action Items

- [ ] Jordan: Set up DB migration review process
- [ ] Alex: Start design review 1 week before sprint planning

---

## Key Learnings

**Technical:**

- Stripe's incremental authorization API required extra validation (not documented well)
- Real-time availability check added 200ms latency → Added caching (30-second TTL)

**Product:**

- Users want to modify **date** too (not just time) → Add to backlog as US-048

---

[← Back to Delivery](../README.md) | [Product Backlog →](../product-backlog.md)
