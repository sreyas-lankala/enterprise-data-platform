{{ config(materialized='table') }}

WITH state_metrics AS (

SELECT
    customer_state,
    total_orders
FROM {{ ref('mart_state_kpis') }}

),

stats AS (

SELECT
    AVG(total_orders) AS avg_orders,
    STDDEV(total_orders) AS std_orders
FROM state_metrics

)

SELECT
    s.customer_state,
    s.total_orders,
    CASE
        WHEN s.total_orders > stats.avg_orders + (2 * stats.std_orders)
        THEN 'HIGH_ANOMALY'
        WHEN s.total_orders < stats.avg_orders - (2 * stats.std_orders)
        THEN 'LOW_ANOMALY'
        ELSE 'NORMAL'
    END AS anomaly_flag
FROM state_metrics s
CROSS JOIN stats