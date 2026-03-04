{{ config(materialized='view') }}

WITH source AS (

    SELECT *
    FROM {{ source('raw','olist_customers_raw') }}

),

standardized AS (

    SELECT
        trim(customer_id) as customer_id,
        trim(customer_unique_id) as customer_unique_id,
        cast(customer_zip_code_prefix as number) as customer_zip_code_prefix,
        upper(trim(customer_city)) as customer_city,
        upper(trim(customer_state)) as customer_state

    FROM source

)

SELECT *
FROM standardized