{{ config(materialized="table") }}

WITH data AS (
    SELECT
    payment_order_id
    , payment_method
    , RANK() OVER(PARTITION BY payment_order_id ORDER BY payment_amount) fila
    FROM {{ source('delivery_raw', 'payments') }}
    WHERE payment_status = 'PAID'
)
SELECT
    payment_order_id,
    payment_method
FROM data
WHERE fila = 1
ORDER BY 1