{{ config(materialized='table') }}

WITH customer_orders AS (

SELECT
    customer_id,
    COUNT(order_id) AS order_count
FROM {{ ref('stg_orders') }}
GROUP BY customer_id

)

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    SUM(CASE WHEN order_count = 1 THEN 1 ELSE 0 END) AS one_time_customers,
    ROUND(
        SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS repeat_rate
FROM customer_orders