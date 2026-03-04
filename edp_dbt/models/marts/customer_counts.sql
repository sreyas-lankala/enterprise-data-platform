{{ config(materialized='table') }}

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM {{ ref('stg_customers') }}
GROUP BY customer_state