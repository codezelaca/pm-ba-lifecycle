# User Stories Library

**A collection of well-written user stories organized by domain for reference and learning.**

---

## How to Use This Library

1. **Find a similar story** to what you're building
2. **Copy the structure** (persona, goal, benefit)
3. **Adapt the acceptance criteria** to your specific needs
4. **Add your business rules** and edge cases

---

## E-Commerce Stories

### US-EC-001: Guest Checkout

**As a** first-time visitor,  
**I want** to complete a purchase without creating an account,  
**So that** I can buy quickly without commitment.

**Acceptance Criteria:**

- GIVEN I have items in my cart  
  WHEN I click "Checkout"  
  THEN I see options for "Guest Checkout" or "Sign In"

- GIVEN I choose "Guest Checkout"  
  WHEN I enter email, shipping, and payment  
  THEN my order is placed and confirmation sent to my email

- GIVEN I complete guest checkout  
  WHEN order is placed  
  THEN I'm offered option to create account with pre-filled info

**Story Points:** 5  
**Priority:** P0

---

### US-EC-002: Wishlist

**As a** registered user,  
**I want** to save items to a wishlist,  
**So that** I can purchase them later.

**Acceptance Criteria:**

- GIVEN I'm viewing a product  
  WHEN I click the heart icon  
  THEN the item is added to my wishlist

- GIVEN I'm not logged in  
  WHEN I click the heart icon  
  THEN I'm prompted to log in first

- GIVEN I have items in my wishlist  
  WHEN I view my wishlist  
  THEN I see all saved items with current prices

**Story Points:** 3  
**Priority:** P2

---

## Marketplace / Two-Sided Platform Stories

### US-MP-001: Seller Onboarding

**As a** potential seller,  
**I want** to register my business on the platform,  
**So that** I can start selling to customers.

**Acceptance Criteria:**

- GIVEN I click "Become a Seller"  
  WHEN I complete the registration form (business name, tax ID, bank account)  
  THEN my application is submitted for review

- GIVEN my application is approved  
  WHEN I log in  
  THEN I see my seller dashboard with onboarding checklist

- GIVEN my application is rejected  
  WHEN I log in  
  THEN I see rejection reason and option to reapply

**Story Points:** 8  
**Priority:** P0

---

### US-MP-002: Buyer-Seller Messaging

**As a** buyer,  
**I want** to message a seller with questions,  
**So that** I can get clarification before purchasing.

**Acceptance Criteria:**

- GIVEN I'm on a product page  
  WHEN I click "Contact Seller"  
  THEN a chat window opens

- GIVEN I send a message  
  WHEN the seller is online  
  THEN they see a notification

- GIVEN seller replies  
  WHEN I'm offline  
  THEN I receive email notification

**Story Points:** 5  
**Priority:** P1

---

## SaaS / B2B Stories

### US-SAAS-001: Team Member Invitation

**As an** admin,  
**I want** to invite team members to my organization,  
**So that** my colleagues can access the platform.

**Acceptance Criteria:**

- GIVEN I'm on the team settings page  
  WHEN I enter an email and click "Invite"  
  THEN an invitation email is sent

- GIVEN invitation is sent  
  WHEN invitee clicks the link  
  THEN they can create their account and join my org

- GIVEN invitee doesn't accept within 7 days  
  WHEN the link expires  
  THEN I can resend the invitation

**Story Points:** 5  
**Priority:** P1

---

### US-SAAS-002: Role-Based Permissions

**As an** admin,  
**I want** to assign roles to team members,  
**So that** I can control who has access to sensitive features.

**Acceptance Criteria:**

- GIVEN I'm viewing a team member's profile  
  WHEN I click "Change Role"  
  THEN I see dropdown with available roles (Admin, Editor, Viewer)

- GIVEN I change role from Editor to Viewer  
  WHEN the user next logs in  
  THEN they no longer see edit buttons

- GIVEN I'm the only admin  
  WHEN I try to demote myself  
  THEN I see error "At least one admin required"

**Story Points:** 5  
**Priority:** P1

---

## Booking / Reservation Stories

### US-BK-001: Real-Time Availability Check

**As a** customer,  
**I want** to see available time slots in real-time,  
**So that** I don't waste time selecting unavailable times.

**Acceptance Criteria:**

- GIVEN I select a date  
  WHEN page loads  
  THEN available slots are shown in green, unavailable in gray

- GIVEN another user books a slot while I'm viewing  
  WHEN the slot becomes unavailable  
  THEN it updates to gray within 5 seconds (websocket)

- GIVEN no slots are available  
  WHEN I view the date  
  THEN I see message "Fully booked" with link to join waitlist

**Story Points:** 8  
**Priority:** P0

