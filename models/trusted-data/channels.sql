{{ config(materialized="table") }}

SELECT
    channel_id
  , TRIM(UPPER(channel_name)) AS channel_name
  , TRIM(UPPER(channel_type)) AS channel_type
FROM {{ source('delivery_raw', 'channels') }}
WHERE channel_id IS NOT NULL