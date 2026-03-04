{{ config(materialized='view') }}

SELECT
    run_id,
    run_ts,
    env,
    tests_logged,
    tests_failed,
    row_failures,
    exception_rows,
    quality_status
FROM {{ ref('dq_scorecard_v2') }}

WHERE quality_status = 'FAIL'