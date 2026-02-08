# Practice Exercises

**Hands-on exercises to build PM & BA skills**

---

## How to Use This Guide

1. **Choose an exercise** matching your learning goal
2. **Time yourself** - Real interviews have time pressure
3. **Write it out** - Don't just think, actually document
4. **Compare** to example solutions (where provided)
5. **Iterate** - Redo exercises to improve

---

## Requirements Elicitation Exercises

### Exercise 1: Stakeholder Interview Simulation

**Scenario:** You're the BA for a new employee onboarding system. Interview the HR Director.

**Your Task:**

1. Prepare 10 open-ended questions
2. Role-play the interview (have a friend play HR Director)
3. Document findings in a requirements summary

**Time:** 30 minutes

**Sample Questions to Prepare:**

- "Walk me through the current onboarding process from Day 1 to Day 30"
- "What are the biggest pain points with the current approach?"
- "How do you measure onboarding success today?"
- "What would make the new system a success in your eyes?"

---

### Exercise 2: Requirements from a Demo Request

**Scenario:** A sales rep sends you an email:

> "Customer ABC wants the ability to export their data to Excel. They need this for their quarterly board meetings. Can we add this ASAP?"

**Your Task:**

1. Write 5 clarifying questions you'd ask
2. Draft a user story with acceptance criteria
3. Estimate complexity (S/M/L) with justification

**Time:** 20 minutes

**Sample Solution:**

```
Clarifying Questions:
1. Which data specifically? (All transactions? Summary only?)
2. What format? (CSV, XLSX, specific template?)
3. Who needs access to this? (All users or admins only?)
4. How often will they use this? (Weekly, quarterly?)
5. What's the deadline tied to? (Board meeting date?)

User Story:
As an admin user
I want to export transaction data to Excel
So that I can prepare reports for board meetings

Acceptance Criteria:
- GIVEN I'm on the Transactions page
  WHEN I click "Export" and select "Excel"
  THEN a .xlsx file downloads with all visible columns

- GIVEN I have filters applied
  WHEN I export
  THEN only filtered data is included

Estimate: Medium (3-5 days)
Justification: Requires backend data formatting, file generation, and download handling
```

---

## User Story Writing Exercises

### Exercise 3: Convert Features to Stories

**Scenario:** Product Manager says "We need a password reset feature."

**Your Task:**

1. Break this into 3-5 user stories
2. Write acceptance criteria for each
3. Order them by dependency

**Time:** 25 minutes

**Sample Solution:**

```
Story 1 (Foundation):
As a user who forgot my password
I want to request a password reset email
So that I can regain access to my account

AC:
- GIVEN I'm on login page, WHEN I click "Forgot Password", THEN I see email input
- GIVEN I enter a registered email, WHEN I submit, THEN I receive reset email within 60 seconds
- GIVEN I enter an unregistered email, WHEN I submit, THEN I see generic "If email exists..." message (security)

Story 2 (Core):
As a user with a reset link
I want to create a new password
So that I can log in with new credentials

AC:
- GIVEN I click the reset link, WHEN page loads, THEN I see password + confirm password fields
- GIVEN I enter matching passwords meeting requirements, WHEN I submit, THEN password is updated
- GIVEN link is expired (>1 hour), WHEN I click it, THEN I see "Link expired, request new one"

Story 3 (Security):
As a system
I want to invalidate old sessions after password reset
So that unauthorized access is prevented

AC:
- GIVEN password is reset, WHEN complete, THEN all other sessions are logged out
```

---

## Prioritization Exercises

### Exercise 4: RICE Scoring Practice

**Scenario:** You have these 5 feature requests. Score and prioritize using RICE.

| Feature | Description               |
| ------- | ------------------------- |
| A       | Dark mode                 |
| B       | Two-factor authentication |
| C       | Export to PDF             |
| D       | Mobile app                |
| E       | Slack integration         |

**Your Task:**

1. Estimate Reach, Impact, Confidence, Effort for each
2. Calculate RICE score
3. Rank and justify top 3

**Time:** 20 minutes

**Hint:**

- Reach: How many users/month will be affected?
- Impact: 3=massive, 2=high, 1=medium, 0.5=low, 0.25=minimal
- Confidence: 100%=high, 80%=medium, 50%=low
- Effort: Person-months

---

### Exercise 5: Stakeholder Pushback

**Scenario:** Engineering says Feature X takes 6 weeks. CEO says it must ship in 2 weeks. VP Sales promises it to a customer.

**Your Task:**

1. Identify what's negotiable (scope, time, quality, resources)
2. Propose 3 options with tradeoffs
3. Write an email to all stakeholders with your recommendation

**Time:** 25 minutes

---

## Process Mapping Exercises

### Exercise 6: As-Is Process Map

