{{ config(materialized='view', schema='OPS') }}

SELECT
    r.run_id,
    r.total_tests,
    r.failed_tests,
    r.anomaly_count,
    r.reliability_score_pct,
    k.total_customers,
    k.repeat_rate,
    r.last_activity_time
FROM {{ ref('reliability_scorecard') }} r
LEFT JOIN {{ ref('mart_customer_retention_kpis') }} k
    ON 1=1
ORDER BY r.last_activity_time DESC