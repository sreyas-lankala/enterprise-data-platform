{{ config(materialized='table') }}

SELECT
    c.customer_id,
    COUNT(o.order_id) AS total_orders,
    MIN(o.order_purchase_timestamp) AS first_order_date,
    MAX(o.order_purchase_timestamp) AS last_order_date,
    DATEDIFF(
        'day',
        MIN(o.order_purchase_timestamp),
        MAX(o.order_purchase_timestamp)
    ) AS customer_lifetime_days
FROM {{ ref('stg_customers') }} c
LEFT JOIN {{ ref('stg_orders') }} o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id