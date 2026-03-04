{{ config(materialized='view') }}

SELECT
    run_id,
    detector_name,
    dimension_name,
    dimension_value,
    metric_name,
    metric_value,
    baseline_avg,
    baseline_stddev,
    anomaly_flag,
    created_at
FROM {{ source('dq','ANOMALY_LOG') }}

WHERE anomaly_flag = 'TRUE'