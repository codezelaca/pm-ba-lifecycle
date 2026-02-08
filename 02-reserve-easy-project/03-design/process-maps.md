# Process Maps - ReserveEasy

**Purpose:** Visualizing user flows and system interactions using Business Process Model and Notation (BPMN).

---

## Table of Contents

1. [Booking Flow - As-Is (Phone Booking)](#booking-flow---as-is)
2. [Booking Flow - To-Be (Reserve Easy Platform)](#booking-flow---to-be)
3. [Cancellation Flow](#cancellation-flow)
4. [Restaurant Confirmation Workflow](#restaurant-confirmation-workflow)

---

## Booking Flow - As-Is (Phone Booking)

**Current State:** How diners book tables today (before ReserveEasy)

```mermaid
sequenceDiagram
    autonumber
    participant D as Diner
    participant P as Phone System
    participant H as Restaurant Host
    participant B as Paper Book

    D->>P: Call restaurant
    P-->>D: On hold (avg 3 min)
    P->>H: Call routed
    D->>H: "Table for 4 at 7pm Friday?"
    H->>B: Check paper reservation book
    B-->>H: Manual check for conflicts
    alt Table Available
        H->>D: "Yes, available"
        D->>H: Provide name & phone number
        H->>B: Write booking manually
        H->>D: "See you then!" (verbal only)
        Note over D: No confirmation - Anxiety!
    else Table Not Available
        H->>D: "Sorry, fully booked"
        D->>P: Call next restaurant
    end
```

**Pain Points:**

- ⏱️ **5-10 minute process** (hold time + conversation)
- 📵 **No confirmation** → diner anxiety
- 🚫 **Host interrupted** during dinner rush
- 📊 **No data** captured for analytics

---

## Booking Flow - To-Be (ReserveEasy Platform)

**Future State:** How reservations work with ReserveEasy

```mermaid
sequenceDiagram
    autonumber
    participant D as Diner
    participant A as ReserveEasy App
    participant DB as Database
    participant SMS as Twilio SMS
    participant RD as Restaurant Dashboard

    D->>A: Search "Italian, Manhattan"
    A->>DB: Query restaurants
    DB-->>A: Return matches
    A-->>D: Display results

    D->>A: Select "Bella Italia"
    A-->>D: Show restaurant details

    D->>A: Select date & party size
    A->>DB: Check real-time availability
    DB-->>A: Available tables
    A-->>D: Show time slots

    D->>A: Select 7:00 PM
    D->>A: Fill form (name, email, phone)
    D->>A: Submit booking

    A->>DB: Create booking record
    DB-->>A: Booking ID = 12345

    par Parallel Actions
        A->>SMS: Send confirmation SMS
        SMS-->>D: SMS delivered (30 sec)
        and
        A->>RD: Notify restaurant
        RD-->>RD: New booking alert
    end

    A-->>D: Confirmation page - Code: ABC123

    Note over D: Instant proof of booking - Peace of mind!
```

**Improvements:**

- ⚡ **60 seconds total** (vs 5-10 minutes)
- ✅ **SMS confirmation** within 30 seconds
- 📊 **Real-time availability** (no double-bookings)
- 📈 **Analytics captured** automatically

---

## Cancellation Flow

**User Story:** As a diner, I want to cancel my reservation so I can free up the table if my plans change.

```mermaid
flowchart TD
    Start([Diner clicks Cancel Reservation]) --> Check{When is the booking?}

    Check -->|> 24 hours| FullRefund[Full refund - if deposit paid]
    Check -->|2-24 hours| PartialRefund[50% refund - if deposit paid]
    Check -->|< 2 hours| NoRefund[No refund]

    FullRefund --> UpdateDB[Update booking status to cancelled]
    PartialRefund --> UpdateDB
    NoRefund --> UpdateDB

    UpdateDB --> SendSMS[Send SMS Cancellation confirmed]
    SendSMS --> NotifyRestaurant[Notify restaurant - via dashboard]

    FullRefund --> ProcessRefund{Deposit - paid?}
    PartialRefund --> ProcessRefund
    NoRefund --> ProcessRefund

    ProcessRefund -->|Yes| InitiateRefund[Stripe refund API - 3-5 business days]
    ProcessRefund -->|No| Skip[Skip refund]

    InitiateRefund --> End([Cancellation - complete])
    Skip --> End
    NotifyRestaurant --> End

    style FullRefund fill:#90EE90
    style PartialRefund fill:#FFD700
    style NoRefund fill:#FF6B6B
```

**Business Rules:**

- Cancellations **>24 hours before:** Full refund
- Cancellations **2-24 hours before:** 50% refund
- Cancellations **<2 hours before:** No refund (penalize last-minute cancellations)

---

## Restaurant Confirmation Workflow

**Use Case:** Restaurant host marks a booking as "completed" or "no-show"

```mermaid
stateDiagram-v2
    [*] --> Confirmed: Booking created

    Confirmed --> InProgress: Booking time arrives
    InProgress --> Completed: Diner shows up, Host marks Seated
    InProgress --> NoShow: Diner doesnt arrive, 15 min past booking time

    Completed --> RefundDeposit: If deposit paid
    RefundDeposit --> [*]

    NoShow --> ChargeDeposit: If deposit paid
    NoShow --> FlagUser: Add to no-show history
    ChargeDeposit --> [*]
    FlagUser --> [*]

    Confirmed --> Cancelled: User cancels
    Cancelled --> ProcessRefund: Based on cancellation policy
    ProcessRefund --> [*]

    note right of NoShow
        No-show tracked for analytics
        Repeat offenders flagged
    end note

    note right of Completed
        Deposit refunded within 24 hours
        Commission charged to restaurant
    end note
```

**State Transitions:**

1. **Confirmed** → Booking created, awaiting arrival
2. **In Progress** → Booking time has arrived (within 15-min window)
3. **Completed** → Diner showed up, deposit refunded, commission charged
4. **No-Show** → Diner didn't arrive, deposit kept, restaurant compensated
5. **Cancelled** → User cancelled before booking time

---

## SMS Notification Flow

**Purpose:** Ensure users receive timely confirmations and reminders

```mermaid
gantt
    title SMS Notification Timeline
    dateFormat HH:mm
    axisFormat %H:%M

    section Booking Day
    User submits booking           :milestone, 09:00, 0m
    Immediate SMS confirmation     :crit, 09:00, 1m

    section Day Before
    24-hour reminder SMS           :done, 19:00, 1m

    section Booking Day
    2-hour reminder SMS            :active, 17:00, 1m
    Booking time (7pm)             :milestone, 19:00, 0m
```

**SMS Types:**

1. **Instant Confirmation** (within 30 sec of booking)
2. **24-Hour Reminder** (day before at 7 PM)
3. **2-Hour Reminder** (2 hours before booking)

---

## Key Metrics from Process Maps

| Process                 | As-Is (Phone)     | To-Be (ReserveEasy)  | Improvement          |
| ----------------------- | ----------------- | -------------------- | -------------------- |
| **Time to Book**        | 5-10 minutes      | 60 seconds           | 83-90% faster        |
| **Confirmation Method** | Verbal only       | SMS + Email          | Instant proof        |
| **No-Show Rate**        | 30%               | <5% (deposit system) | 83% reduction        |
| **Host Interruptions**  | ~20/evening       | 0 (automated)        | 100% reduction       |
| **Data Captured**       | None (paper book) | Full analytics       | Infinite improvement |

---

[← Back to Project](../README.md) | [Discovery →](../01-discovery/) | [Specs →](../02-specs/)
