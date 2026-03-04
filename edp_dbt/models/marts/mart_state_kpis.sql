{{ config(materialized='table') }}

SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(o.order_id) AS total_orders,
    ROUND(COUNT(o.order_id) / COUNT(DISTINCT c.customer_id),2) AS avg_orders_per_customer
FROM {{ ref('stg_customers') }} c
LEFT JOIN {{ ref('stg_orders') }} o
ON c.customer_id = o.customer_id
GROUP BY c.customer_state