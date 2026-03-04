{{ config(materialized='view') }}

SELECT
    d.table_name,
    d.column_name,
    d.data_owner,
    d.data_steward,
    o.domain,
    o.criticality,
    o.pii_flag,
    s.expected_refresh_minutes,
    s.last_refresh_time,
    s.sla_status
FROM {{ source('meta','DATA_DICTIONARY') }} d

LEFT JOIN {{ source('meta','DATA_OWNERSHIP') }} o
    ON d.table_name = o.table_name

LEFT JOIN {{ source('meta','DATA_PIPELINE_SLA') }} s
    ON d.table_name = s.pipeline_name