{{ config(materialized='view') }}

-- Data Quality Failures
SELECT
    'DQ_FAILURE'        AS alert_type,
    run_id              AS reference_id,
    run_ts              AS alert_time,
    quality_status      AS alert_status
FROM {{ ref('dq_failure_alerts') }}

UNION ALL

-- SLA Breaches
SELECT
    'SLA_BREACH'        AS alert_type,
    pipeline_name       AS reference_id,
    last_refresh_time   AS alert_time,
    sla_status          AS alert_status
FROM {{ ref('sla_breach_alerts') }}

UNION ALL

-- Anomaly Detection
SELECT
    'ANOMALY_DETECTED'  AS alert_type,
    run_id              AS reference_id,
    created_at          AS alert_time,
    anomaly_flag        AS alert_status
FROM {{ ref('anomaly_alerts') }}