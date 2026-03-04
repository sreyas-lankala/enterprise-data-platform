{{ config(materialized='view') }}

SELECT
    upstream_table,
    downstream_table,
    transformation_layer,
    transformation_tool,
    created_at
FROM {{ source('meta','LINEAGE_MAP') }}