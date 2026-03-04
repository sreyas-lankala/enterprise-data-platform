{{ config(materialized='view') }}

SELECT
    pipeline_name,
    expected_refresh_minutes,
    last_refresh_time,
    DATEDIFF(
        minute,
        last_refresh_time,
        CURRENT_TIMESTAMP
    ) AS minutes_since_last_refresh,
    sla_status
FROM {{ source('meta','DATA_PIPELINE_SLA') }}

WHERE DATEDIFF(
        minute,
        last_refresh_time,
        CURRENT_TIMESTAMP
    ) > expected_refresh_minutes