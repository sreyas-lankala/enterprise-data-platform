{{ config(materialized='view') }}

SELECT *
FROM {{ ref('dq_scorecard_v2') }}
QUALIFY ROW_NUMBER() OVER (ORDER BY RUN_TS DESC) = 1