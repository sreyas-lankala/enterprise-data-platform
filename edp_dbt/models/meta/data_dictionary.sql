{{ config(materialized='view') }}

SELECT
    table_name,
    column_name,
    data_type,
    description,
    business_definition,
    data_owner,
    data_steward,
    created_at
FROM {{ source('meta','DATA_DICTIONARY') }}