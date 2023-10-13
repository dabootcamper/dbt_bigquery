{{ config(materialized="table") }}

SELECT
    driver_id
  , driver_modal
  , driver_type
FROM {{ ref('drivers') }}
UNION ALL
SELECT
    0 AS driver_id
  , 'N/A' AS driver_modal
  , 'N/A' AS driver_type