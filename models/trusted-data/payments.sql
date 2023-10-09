{{ config(materialized="table") }}

SELECT
    payment_id
  , payment_order_id
  , COALESCE(payment_amount, 0) AS payment_amount
  , COALESCE(payment_fee, 0) AS payment_fee
  , TRIM(UPPER(payment_method)) AS payment_method
  , TRIM(UPPER(payment_status)) AS payment_status
FROM {{ source('delivery_raw', 'payments') }}