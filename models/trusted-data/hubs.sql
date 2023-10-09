{{ config(materialized="table") }}

SELECT
    hub_id
  , TRIM(UPPER(hub_name)) AS hub_name
  , TRIM(UPPER(hub_city)) AS hub_city
  , TRIM(UPPER(hub_state)) AS hub_state
  , hub_latitude
  , hub_longitude
FROM {{ source('delivery_raw', 'hubs') }}