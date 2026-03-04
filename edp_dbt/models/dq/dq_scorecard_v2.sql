{{ config(materialized='view') }}

WITH test_summary AS (

    SELECT
        RUN_ID,
        COUNT(*) AS tests_logged,
        COUNT_IF(STATUS = 'FAIL') AS tests_failed,
        COALESCE(SUM(FAILURES),0) AS row_failures
    FROM {{ source('dq','DQ_TEST_RESULTS') }}
    GROUP BY RUN_ID

),

exception_summary AS (

    SELECT
        RUN_ID,
        COUNT(*) AS exception_rows
    FROM {{ source('dq','DQ_EXCEPTIONS') }}
    GROUP BY RUN_ID

)

SELECT
    r.RUN_ID,
    r.RUN_TS,
    r.ENV,
    r.STATUS AS run_status,

    COALESCE(t.tests_logged,0) AS tests_logged,
    COALESCE(t.tests_failed,0) AS tests_failed,
    COALESCE(t.row_failures,0) AS row_failures,

    COALESCE(e.exception_rows,0) AS exception_rows,

    CASE
        WHEN r.STATUS = 'FAILED'
          OR COALESCE(t.tests_failed,0) > 0
          OR COALESCE(e.exception_rows,0) > 0
        THEN 'FAIL'
        ELSE 'PASS'
    END AS quality_status,

    CASE
        WHEN COALESCE(t.tests_logged,0) = 0 THEN 100
        ELSE ROUND(
            100 * (COALESCE(t.tests_logged,0) - COALESCE(t.tests_failed,0))
            / COALESCE(t.tests_logged,0),
            2
        )
    END AS test_pass_percentage

FROM {{ source('dq','DQ_RUNS') }} r

LEFT JOIN test_summary t
    ON r.RUN_ID = t.RUN_ID

LEFT JOIN exception_summary e
    ON r.RUN_ID = e.RUN_ID