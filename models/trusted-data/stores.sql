{{ config(materialized="table") }}

SELECT
   *
FROM {{ source('delivery_raw', 'stores') }}