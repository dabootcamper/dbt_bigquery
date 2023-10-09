{{ config(materialized="table") }}

SELECT
    store_id,
    hub_id,
    UPPER(TRIM(store_name)) AS store_name,
    UPPER(TRIM(store_segment)) AS store_segment,
    COALESCE(store_plan_price, 0) AS store_plan_price,
    store_latitude,
    store_longitude
FROM {{ source('delivery_raw', 'stores') }}
WHERE store_id IS NOT NULL