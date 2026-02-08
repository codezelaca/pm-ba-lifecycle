-- ============================================
-- COHORT RETENTION ANALYSIS
-- Track how well we retain users over time
-- ============================================

-- Purpose: Measure what percentage of users come back to make additional bookings
-- after their first booking (activation event).

-- Step 1: Define cohorts by signup week
WITH user_cohorts AS (
    SELECT 
        user_id,
        DATE_TRUNC('week', created_at) AS cohort_week
    FROM users
    WHERE created_at >= NOW() - INTERVAL '12 weeks'
),

-- Step 2: Get first booking date for each user (activation)
first_bookings AS (
    SELECT 
        user_id,
        MIN(created_at) AS first_booking_date
    FROM bookings
    WHERE status IN ('confirmed', 'completed')
    GROUP BY user_id
),

-- Step 3: Count bookings by week offset from signup
booking_activity AS (
    SELECT 
        uc.cohort_week,
        uc.user_id,
        FLOOR(DATE_PART('day', b.created_at - uc.cohort_week) / 7) AS weeks_since_signup
    FROM user_cohorts uc
    JOIN bookings b ON uc.user_id = b.user_id
    WHERE b.status IN ('confirmed', 'completed')
),

-- Step 4: Calculate retention rates
cohort_retention AS (
    SELECT 
        cohort_week,
        weeks_since_signup,
        COUNT(DISTINCT user_id) AS active_users
    FROM booking_activity
    GROUP BY cohort_week, weeks_since_signup
),

-- Step 5: Get cohort sizes (total users who signed up)
cohort_sizes AS (
    SELECT 
        cohort_week,
        COUNT(*) AS cohort_size
    FROM user_cohorts
    GROUP BY cohort_week
)

-- Step 6: Final output - retention table
SELECT 
    cs.cohort_week,
    cs.cohort_size,
    cr.weeks_since_signup,
    cr.active_users,
    ROUND(100.0 * cr.active_users / cs.cohort_size, 1) AS retention_pct
FROM cohort_sizes cs
LEFT JOIN cohort_retention cr ON cs.cohort_week = cr.cohort_week
WHERE cr.weeks_since_signup IS NOT NULL
ORDER BY cs.cohort_week DESC, cr.weeks_since_signup;

-- Example Output:
-- cohort_week | cohort_size | weeks_since_signup | active_users | retention_pct
-- ------------+-------------+--------------------+--------------+--------------
-- 2026-01-01  | 1000        | 0                  | 400          | 40.0  (Week 0 = activation week)
-- 2026-01-01  | 1000        | 1                  | 320          | 32.0  (Week 1 retention)
-- 2026-01-01  | 1000        | 2                  | 280          | 28.0
-- 2026-01-01  | 1000        | 3                  | 260          | 26.0
-- 2026-01-01  | 1000        | 4                  | 250          | 25.0  (Stabilizing)
-- 2026-01-08  | 1200        | 0                  | 540          | 45.0  (Improved activation!)
-- 2026-01-08  | 1200        | 1                  | 420          | 35.0
-- 2026-01-08  | 1200        | 2                  | 384          | 32.0
-- 2026-01-08  | 1200        | 3                  | 360          | 30.0  (Better retention curve!)

-- INSIGHTS:
-- 1. Week 0 activation improved from 40% to 45% (Jan 1 → Jan 8 cohort)
-- 2. Week 4 retention is ~25-30% (industry benchmark: 20-25%)
-- 3. Retention curve flattens after Week 3 (users become "retained")

-- ACTION ITEMS:
-- - Focus on improving Week 1-2 retention (email reminders, special offers)
-- - Celebrate: Week 4 retention above industry average!
-- - Investigate what changed between Jan 1 and Jan 8 cohorts (feature launch? marketing campaign?)


-- ============================================
-- ALTERNATIVE: Day-Based Retention
-- ============================================

-- Some products prefer day-level granularity (Day 1, Day 7, Day 30)
WITH user_first_booking AS (
    SELECT 
        user_id,
        DATE(MIN(created_at)) AS first_booking_date
    FROM bookings
    WHERE status IN ('confirmed', 'completed')
    GROUP BY user_id
),

retention_by_day AS (
    SELECT 
        ufb.first_booking_date AS cohort_date,
        DATE_PART('day', b.created_at::date - ufb.first_booking_date) AS days_since_first,
        b.user_id
    FROM user_first_booking ufb
    JOIN bookings b ON ufb.user_id = b.user_id
    WHERE b.status IN ('confirmed', 'completed')
      AND b.created_at::date > ufb.first_booking_date -- Exclude the first booking itself
)

SELECT 
    cohort_date,
    days_since_first,
    COUNT(DISTINCT user_id) AS returning_users
FROM retention_by_day
WHERE cohort_date >= NOW() - INTERVAL '60 days'
  AND days_since_first IN (1, 7, 14, 30) -- Key retention milestones
GROUP BY cohort_date, days_since_first
ORDER BY cohort_date DESC, days_since_first;

-- Example Output:
-- cohort_date | days_since_first | returning_users
-- ------------+------------------+----------------
-- 2026-01-15  | 1                | 45   (Day 1 retention: early comeback)
-- 2026-01-15  | 7                | 120  (Day 7 retention: week later)
-- 2026-01-15  | 14               | 95   (Day 14: mid-month)
-- 2026-01-15  | 30               | 80   (Day 30: monthly retention)

-- Calculate retention rates:
-- If Jan 15 cohort had 400 activated users:
-- - Day 1: 45/400 = 11.3%
-- - Day 7: 120/400 = 30.0%
-- - Day 30: 80/400 = 20.0%


-- ============================================
-- RETENTION CURVE VISUALIZATION DATA
-- ============================================

-- Export this for charting in Tableau/Google Data Studio
WITH cohort_weeks AS (
    SELECT DISTINCT 
        DATE_TRUNC('week', created_at) AS cohort_week
    FROM users
    WHERE created_at >= NOW() - INTERVAL '12 weeks'
),

weeks_range AS (
    SELECT generate_series(0, 11) AS week_offset
)

SELECT 
    cw.cohort_week,
    wr.week_offset,
    COUNT(DISTINCT b.user_id) AS active_users,
    (SELECT COUNT(*) FROM users WHERE DATE_TRUNC('week', created_at) = cw.cohort_week) AS cohort_size,
    ROUND(
        100.0 * COUNT(DISTINCT b.user_id) / 
        NULLIF((SELECT COUNT(*) FROM users WHERE DATE_TRUNC('week', created_at) = cw.cohort_week), 0),
        1
    ) AS retention_pct
FROM cohort_weeks cw
CROSS JOIN weeks_range wr
LEFT JOIN users u ON DATE_TRUNC('week', u.created_at) = cw.cohort_week
LEFT JOIN bookings b ON u.user_id = b.user_id
    AND b.status IN ('confirmed', 'completed')
    AND DATE_TRUNC('week', b.created_at) = cw.cohort_week + (wr.week_offset || ' weeks')::INTERVAL
GROUP BY cw.cohort_week, wr.week_offset
ORDER BY cw.cohort_week DESC, wr.week_offset;

-- This creates a retention matrix perfect for heat map visualization!
