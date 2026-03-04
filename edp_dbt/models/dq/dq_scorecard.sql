{{ config(materialized='view') }}

SELECT 
    r.RUN_ID,
    r.RUN_TS,
    r.STATUS,
    COUNT(t.TEST_NAME) AS total_tests_logged,
    COALESCE(SUM(t.FAILURES),0) AS total_failures,

    CASE
        WHEN COUNT(t.TEST_NAME) = 0 THEN 100
        ELSE ROUND(
            100 * (COUNT(t.TEST_NAME) - COUNT_IF(t.STATUS = 'FAIL'))
            / COUNT(t.TEST_NAME),2
        )
    END AS pass_percentage

FROM {{ source('dq','DQ_RUNS') }} r

LEFT JOIN {{ source('dq','DQ_TEST_RESULTS') }} t
    ON r.RUN_ID = t.RUN_ID

GROUP BY
    r.RUN_ID,
    r.RUN_TS,
    r.STATUS