---

### US-BK-002: Booking Reminder

**As a** customer with an upcoming booking,  
**I want** to receive a reminder,  
**So that** I don't forget my appointment.

**Acceptance Criteria:**

- GIVEN I have a booking tomorrow  
  WHEN it's 24 hours before my booking time  
  THEN I receive SMS: "Reminder: Your booking at [venue] is tomorrow at [time]"

- GIVEN I have a booking today  
  WHEN it's 2 hours before my booking time  
  THEN I receive SMS: "Reminder: Your booking at [venue] is in 2 hours"

- GIVEN I've cancelled my booking  
  WHEN reminder time arrives  
  THEN no reminder is sent

**Story Points:** 3  
**Priority:** P1

---

## Notifications & Alerts Stories

### US-NT-001: Notification Preferences

**As a** user,  
**I want** to control which notifications I receive,  
**So that** I'm not overwhelmed with unwanted messages.

**Acceptance Criteria:**

- GIVEN I'm on notification settings page  
  WHEN I view preferences  
  THEN I see toggles for: Email, SMS, Push, In-App (per category)

- GIVEN I disable email for "Marketing"  
  WHEN a promotional email is triggered  
  THEN I don't receive it

- GIVEN I disable all notification types  
  WHEN I try to save  
  THEN I see warning "You may miss important updates"

**Story Points:** 5  
**Priority:** P2

---

## Search & Discovery Stories

### US-SD-001: Faceted Search

**As a** user browsing products,  
**I want** to filter by multiple criteria,  
**So that** I can find exactly what I need quickly.

**Acceptance Criteria:**

- GIVEN I'm on search results page  
  WHEN I select filters (price range, category, rating)  
  THEN results update without full page reload

- GIVEN I have filters applied  
  WHEN I see result count  
  THEN it shows "Showing X of Y results"

- GIVEN I have filters applied  
  WHEN I click "Clear All"  
  THEN all filters are removed and full results shown

**Story Points:** 8  
**Priority:** P1

---

## Payment Stories

### US-PAY-001: Save Payment Method

**As a** returning customer,  
**I want** to save my credit card for future purchases,  
**So that** checkout is faster next time.

**Acceptance Criteria:**

- GIVEN I'm at checkout  
  WHEN I enter card details  
  THEN I see checkbox "Save card for future purchases"

- GIVEN I saved a card previously  
  WHEN I return to checkout  
  THEN I see saved card (masked: \*\*\*\* 4242) with option to use it

- GIVEN I want to remove a saved card  
  WHEN I go to payment settings and click "Remove"  
  THEN the card is deleted (confirm dialog first)

**Story Points:** 5  
**Priority:** P1

---

## Analytics & Reporting Stories

### US-AN-001: Export Report

**As a** manager,  
**I want** to export dashboard data to CSV,  
**So that** I can analyze in Excel or share with stakeholders.

**Acceptance Criteria:**

- GIVEN I'm viewing a dashboard  
  WHEN I click "Export"  
  THEN I see options: CSV, PDF, Excel

- GIVEN I choose CSV  
  WHEN export completes  
  THEN file downloads with all visible data + column headers

- GIVEN data is large (>10,000 rows)  
  WHEN I click export  
  THEN I see "Processing..." and receive email when ready

**Story Points:** 5  
**Priority:** P2

---

## Anti-Pattern Stories (What NOT to Do)

### ❌ Bad Story: Too Vague

**As a** user,  
**I want** the system to be faster,  
**So that** it's better.

**Problems:**

- Not specific (how fast? which part?)
- Not measurable
- "Be faster" is not a user goal

---

### ❌ Bad Story: Implementation Details

**As a** developer,  
**I want** to implement a Redis cache layer,  
**So that** page load improves.

**Problems:**

- Written from developer perspective
- Specifies solution, not problem
- Should be: "As a user, I want pages to load in <2 seconds"

---

### ❌ Bad Story: Too Large (Epic)

**As a** admin,  
**I want** full user management capabilities,  
**So that** I can manage my team.

**Problems:**

- Too large to estimate
- Should be split into: invite users, assign roles, remove users, etc.

---

## Story Sizing Reference

| Points | Complexity   | Example                                  |
| ------ | ------------ | ---------------------------------------- |
| 1      | Trivial      | Change button text, update error message |
| 2      | Simple       | Add new form field with validation       |
| 3      | Standard     | New page with form submission            |
| 5      | Moderate     | Feature with API integration             |
| 8      | Complex      | Multi-step workflow with edge cases      |
| 13     | Very Complex | Consider splitting into smaller stories  |

---

[⬅️ Back to Toolkit](../README.md) | [User Story Template →](user-story-card.md)
