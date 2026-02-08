---
name: Bug Report
about: Report a defect or issue
title: "[BUG] "
labels: bug, needs-triage
assignees: ""
---

## Bug Summary

[One-sentence description of the problem]

---

## Severity

- [ ] **Critical** - System down, data loss, security vulnerability
- [ ] **High** - Major feature broken, impacts many users
- [ ] **Medium** - Feature partially broken, workaround exists
- [ ] **Low** - Cosmetic issue, minimal impact

---

## Environment

**Where did this occur?**

- [ ] Production
- [ ] Staging
- [ ] Local development

**Browser/Device:** [e.g., Chrome 118, Safari iOS 17, Android Chrome]  
**Operating System:** [e.g., macOS 14.0, Windows 11, iOS 17]  
**User Type:** [e.g., logged-in user, guest, restaurant partner]

---

## Steps to Reproduce

[Provide exact steps to consistently reproduce the issue]

1. Navigate to [URL]
2. Click on [button/element]
3. Enter [data] into [field]
4. Observe [unexpected behavior]

---

## Expected Behavior

**What should have happened?**

[Describe the correct/intended behavior]

---

## Actual Behavior

**What actually happened?**

[Describe the bug/error]

**Error Message (if any):**

```
[Paste exact error text or screenshot]
```

---

## Screenshots/Videos

[Attach screenshots or screen recordings to help illustrate the issue]

**Before:** [What it should look like]  
**After:** [What it looks like now (broken)]

---

## Impact

**Who is affected?**

- [ ] All users
- [ ] Specific user segment: [e.g., only iOS users, only restaurant partners]
- [ ] Internal team only

**How many users?** [Estimate if possible, e.g., "~500 users/day hit this page"]

**Workaround available?**

- [ ] Yes - [Describe workaround]
- [ ] No

---

## Technical Details (For Engineering)

**Browser Console Errors:**

```
[Paste JavaScript errors from browser console]
```

**Network Request (if API-related):**

- **Endpoint:** `POST /api/v1/bookings`
- **Status Code:** `500 Internal Server Error`
- **Request Body:**

```json
{
  "restaurant_id": 123,
  "booking_date": "2026-02-15"
}
```

- **Response:**

```json
{
  "error": "Database connection timeout"
}
```

**Server Logs (if available):**

```
[Paste relevant backend logs with timestamp]
```

---

## Root Cause (If Known)

[Optional: If you have insights into why this is happening, note them here]

**Suspected Issue:** [e.g., race condition, null pointer, timeout]

---

## Suggested Fix (Optional)

[If you have ideas on how to fix it, share them]

---

## Related Issues/PRs

- Duplicate of #
- Related to #
- Introduced in PR #

---

## Checklist for QA/Engineering

- [ ] Bug confirmed (can reproduce)
- [ ] Severity assigned
- [ ] Owner assigned
- [ ] Target fix version set
- [ ] Fix verified in staging
- [ ] Fix deployed to production
- [ ] Regression test added
