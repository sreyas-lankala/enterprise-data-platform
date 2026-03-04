{{ config(materialized='view', schema='DQ') }}

WITH test_summary AS (
    SELECT
        run_id,
        COUNT(*) AS total_tests,
        SUM(CASE WHEN status = 'FAIL' THEN 1 ELSE 0 END) AS failed_tests,
        MAX(executed_at) AS last_test_time
    FROM {{ source('dq','DQ_TEST_RESULTS') }}
    GROUP BY run_id
),

anomaly_summary AS (
    SELECT
        run_id,
        COUNT(*) AS anomaly_count,
        MAX(created_at) AS last_anomaly_time
    FROM {{ source('dq','ANOMALY_LOG') }}
    GROUP BY run_id
),

combined AS (
    SELECT
        COALESCE(t.run_id, a.run_id) AS run_id,
        COALESCE(total_tests, 0) AS total_tests,
        COALESCE(failed_tests, 0) AS failed_tests,
        COALESCE(anomaly_count, 0) AS anomaly_count,
        GREATEST(
            COALESCE(last_test_time, '1900-01-01'::timestamp_ntz),
            COALESCE(last_anomaly_time, '1900-01-01'::timestamp_ntz)
        ) AS last_activity_time
    FROM test_summary t
    FULL OUTER JOIN anomaly_summary a
        ON t.run_id = a.run_id
)

SELECT
    run_id,
    total_tests,
    failed_tests,
    anomaly_count,
    ROUND(
        CASE
            WHEN total_tests = 0 THEN 0
            ELSE ((total_tests - failed_tests) / total_tests::FLOAT) * 100
        END
    , 2) AS test_pass_rate_pct,
    ROUND(
        CASE
            WHEN total_tests = 0 THEN 0
            ELSE (
                ((total_tests - failed_tests) / total_tests::FLOAT) * 100
                - (anomaly_count * 5)
            )
        END
    , 2) AS reliability_score_pct,
    last_activity_time
FROM combined