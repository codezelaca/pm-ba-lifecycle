# Definition of Done (DoD)

**Purpose:** Checklist to ensure work is truly complete before calling it "Done."

---

## What is Definition of Done?

A user story is **"Done"** when it meets all criteria below. Until all checkboxes are ticked, the story remains in progress.

**Why it matters:** Prevents half-finished work, ensures quality, reduces technical debt.

---

## DoD Checklist

### 1. Code Quality

- [ ] Code follows team's style guide (linting passes)
- [ ] No hardcoded values (use environment variables for config)
- [ ] Code is DRY (Don't Repeat Yourself) - no unnecessary duplication
- [ ] Functions/classes have descriptive names
- [ ] Complex logic has comments explaining "why" (not just "what")

---

### 2. Testing

- [ ] Unit tests written for new code
- [ ] Unit tests pass (100% of tests green)
- [ ] Code coverage ≥80% (measure with Jest/Pytest coverage tools)
- [ ] Integration tests written (if API/database changes)
- [ ] Manual testing completed on staging environment
- [ ] Edge cases tested (invalid input, boundary values, concurrency)

---

### 3. Code Review

- [ ] Pull Request (PR) created with descriptive title and summary
- [ ] At least 1 team member approved the PR
- [ ] All review comments addressed or discussed
- [ ] No "LGTM without reading" approvals (reviewers actually tested locally)

---

### 4. Acceptance Criteria Met

- [ ] All acceptance criteria from user story are satisfied
- [ ] Product Owner (or proxy) has verified and approved
- [ ] Matches designs (if UI work) - pixel-perfect not required, but close
- [ ] No P0 or P1 bugs discovered during testing

---

### 5. Documentation

- [ ] README updated (if setup steps changed)
- [ ] API documentation updated (if endpoints added/changed)
- [ ] Inline code comments added for complex logic
- [ ] User-facing documentation updated (help center, guides)

---

### 6. Deployment

- [ ] Code merged to `main` branch (or release branch)
- [ ] Deployed to staging environment
- [ ] Smoke test passes on staging (critical paths still work)
- [ ] Database migrations run successfully (if applicable)
- [ ] Feature flag configured (if using gradual rollout)

---

### 7. Non-Functional Requirements

- [ ] Performance benchmarks met (e.g., page load <2s, API response <500ms)
- [ ] Security: No new vulnerabilities introduced (run security scan)
- [ ] Accessibility: Meets WCAG 2.1 AA (if customer-facing UI)
- [ ] Mobile responsive (tested on iPhone, iPad, Android)
- [ ] Browser compatibility (tested on Chrome, Safari, Firefox)

---

### 8. Monitoring & Observability

- [ ] Logging added for key actions (e.g., "Booking created", "Payment failed")
- [ ] Error tracking configured (Sentry, New Relic)
- [ ] Metrics/analytics events emitted (e.g., "booking_completed", "modification_clicked")
- [ ] Alerts configured for failures (e.g., "SMS delivery rate < 95%")

---

### 9. Clean Up

- [ ] No commented-out code (delete it - it's in Git history)
- [ ] No `console.log()` or debugging statements left in production code
- [ ] No TODO comments (convert them to Jira tickets if needed)
- [ ] Unused imports/dependencies removed

---

## Example: Done vs Not Done

### ❌ NOT Done

**Story:** US-045 "Change reservation time"

**Status:**

- [x] Code written
- [x] Works on my machine
- [ ] Tests written (0% coverage)
- [ ] Code review
- [ ] Deployed to staging
- [ ] Product Owner signed off

**Problems:** Code isn't tested, not reviewed, not deployed. This is NOT done.

---

### ✅ Done

**Story:** US-045 "Change reservation time"

**Status:**

- [x] Code written and follows style guide
- [x] 15 unit tests written (85% coverage)
- [x] Integration test for PATCH /bookings/{id}
- [x] Code reviewed and approved by 2 team members
- [x] Deployed to staging
- [x] QA tested (TC-MOD-001 through TC-MOD-005 all pass)
- [x] Product Owner verified and signed off
- [x] API docs updated (OpenAPI spec)
- [x] Performance: API response time 320ms (well under 500ms target)
- [x] Logging: "booking_modified" event tracked in Mixpanel

**This is DONE.** Ship it! 🚀

---

## Who Defines DoD?

**Team Responsibility:** The entire team (PM, engineering, QA, design) agrees on DoD at project kickoff.

**Living Document:** DoD can evolve. Retrospective action item: "Add accessibility checks to DoD"

---

## When to Check DoD?

### During Development

Developer self-checks: "Have I met DoD before requesting review?"

### During Code Review

Reviewer checks: "Does this PR meet all DoD criteria?"

### Sprint Review (Demo)

Product Owner verifies: "All acceptance criteria met, DoD satisfied → Story is done"

---

## Common DoD Anti-Patterns

### ❌ "Done-Done" vs "Done"

If you need to say "done-done," your DoD is unclear. There's only one "Done."

### ❌ Ignoring DoD to "Make the Sprint Goal"

Cutting corners to hit a sprint goal creates technical debt. Better to defer 1 story than ship 3 half-finished stories.

### ❌ DoD Too Strict (Paralyzes Team)

If DoD requires 10 approvals and a 200-page doc, team won't ship anything. Balance quality with velocity.

---

[⬅️ Back to Toolkit](../README.md) | [Definition of Ready →](definition-of-ready.md)
