-- ============================================
-- BOOKING FUNNEL ANALYSIS
-- Track user drop-off through the booking process
-- ============================================

-- Purpose: Identify where users are abandoning the booking flow
-- so we can optimize conversion rates.

-- Step 1: Define the funnel stages
WITH funnel_events AS (
    SELECT 
        session_id,
        MIN(CASE WHEN event_name = 'restaurant_search' THEN created_at END) AS search_time,
        MIN(CASE WHEN event_name = 'restaurant_view' THEN created_at END) AS view_time,
        MIN(CASE WHEN event_name = 'booking_form_started' THEN created_at END) AS form_start_time,
        MIN(CASE WHEN event_name = 'payment_initiated' THEN created_at END) AS payment_time,
        MIN(CASE WHEN event_name = 'booking_confirmed' THEN created_at END) AS confirmed_time
    FROM analytics_events
    WHERE created_at >= NOW() - INTERVAL '30 days'
    GROUP BY session_id
),

-- Step 2: Calculate funnel metrics
funnel_counts AS (
    SELECT 
        COUNT(DISTINCT session_id) AS total_sessions,
        COUNT(DISTINCT CASE WHEN search_time IS NOT NULL THEN session_id END) AS step1_search,
        COUNT(DISTINCT CASE WHEN view_time IS NOT NULL THEN session_id END) AS step2_view,
        COUNT(DISTINCT CASE WHEN form_start_time IS NOT NULL THEN session_id END) AS step3_form,
        COUNT(DISTINCT CASE WHEN payment_time IS NOT NULL THEN session_id END) AS step4_payment,
        COUNT(DISTINCT CASE WHEN confirmed_time IS NOT NULL THEN session_id END) AS step5_confirmed
    FROM funnel_events
)

-- Step 3: Calculate conversion rates and drop-off
SELECT 
    'Search' AS step,
    1 AS step_number,
    step1_search AS users,
    100.0 AS conversion_from_previous_pct,
    0.0 AS drop_off_pct
FROM funnel_counts

UNION ALL

SELECT 
    'View Restaurant',
    2,
    step2_view,
    ROUND(100.0 * step2_view / NULLIF(step1_search, 0), 1),
    ROUND(100.0 * (step1_search - step2_view) / NULLIF(step1_search, 0), 1)
FROM funnel_counts

UNION ALL

SELECT 
    'Start Booking Form',
    3,
    step3_form,
    ROUND(100.0 * step3_form / NULLIF(step2_view, 0), 1),
    ROUND(100.0 * (step2_view - step3_form) / NULLIF(step2_view, 0), 1)
FROM funnel_counts

UNION ALL

SELECT 
    'Payment',
    4,
    step4_payment,
    ROUND(100.0 * step4_payment / NULLIF(step3_form, 0), 1),
    ROUND(100.0 * (step3_form - step4_payment) / NULLIF(step3_form, 0), 1)
FROM funnel_counts

UNION ALL

SELECT 
    'Booking Confirmed',
    5,
    step5_confirmed,
    ROUND(100.0 * step5_confirmed / NULLIF(step4_payment, 0), 1),
    ROUND(100.0 * (step4_payment - step5_confirmed) / NULLIF(step4_payment, 0), 1)
FROM funnel_counts

ORDER BY step_number;

-- Example Output:
-- step                    | step_number | users  | conversion_from_previous_pct | drop_off_pct
-- ------------------------+-------------+--------+-----------------------------+-------------
-- Search                  | 1           | 10000  | 100.0                       | 0.0
-- View Restaurant         | 2           | 7000   | 70.0                        | 30.0
-- Start Booking Form      | 3           | 5000   | 71.4                        | 28.6
-- Payment                 | 4           | 4000   | 80.0                        | 20.0
-- Booking Confirmed       | 5           | 3500   | 87.5                        | 12.5

-- INSIGHTS:
-- 1. Biggest drop-off is Search → View (30%) - Maybe search results are irrelevant?
-- 2. Form → Payment has 20% drop-off - Could be too many fields or payment concerns
-- 3. Overall conversion rate: 35% (3,500 / 10,000) - Industry benchmark is ~25%

-- ACTION ITEMS:
-- - Improve search relevance (personalization, better filters)
-- - Simplify booking form (fewer required fields)
-- - Add trust signals at payment step (SSL badge, money-back guarantee)


-- ============================================
-- ADVANCED: Funnel by Traffic Source
-- ============================================

-- Which acquisition channels convert best?
WITH funnel_by_source AS (
    SELECT 
        COALESCE(event_properties->>'utm_source', 'direct') AS source,
        session_id,
        MIN(CASE WHEN event_name = 'restaurant_search' THEN 1 ELSE 0 END) AS searched,
        MIN(CASE WHEN event_name = 'booking_confirmed' THEN 1 ELSE 0 END) AS converted
    FROM analytics_events
    WHERE created_at >= NOW() - INTERVAL '30 days'
    GROUP BY source, session_id
)

SELECT 
    source,
    COUNT(*) AS total_sessions,
    SUM(searched) AS searches,
    SUM(converted) AS conversions,
    ROUND(100.0 * SUM(converted) / NULLIF(SUM(searched), 0), 1) AS conversion_rate_pct
FROM funnel_by_source
GROUP BY source
ORDER BY conversions DESC;

-- Example Output:
-- source          | total_sessions | searches | conversions | conversion_rate_pct
-- ----------------+----------------+----------+-------------+--------------------
-- google_ads      | 3500           | 3200     | 1280        | 40.0
-- facebook_ads    | 2800           | 2500     | 750         | 30.0
-- organic         | 2000           | 1800     | 540         | 30.0
-- direct          | 1700           | 1500     | 930         | 62.0

-- INSIGHT: Direct traffic converts at 62%! These are likely repeat users.
-- ACTION: Invest more in retention/email marketing, not just acquisition ads.
