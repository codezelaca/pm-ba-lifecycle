-- ============================================
-- A/B TEST STATISTICAL ANALYSIS
-- Determine if test results are statistically significant
-- ============================================

-- Purpose: Scientifically validate whether a new feature variant outperforms
-- the control, ens uring we don't ship false positives.

-- TEST SCENARIO:
-- A/B Test: Button text on booking form
-- - Control (Variant A): "Book Now"
-- - Treatment (Variant B): "Reserve Table"
-- Hypothesis: "Reserve Table" sounds more premium → higher click-through rate

-- ============================================
-- Step 1: Collect Test Data
-- ============================================

-- Assume we logged test assignments to analytics_events
WITH test_data AS (
    SELECT 
        user_id,
        session_id,
        event_properties->>'ab_test_variant' AS variant, -- 'A' or 'B'
        MAX(CASE WHEN event_name = 'booking_button_click' THEN 1 ELSE 0 END) AS clicked
    FROM analytics_events
    WHERE event_name IN ('booking_form_view', 'booking_button_click')
      AND event_properties->>'ab_test_name' = 'booking_button_text'
      AND created_at >= '2026-02-01'
      AND created_at < '2026-02-08' -- 1 week test duration
    GROUP BY user_id, session_id, variant
),

-- Step 2: Calculate Conversion Rates by Variant
variant_stats AS (
    SELECT 
        variant,
        COUNT(*) AS total_users,
        SUM(clicked) AS conversions,
        ROUND(100.0 * SUM(clicked) / COUNT(*), 2) AS conversion_rate_pct
    FROM test_data
    WHERE variant IN ('A', 'B')
    GROUP BY variant
),

-- Step 3: Calculate Statistical Significance (Z-test for proportions)
combined_stats AS (
    SELECT 
        SUM(CASE WHEN variant = 'A' THEN total_users END) AS n_a,
        SUM(CASE WHEN variant = 'A' THEN conversions END) AS x_a,
        SUM(CASE WHEN variant = 'B' THEN total_users END) AS n_b,
        SUM(CASE WHEN variant = 'B' THEN conversions END) AS x_b
    FROM variant_stats
),

z_test AS (
    SELECT 
        n_a,
        x_a,
        n_b,
        x_b,
        ROUND(x_a::NUMERIC / n_a, 4) AS p_a, -- Conversion rate A
        ROUND(x_b::NUMERIC / n_b, 4) AS p_b, -- Conversion rate B
        ROUND((x_a + x_b)::NUMERIC / (n_a + n_b), 4) AS p_pooled,
        
        -- Z-score formula
        ROUND(
            (x_b::NUMERIC / n_b - x_a::NUMERIC / n_a) / 
            SQRT(
                ((x_a + x_b)::NUMERIC / (n_a + n_b)) *
                (1 - (x_a + x_b)::NUMERIC / (n_a + n_b)) *
                (1.0 / n_a + 1.0 / n_b)
            ),
            3
        ) AS z_score
    FROM combined_stats
)

-- Step 4: Final Results with Interpretation
SELECT 
    'A (Book Now)' AS variant,
    n_a AS sample_size,
    x_a AS conversions,
    ROUND(100.0 * p_a, 2) AS conversion_rate_pct
FROM z_test

UNION ALL

SELECT 
    'B (Reserve Table)',
    n_b,
    x_b,
    ROUND(100.0 * p_b, 2)
FROM z_test

UNION ALL

SELECT 
    'Difference',
    NULL,
    x_b - x_a,
    ROUND(100.0 * (p_b - p_a), 2)
FROM z_test

UNION ALL

SELECT 
    'Relative Lift',
    NULL,
    NULL,
    ROUND(100.0 * (p_b - p_a) / p_a, 2) || '%'
FROM z_test

UNION ALL

SELECT 
    'Z-Score',
    NULL,
    NULL,
    z_score::TEXT
FROM z_test

UNION ALL

SELECT 
    'Significance',
    NULL,
    NULL,
    CASE 
        WHEN ABS(z_score) >= 1.96 THEN 'YES (p < 0.05)'
        WHEN ABS(z_score) >= 1.645 THEN 'Marginal (p < 0.10)'
        ELSE 'NO (not significant)'
    END
FROM z_test;