**Scenario:** Document the current manual expense reimbursement process:

1. Employee fills paper form
2. Attaches receipts
3. Manager signs
4. Sends to Finance
5. Finance reviews
6. CFO approves if >$500
7. Finance processes payment
8. Employee receives check

**Your Task:**

1. Draw a BPMN swimlane diagram (Employee, Manager, Finance, CFO)
2. Identify 3 bottlenecks
3. Propose a To-Be process

**Time:** 30 minutes

---

### Exercise 7: Sequence Diagram

**Scenario:** Draw a sequence diagram for this flow:

- User clicks "Book Table"
- App checks availability with server
- Server queries database
- Database returns available slots
- Server returns options to app
- User selects a slot
- App sends booking request
- Server creates booking, triggers SMS

**Your Task:**

1. Create a Mermaid sequence diagram
2. Add error handling for "no availability"

**Time:** 20 minutes

---

## Data Analysis Exercises

### Exercise 8: SQL Query Challenge

**Given these tables:**

```sql
users (id, name, created_at, country)
orders (id, user_id, amount, created_at, status)
```

**Write queries for:**

1. Total revenue by country (last 30 days)
2. New users this month who haven't ordered yet
3. Average order value for users who signed up in 2025

**Time:** 20 minutes

---

### Exercise 9: Metrics Definition

**Scenario:** You're PM for a food delivery app.

**Your Task:**

1. Define the North Star Metric (with justification)
2. List 3 input metrics that drive it
3. Write a SQL query to calculate the North Star Metric

**Time:** 20 minutes

**Sample Solution:**

```
North Star: Completed Deliveries per Week
Why: Captures value delivered to both customers (food received) and restaurants (revenue generated)

Input Metrics:
1. Active Users (reach)
2. Order Conversion Rate (activation)
3. Delivery Success Rate (quality)

Query:
SELECT
  DATE_TRUNC('week', delivered_at) AS week,
  COUNT(*) AS completed_deliveries
FROM orders
WHERE status = 'delivered'
  AND delivered_at >= NOW() - INTERVAL '12 weeks'
GROUP BY week
ORDER BY week DESC;
```

---

## Product Sense Exercises

### Exercise 10: Product Critique

**Choose a product you use daily (e.g., Spotify, Uber, Slack)**

**Your Task:**

1. Identify the core user problem it solves
2. Map the user journey (5-7 steps)
3. Find 3 friction points
4. Propose 1 improvement with success metrics

**Time:** 30 minutes

---

### Exercise 11: Design a Feature

**Scenario:** You're PM for LinkedIn. Design a feature to help job seekers practice interviews.

**Your Task:**

1. Define target user persona
2. List 3 key jobs-to-be-done
3. Sketch the core user flow (5 screens max)
4. Define success metrics

**Time:** 45 minutes

---

## Estimation Exercises

### Exercise 12: Fermi Problem

**Estimate:** How many Uber rides happen in New York City per day?

**Your Task:**

1. Break down into components
2. Make reasonable assumptions
3. Calculate final estimate
4. Sanity check against available data

**Time:** 10 minutes

---

### Exercise 13: Effort Estimation

**Scenario:** Estimate engineering effort for these features:

1. Add "Favorite" button to restaurant cards
2. Build a recommendation engine based on past bookings
3. Integrate with Google Calendar to block time after booking

**Your Task:**

1. T-shirt size each (S/M/L/XL)
2. Justify complexity drivers
3. Identify unknowns that could change estimate

**Time:** 15 minutes

---

## Communication Exercises

### Exercise 14: Executive Summary

**Scenario:** You just completed a 3-month project. Write a 5-sentence summary for the CEO who has 30 seconds to read it.

**Constraints:**

- What was the problem?
- What did we do?
- What was the result?
- What's next?

**Time:** 15 minutes

---

### Exercise 15: Technical Translation

**Scenario:** Engineer says:

> "We need to refactor the monolith into microservices because the current architecture doesn't scale horizontally and CI/CD is taking 45 minutes due to coupling."

**Your Task:** Translate this for a non-technical CFO asking "Why do we need to spend $500k on this?"

**Time:** 10 minutes

---

## Weekly Practice Schedule

| Day       | Focus           | Exercise                   |
| --------- | --------------- | -------------------------- |
| Monday    | Requirements    | #1 or #2                   |
| Tuesday   | User Stories    | #3                         |
| Wednesday | Process Mapping | #6 or #7                   |
| Thursday  | Data Analysis   | #8 or #9                   |
| Friday    | Product Sense   | #10 or #11                 |
| Weekend   | Full Case Study | Combine multiple exercises |

---

[⬅️ Back to Main](../README.md) | [Learning Paths →](../01-curriculum/learning-paths.md)
