{{ config(materialized='view') }}

WITH source AS (

    SELECT *
    FROM {{ source('raw','olist_orders_raw') }}

),

standardized AS (

    SELECT
        trim(order_id) as order_id,
        trim(customer_id) as customer_id,
        order_status,
        cast(order_purchase_timestamp as timestamp) as order_purchase_timestamp,
        cast(order_approved_at as timestamp) as order_approved_at,
        cast(order_delivered_carrier_date as timestamp) as order_delivered_carrier_date,
        cast(order_delivered_customer_date as timestamp) as order_delivered_customer_date,
        cast(order_estimated_delivery_date as timestamp) as order_estimated_delivery_date

    FROM source

)

SELECT *
FROM standardized