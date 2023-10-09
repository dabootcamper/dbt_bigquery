{{ config(materialized="table") }}

SELECT
    driver_id
  , driver_modal
  , driver_type
FROM {{ ref('drivers') }}
