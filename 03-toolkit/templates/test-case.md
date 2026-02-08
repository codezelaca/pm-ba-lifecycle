# Test Case Template

**Use this template to write detailed manual test cases.**

---

## Test Case Information

**Test Case ID:** [TC-XXX]  
**Feature:** [Feature name, e.g., "Booking Creation"]  
**User Story:** [US-XXX if applicable]  
**Priority:** [ ] P0 (Critical) [ ] P1 (High) [ ] P2 (Medium) [ ] P3 (Low)

**Created By:** [Your Name]  
**Date Created:** [YYYY-MM-DD]

---

## Prerequisites

[List any setup required before executing this test]

- [ ] [Prerequisite 1, e.g., "Staging environment is accessible"]
- [ ] [Prerequisite 2, e.g., "Test user account exists"]
- [ ] [Prerequisite 3, e.g., "Test restaurant has availability"]

---

## Test Data

[Specify exact data to use in this test]

| Field          | Value            |
| -------------- | ---------------- |
| [Field name]   | [Value]          |
| Example: Email | test@example.com |
| Example: Phone | +15551234567     |

---

## Test Steps

| Step | Action                       | Expected Result      |
| ---- | ---------------------------- | -------------------- |
| 1    | [Detailed action to perform] | [What should happen] |
| 2    |                              |                      |
| 3    |                              |                      |
| ...  |                              |                      |

**Example:**
| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | Navigate to `https://staging.app.com` | Homepage loads within 2 seconds |
| 2 | Click "Search" button | Search results page displays |
| 3 | Enter "test@example.com" in email field | Email accepted, no validation error |

---

## Expected Final State

[Describe what should be true after all steps complete]

**Database Verification (if applicable):**

```sql
-- Example query to verify test result
SELECT * FROM table_name WHERE condition;
```

**Expected Values:**

- [Field 1] = [Expected value]
- [Field 2] = [Expected value]

---

## Actual Results

**Tested By:** ********\_********  
**Test Date:** ********\_********  
**Build/Version:** ********\_********

| Step | Status            | Notes/Screenshots  |
| ---- | ----------------- | ------------------ |
| 1-N  | [ ] Pass [ ] Fail | [Any observations] |

**Overall Status:** [ ] Pass [ ] Fail [ ] Blocked

**If Blocked, Reason:** ********\_********

---

## Defects Found

**If test failed, log defects here:**

| Defect ID | Description                  | Severity    | Screenshot/Link      |
| --------- | ---------------------------- | ----------- | -------------------- |
| BUG-XXX   | [Brief description of issue] | P0/P1/P2/P3 | [Link or attachment] |

---

## Notes/Comments

[Any additional observations, suggestions, or edge cases discovered during testing]

---

## Review & Approval

**Reviewed By:** ********\_********  
**Approval Date:** ********\_********

---

[⬅️ Back to Toolkit](../README.md)
