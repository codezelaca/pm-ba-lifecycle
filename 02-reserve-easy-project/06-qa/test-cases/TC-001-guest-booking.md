# Test Case: Guest User Booking Flow

**Test Case ID:** TC-001  
**Priority:** P0 (Critical)  
**Feature:** Booking Creation  
**User Story:** US-004

---

## Prerequisites

- [ ] Staging environment is live and accessible
- [ ] Test restaurant "Bella Italia" exists with ID = 42
- [ ] "Bella Italia" has availability tomorrow at 7:00 PM for party size 4
- [ ] Twilio SMS gateway is configured for staging
- [ ] Test phone number +15551234567 is able to receive SMS

---

## Test Data

| Field      | Value                 |
| ---------- | --------------------- |
| Restaurant | Bella Italia (ID: 42) |
| Date       | Tomorrow's date       |
| Time       | 7:00 PM               |
| Party Size | 4                     |
| Name       | Test User             |
| Email      | test@example.com      |
| Phone      | +15551234567          |

---

## Test Steps

| Step | Action                                                                                                                                                                                                                                             | Expected Result                                                        |
| ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| 1    | Navigate to `https://staging.reserveeasy.com`                                                                                                                                                                                                      | Homepage loads within 2 seconds                                        |
| 2    | Enter "Italian" in cuisine search field                                                                                                                                                                                                            | Autocomplete suggestions appear                                        |
| 3    | Select "Manhattan" from location dropdown                                                                                                                                                                                                          | Location field populated                                               |
| 4    | Click "Search" button                                                                                                                                                                                                                              | Search results page loads, showing at least 5 restaurants              |
| 5    | Verify "Bella Italia" appears in results                                                                                                                                                                                                           | Restaurant card displays with name, cuisine, price range ($$)          |
| 6    | Click on "Bella Italia" restaurant card                                                                                                                                                                                                            | Restaurant detail page loads with photos, hours, description           |
| 7    | Select tomorrow's date from calendar picker                                                                                                                                                                                                        | Date field shows selected date in format "MM/DD/YYYY"                  |
| 8    | Select party size "4" from dropdown                                                                                                                                                                                                                | Party size field shows "4 guests"                                      |
| 9    | Click "Check Availability" button                                                                                                                                                                                                                  | Availability section loads, showing available time slots               |
| 10   | Verify 7:00 PM slot is available and clickable                                                                                                                                                                                                     | Time slot button is enabled (not grayed out)                           |
| 11   | Click "7:00 PM" time slot                                                                                                                                                                                                                          | Time slot highlights, "Book This Time" button appears                  |
| 12   | Click "Book This Time" button                                                                                                                                                                                                                      | Booking form appears with fields: Name, Email, Phone, Special Requests |
| 13   | Fill Name field: "Test User"                                                                                                                                                                                                                       | Name field accepts input, no validation errors                         |
| 14   | Fill Email field: "test@example.com"                                                                                                                                                                                                               | Email field accepts input, shows checkmark icon (valid)                |
| 15   | Fill Phone field: "+15551234567"                                                                                                                                                                                                                   | Phone field accepts input, formats with parentheses (555) 123-4567     |
| 16   | Leave "Special Requests" field empty (optional)                                                                                                                                                                                                    | Field remains empty, no error                                          |
| 17   | Click "Confirm Booking" button                                                                                                                                                                                                                     | Loading spinner appears for 1-3 seconds                                |
| 18   | Wait for confirmation page to load                                                                                                                                                                                                                 | Confirmation page displays within 5 seconds                            |
| 19   | Verify confirmation page content: <br/>- "Booking Confirmed!" heading<br/>- Restaurant name: "Bella Italia"<br/>- Date: Tomorrow's date<br/>- Time: 7:00 PM<br/>- Party size: 4<br/>- Confirmation code: 6-character alphanumeric (e.g., "XYZ123") | All details match booking inputs, confirmation code is displayed       |
| 20   | Check phone +15551234567 for SMS                                                                                                                                                                                                                   | SMS received within 30 seconds                                         |
| 21   | Verify SMS content:<br/>- Contains "Bella Italia"<br/>- Contains date and time<br/>- Contains party size "4"<br/>- Contains confirmation code<br/>- Contains link to modify/cancel                                                                 | All required information is present in SMS                             |
| 22   | Click link in SMS (optional)                                                                                                                                                                                                                       | Opens booking details page with Modify/Cancel options                  |

---

## Expected Final State

### Database Verification (SQL)

```sql
SELECT
    id,
    restaurant_id,
    booking_date,
    booking_time,
    party_size,
    customer_name,
    customer_email,
    customer_phone,
    confirmation_code,
    status,
    sms_sent,
    created_at
FROM bookings
WHERE customer_email = 'test@example.com'
ORDER BY created_at DESC
LIMIT 1;
```

**Expected:**

- `restaurant_id` = 42
- `booking_date` = Tomorrow's date
- `booking_time` = 19:00:00
- `party_size` = 4
- `customer_name` = "Test User"
- `customer_email` = "test@example.com"
- `customer_phone` = "+15551234567"
- `confirmation_code` = 6 characters (uppercase alphanumeric)
- `status` = "confirmed"
- `sms_sent` = true
- `created_at` = Current timestamp

---

## Actual Results

**Tested By:** ********\_********  
**Test Date:** ********\_********  
**Build/Version:** ********\_********

| Step | Status            | Notes/Screenshots |
| ---- | ----------------- | ----------------- |
| 1-22 | [ ] Pass [ ] Fail |                   |

**Overall Status:** [ ] Pass [ ] Fail [ ] Blocked

---

## Defects Found

**If test failed, log defects here:**

| Defect ID | Description         | Severity    | Screenshot |
| --------- | ------------------- | ----------- | ---------- |
| BUG-XXX   | [Brief description] | P0/P1/P2/P3 | [Link]     |

---

## Notes/Comments

[Any additional observations, edge cases discovered, or suggestions for improvements]

---

[← Back to QA](../master-test-plan.md) | [All Test Cases →](../)