-- Example Output:
-- variant                 | sample_size | conversions | conversion_rate_pct
-- ------------------------+-------------+-------------+--------------------
-- A (Book Now)            | 5000        | 1250        | 25.00
-- B (Reserve Table)       | 5000        | 1400        | 28.00
-- Difference              | NULL        | 150         | 3.00
-- Relative Lift           | NULL        | NULL        | 12.00%
-- Z-Score                 | NULL        | NULL        | 4.123
-- Significance            | NULL        | NULL        | YES (p < 0.05)

-- INTERPRETATION:
-- - Variant B improved conversion by 3 percentage points (absolute)
-- - That's a 12% relative improvement over the control
-- - Z-score of 4.123 >> 1.96 → Highly significant (p < 0.001)
-- - DECISION: Ship "Reserve Table" to 100% of users


-- ============================================
-- ADVANCED: Segmented Analysis
-- ============================================

-- Does the effect differ by user segment?
WITH test_data_segmented AS (
    SELECT 
        ae.user_id,
        ae.session_id,
        ae.event_properties->>'ab_test_variant' AS variant,
        CASE 
            WHEN u.created_at >= NOW() - INTERVAL '30 days' THEN 'New User'
            ELSE 'Returning User'
        END AS user_segment,
        MAX(CASE WHEN ae.event_name = 'booking_button_click' THEN 1 ELSE 0 END) AS clicked
    FROM analytics_events ae
    LEFT JOIN users u ON ae.user_id = u.user_id
    WHERE ae.event_name IN ('booking_form_view', 'booking_button_click')
      AND ae.event_properties->>'ab_test_name' = 'booking_button_text'
      AND ae.created_at >= '2026-02-01'
      AND ae.created_at < '2026-02-08'
    GROUP BY ae.user_id, ae.session_id, variant, user_segment
)

SELECT 
    user_segment,
    variant,
    COUNT(*) AS users,
    SUM(clicked) AS conversions,
    ROUND(100.0 * SUM(clicked) / COUNT(*), 2) AS conversion_rate_pct
FROM test_data_segmented
WHERE variant IN ('A', 'B')
GROUP BY user_segment, variant
ORDER BY user_segment, variant;

-- Example Output:
-- user_segment      | variant | users | conversions | conversion_rate_pct
-- ------------------+---------+-------+-------------+--------------------
-- New User          | A       | 3000  | 600         | 20.00
-- New User          | B       | 3000  | 750         | 25.00  (+5pp lift!)
-- Returning User    | A       | 2000  | 650         | 32.50
-- Returning User    | B       | 2000  | 650         | 32.50  (No effect)

-- INSIGHT: "Reserve Table" works great for NEW users (+25% lift), but
-- returning users don't care (they already trust us).
-- ACTION: Personalize button text based on user segment!


-- ============================================
-- SAMPLE SIZE CALCULATOR (Pre-Test Planning)
-- ============================================

-- Before running a test, calculate required sample size:
-- Formula: n = (Z * sqrt(2 * p * (1-p)) / MDE)^2 per variant
-- Where:
-- - Z = 1.96 for 95% confidence (2.576 for 99%)
-- - p = baseline conversion rate
-- - MDE = Minimum Detectable Effect (e.g., 0.02 for 2pp improvement)

WITH sample_size_calc AS (
    SELECT 
        0.25 AS baseline_rate,     -- 25% current conversion
        0.02 AS min_detectable_effect, -- Want to detect 2pp improvement
        1.96 AS z_score             -- 95% confidence
)

SELECT 
    baseline_rate,
    min_detectable_effect,
    z_score,
    CEIL(
        POWER(
            z_score * SQRT(2 * baseline_rate * (1 - baseline_rate)) / min_detectable_effect,
            2
        )
    ) AS required_sample_size_per_variant,
    CEIL(
        POWER(
            z_score * SQRT(2 * baseline_rate * (1 - baseline_rate)) / min_detectable_effect,
            2
        ) * 2
    ) AS total_required_sample_size
FROM sample_size_calc;

-- Example Output:
-- baseline_rate | min_detectable_effect | z_score | required_sample_size_per_variant | total
-- --------------+-----------------------+---------+----------------------------------+-------
-- 0.25          | 0.02                  | 1.96    | 1921                             | 3842

-- INTERPRETATION: Need ~1,900 users per variant (3,800 total) to detect
-- a 2 percentage point improvement with 95% confidence.
-- With 500 users/day, the test should run for 8 days.
