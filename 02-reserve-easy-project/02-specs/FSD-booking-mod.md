# Functional Specification Document (FSD)

# Booking Modification Feature

**Document Owner:** Product Team  
**Version:** 1.0  
**Status:** Approved  
**Last Updated:** February 1, 2026

---

## 1. Executive Summary

**Feature:** Allow diners to modify existing reservations (change time, party size) without calling the restaurant.

**Business Justification:** 15% of bookings are cancelled, often because users can't easily change details. This feature reduces cancellations and improves user satisfaction.

**Success Metric:** Reduce cancellation rate from 15% → 10% within 2 months of launch.

---

## 2. Related Documents

- [BRD v1.0](BRD-v1.0.md) - Business Requirements
- [User Story US-045](../04-delivery/product-backlog.md#us-045) - Modify reservation time
- [API Spec](API-specs/booking-api.yaml) - PATCH /api/v1/bookings/{id}

---

## 3. User Stories

### Primary User Story

**US-045:** As a diner, I want to change my reservation time, so I can adjust if my plans change.

**Acceptance Criteria:**

- GIVEN I have an upcoming booking  
  WHEN I click "Modify Reservation"  
  THEN I can select a new time from available slots

- GIVEN I select a new time  
  WHEN I confirm the change  
  THEN I receive updated SMS confirmation within 30 seconds

---

### Secondary User Stories

**US-046:** As a diner, I want to increase my party size, so I can accommodate an extra guest.

**US-047:** As a restaurant manager, I want to see modification requests, so I can approve/deny based on availability.

---

## 4. Functional Requirements

### FR-001: Modify Time

**Description:** User can change booking time if new time is available.

**Preconditions:**

- User has an existing confirmed booking
- Booking is >2 hours in the future (can't modify within 2 hours)

**Flow:**

1. User navigates to "My Reservations"
2. Clicks "Modify" button on a booking
3. System shows current booking details
4. User clicks "Change Time"
5. System queries database for available time slots (same date, same party size)
6. User selects new time from dropdown
7. User clicks "Confirm Change"
8. System updates booking record
9. System sends SMS: "Your reservation at [restaurant] has been updated to [new time]"

**Business Rules:**

- Cannot modify within 2 hours of booking time (too late for restaurant to accommodate)
- New time must be available (real-time availability check)
- Original deposit (if any) carries over to new time

---

### FR-002: Modify Party Size

**Description:** User can increase or decrease party size.

**Preconditions:**

- Booking is >24 hours in the future (size changes require more notice)

**Flow:**

1. User navigates to "Modify Reservation"
2. Clicks "Change Party Size"
3. Selects new size from dropdown (1-20 guests)
4. System checks if restaurant can accommodate new size at that time
   - If YES → Update booking
   - If NO → Show message "Sorry, we can't accommodate [X] guests at this time. Try a different time or call the restaurant."
5. If deposit was paid:
   - Party size increased (4 → 6) → Collect additional $20 deposit
   - Party size decreased (6 → 4) → Refund $20 within 24 hours

**Business Rules:**

- Increasing party size from <6 → ≥6 triggers deposit requirement
- Decreasing party size triggers partial refund (prorated)

---

### FR-003: Modification History

**Description:** System tracks all modifications for audit trail.

**Data Stored:**

- Original booking details
- Modified fields (time, party size)
- Timestamp of modification
- User who made modification

**Use Case:** Restaurant sees "Booking was originally for 4, changed to 6 on Feb 3"

---

## 5. User Interface Specifications

### Screen 1: My Reservations

**Elements:**

- List of upcoming bookings (card layout)
- Each card shows:
  - Restaurant name
  - Date & time
  - Party size
  - Confirmation code
  - Buttons: "Modify" | "Cancel"

**Wireframe:**

```
┌─────────────────────────────────────┐
│  My Reservations                    │
├─────────────────────────────────────┤
│ ┌───────────────────────────────┐   │
│ │ Bella Italia              $$  │   │
│ │ Feb 15, 2026 at 7:00 PM        │   │
│ │ Party of 4                     │   │
│ │ Code: ABC123                   │   │
│ │                                │   │
│ │ [Modify]  [Cancel]             │   │
│ └───────────────────────────────┘   │
│                                     │
│ ┌───────────────────────────────┐   │
│ │ Sushi Palace              $$$ │   │
│ │ Feb 18, 2026 at 8:30 PM        │   │
│ │ Party of 2                     │   │
│ │ Code: XYZ789                   │   │
│ │                                │   │
│ │ [Modify]  [Cancel]             │   │
│ └───────────────────────────────┘   │
└─────────────────────────────────────┘
```

See: [Figma Wireframes](../03-design/wireframes/)

---

### Screen 2: Modify Reservation Modal

**Trigger:** User clicks "Modify" button

**Elements:**

- Current booking summary (read-only)
- Editable fields:
  - Time (dropdown with available slots)
  - Party size (dropdown 1-20)
- Buttons: "Save Changes" | "Cancel"

**Validation:**

- If no changes made → "Save Changes" button disabled
- If new time unavailable → Show error "This time is no longer available"

**Wireframe:**

```
┌─────────────────────────────────────┐
│  Modify Reservation                 │
├─────────────────────────────────────┤
│  Bella Italia                       │
│  Feb 15, 2026                       │
│                                     │
│  Time:                              │
│  ┌─────────────────────────┐        │
│  │ 7:00 PM           [▼]   │        │
│  └─────────────────────────┘        │
│  Available: 6:30 PM, 7:00 PM,       │
│  7:30 PM, 8:00 PM                   │
│                                     │
│  Party Size:                        │
│  ┌─────────────────────────┐        │
│  │ 4 guests          [▼]   │        │
│  └─────────────────────────┘        │
│                                     │
│  [Cancel]  [Save Changes]           │
└─────────────────────────────────────┘
```

---

## 6. API Specifications

### Endpoint: PATCH /api/v1/bookings/{id}

**Purpose:** Update an existing booking

**Request:**

```http
PATCH /api/v1/bookings/12345
Content-Type: application/json
Authorization: Bearer {user_token}

{
  "booking_time": "19:30:00",  // Optional: new time
  "party_size": 6               // Optional: new party size
}
```

**Response (200 OK):**

```json
{
  "booking_id": 12345,
  "restaurant_id": 42,
  "booking_date": "2026-02-15",
  "booking_time": "19:30:00",
  "party_size": 6,
  "confirmation_code": "ABC123",
  "status": "confirmed",
  "deposit_amount": 60.0,
  "additional_deposit_charged": 20.0,
  "sms_sent": true,
  "updated_at": "2026-02-03T14:32:15Z"
}
```

**Error Response (409 Conflict - New Time Unavailable):**

```json
{
  "error": "booking_unavailable",
  "message": "The requested time 19:30:00 is no longer available. Please select a different time.",
  "available_times": ["18:00:00", "18:30:00", "20:00:00"]
}
```

**Full Spec:** See [booking-api.yaml](API-specs/booking-api.yaml) lines 150-210

---

## 7. Business Logic

### Rule 1: Modification Time Window

```
IF booking_time - current_time < 2 hours:
    RETURN error "Cannot modify within 2 hours of booking"
ELSE:
    ALLOW modification
```

---

### Rule 2: Deposit Adjustment

```python
def calculate_deposit_adjustment(original_size, new_size, deposit_per_person=10):
    original_deposit = max(0, (original_size - 5) * deposit_per_person)
    new_deposit = max(0, (new_size - 5) * deposit_per_person)
    adjustment = new_deposit - original_deposit

    if adjustment > 0:
        return {"action": "charge", "amount": adjustment}
    elif adjustment < 0:
        return {"action": "refund", "amount": abs(adjustment)}
    else:
        return {"action": "none", "amount": 0}

# Example:
# Original: 4 guests (deposit = $0)
# New: 6 guests (deposit = $10)
# Action: Charge $10
```

---

### Rule 3: Availability Check

Before allowing modification, query:

```sql
SELECT COUNT(*) AS available_capacity
FROM restaurant_tables
WHERE restaurant_id = 42
  AND date = '2026-02-15'
  AND time_slot = '19:30:00'
  AND capacity >= 6
  AND table_id NOT IN (
      SELECT table_id
      FROM bookings
      WHERE booking_date = '2026-02-15'
        AND booking_time = '19:30:00'
        AND status = 'confirmed'
  );
```

IF available_capacity > 0 → ALLOW  
ELSE → DENY

---

## 8. Edge Cases & Error Handling

| Scenario                                                                                      | System Behavior                                                                                |
| --------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| User modifies time to a slot that becomes unavailable between viewing and confirming          | Show error "This time just became unavailable. Please select another." Refresh available times |
| User increases party size beyond restaurant capacity (e.g., 25 guests for 50-seat restaurant) | Show error "Maximum party size for this restaurant is 20. Please call for larger groups."      |
| Payment for additional deposit fails                                                          | Rollback modification, show "Payment failed. Please update your card and try again."           |
| SMS notification fails after successful modification                                          | Log error, send email fallback within 1 minute                                                 |
| User tries to modify a past booking                                                           | Show error "Cannot modify past bookings"                                                       |

---

## 9. Testing Requirements

### Test Cases

**TC-MOD-001:** Modify time from 7:00 PM → 7:30 PM (new time available)  
**Expected:** Booking updated, SMS sent

**TC-MOD-002:** Modify time within 1 hour of booking  
**Expected:** Error "Cannot modify within 2 hours"

**TC-MOD-003:** Increase party size 4 → 6 (triggers deposit)  
**Expected:** Additional $20 charged, booking updated

**TC-MOD-004:** Decrease party size 6 → 4 (refund deposit)  
**Expected:** $20 refunded within 24 hours

**TC-MOD-005:** Modify to unavailable time  
**Expected:** Error with list of available times

**Full Test Suite:** [TC-MOD Series](../06-qa/test-cases/)

---

## 10. Success Metrics

| Metric                                 | Baseline                   | Target (Month 2) | Measurement                            |
| -------------------------------------- | -------------------------- | ---------------- | -------------------------------------- |
| Cancellation Rate                      | 15%                        | 10%              | (Cancellations / Total Bookings) × 100 |
| Modification Rate                      | 0% (feature doesn't exist) | 8%               | (Modifications / Total Bookings) × 100 |
| User Satisfaction (NPS)                | 42                         | 50               | Post-booking survey                    |
| Support Tickets (modification-related) | 50/week                    | <10/week         | Zendesk count                          |

---

## 11. Rollout Plan

### Phase 1: Internal Beta (Week 1)

- Enable for 10 internal test users
- Goal: Find bugs before public launch

### Phase 2: Pilot (Week 2-3)

- Enable for 10% of users
- Monitor: Modification success rate, error rate, support tickets

### Phase 3: Full Launch (Week 4)

- Enable for 100% of users
- Announce via email/SMS to all active users

---

## 12. Dependencies

| Dependency                                    | Team     | Status         | Notes                             |
| --------------------------------------------- | -------- | -------------- | --------------------------------- |
| API Endpoint (PATCH /bookings/{id})           | Backend  | ✅ Done        | Deployed to staging               |
| UI Design (Modify Modal)                      | Design   | ✅ Done        | Figma link in wireframes folder   |
| Real-time Availability Query Optimization     | Database | 🚧 In Progress | Add index on (date, time, status) |
| Payment Integration (Stripe Incremental Auth) | Backend  | ⏳ Blocked     | Waiting for Stripe approval       |

---

## 13. Open Questions

1. **Question:** Should we allow modifying the date (not just time)?  
   **Answer:** No for v1. Too complex (different availability, deposit rules). Defer to v2.

2. **Question:** What if restaurant manually blocks a time slot after user booked?  
   **Answer:** Show "This time is no longer available" error. User must pick different time or call restaurant.

---

## Approval

| Role             | Name | Signature | Date |
| ---------------- | ---- | --------- | ---- |
| Product Manager  |      |           |      |
| Engineering Lead |      |           |      |
| QA Lead          |      |           |      |

---

[← Back to Specs](../02-specs/) | [BRD →](BRD-v1.0.md) | [API Spec →](API-specs/booking-api.yaml)
