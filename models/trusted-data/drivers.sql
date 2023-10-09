{{ config(materialized="table") }}

SELECT
    driver_id
  , UPPER(TRIM(driver_modal)) AS driver_modal
  , UPPER(TRIM(driver_type)) AS driver_type
FROM {{ source('delivery_raw', 'drivers') }}
WHERE driver_id IS NOT NULL