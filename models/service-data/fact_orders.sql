{{ config(materialized="table") }}

WITH deliveries AS (
    SELECT *
    FROM {{ ref('deliveries') }}
    QUALIFY ROW_NUMBER() OVER(PARTITION BY DELIVERY_ORDER_ID ORDER BY DELIVERY_ID DESC) = 1
)
SELECT
    CAST(o.ORDER_MOMENT_CREATED AS DATE) AS DATE
  , o.ORDER_ID
  , o.STORE_ID
  , o.CHANNEL_ID
  , d.DRIVER_ID
  , p.payment_method
  , o.ORDER_STATUS
  , o.ORDER_AMOUNT
  , o.ORDER_DELIVERY_COST
  , o.ORDER_DELIVERY_FEE
  , (o.ORDER_AMOUNT + o.ORDER_DELIVERY_COST + o.ORDER_DELIVERY_FEE) AS ORDER_TOTAL_GMV
  , o.ORDER_MOMENT_CREATED
  , o.ORDER_MOMENT_FINISHED
  , DATE_DIFF(o.ORDER_MOMENT_FINISHED, o.ORDER_MOMENT_CREATED, HOUR) as ORDER_TIEMPO_TRANSCURRIDO
FROM {{ ref('orders') }} o
    LEFT JOIN deliveries d
            ON d.DELIVERY_ORDER_ID = o.ORDER_ID
    LEFT JOIN {{ ref('dim_payments') }} p
            ON p.payment_order_id = o.order_id