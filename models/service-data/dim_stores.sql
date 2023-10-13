{{ config(materialized="table") }}

SELECT
    s.store_id,
    s.store_name,
    s.store_segment,
    s.store_plan_price,
    s.store_latitude,
    s.store_longitude,
    h.hub_id,
    h.hub_name,
    h.hub_city,
    h.hub_state
FROM {{ ref('stores') }} s
    LEFT JOIN {{ ref('hubs') }} h
        ON s.hub_id = h.hub_id
WHERE s.store_id IS NOT NULL