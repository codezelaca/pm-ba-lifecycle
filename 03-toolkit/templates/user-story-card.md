# User Story Card Template

**Use this template to write well-formed user stories that meet the INVEST criteria.**

---

## Title

[Brief, descriptive title - e.g., "SMS Confirmation After Booking"]

---

## User Story

**As a** [type of user - be specific: "restaurant manager" not just "user"],  
**I want** [goal/capability - what do they want to do?],  
**So that** [benefit/value - why does this matter?].

---

## Acceptance Criteria

Use the **GIVEN-WHEN-THEN** format for clarity:

- [ ] **GIVEN** [context or precondition]  
      **WHEN** [action the user takes]  
      **THEN** [expected outcome]

- [ ] **GIVEN** [another scenario]  
      **WHEN** [action]  
      **THEN** [outcome]

- [ ] **GIVEN** [edge case]  
      **WHEN** [action]  
      **THEN** [how the system handles it]

---

## Example (ReserveEasy)

### Title

Receive SMS Confirmation After Booking

### User Story

**As a** diner,  
**I want** to receive an SMS confirmation immediately after booking,  
**So that** I have proof of my reservation and don't worry whether it went through.

### Acceptance Criteria

- [ ] **GIVEN** I have completed a booking and provided my phone number  
      **WHEN** the booking is confirmed  
      **THEN** I receive an SMS within 30 seconds

- [ ] **GIVEN** I receive the SMS  
      **WHEN** I read it  
      **THEN** it includes: restaurant name, date, time, party size, confirmation code, and a link to modify

- [ ] **GIVEN** the SMS fails to send (e.g., invalid number)  
      **WHEN** delivery fails  
      **THEN** I receive an email confirmation as a fallback within 1 minute

---

## Business Value (Optional but Recommended)

**Why is this important?**  
[Describe the user pain point or business impact]

**Example:** Instant confirmation reduces customer anxiety and support calls. 85% of users in our survey said "knowing it went through" is the most important part of booking.

**Success Metric:**  
[How will we measure success?]

**Example:** <5% of users contact support asking "Did my booking go through?"

---

## Story Points (To be filled during estimation)

**Estimate:** [ ] 1 [ ] 2 [ ] 3 [ ] 5 [ ] 8 [ ] 13 [ ] 21

**Complexity Reasoning:**  
[Why this estimate? What makes it complex?]

**Example:** 5 points - Requires Twilio API integration, SMS template design, and error handling for failed deliveries.

---

## Dependencies

[List any other stories that must be completed first]

- [ ] [Story/Task ID]: Description
- [ ] Third-party service setup: [e.g., Twilio account activated]

---

## Open Questions

[List anything that needs clarification before development]

1. Should SMS work for international numbers?
2. What happens if SMS quota is exceeded?
3. Do we need to store SMS delivery status in the database?

---

## INVEST Checklist

Before marking this story as "ready," verify:

- [ ] **I**ndependent - Can be developed without hard dependencies
- [ ] **N**egotiable - Details can be discussed (not a rigid contract)
- [ ] **V**aluable - Delivers clear value to users or business
- [ ] **E**stimable - Team can estimate effort
- [ ] **S**small - Fits in one sprint (1-2 weeks)
- [ ] **T**estable - Has clear pass/fail acceptance criteria

---

## Notes for Developers (Optional)

[Technical details, API endpoints, database changes, etc.]

**Example:**

- **API Endpoint:** POST `/api/v1/notifications/sms`
- **Twilio Integration:** Use official Twilio Node.js SDK
- **Database:** Add `sms_sent`, `sms_delivered` boolean fields to `bookings` table

---

[⬅️ Back to Toolkit](../README.md)
