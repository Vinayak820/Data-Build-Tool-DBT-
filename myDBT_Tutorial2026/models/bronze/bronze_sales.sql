{{config(
    materialized='table'
)}}

SELECT
    *
FROM
    {{ source('source', 'fact_sales') }}