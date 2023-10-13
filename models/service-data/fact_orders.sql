{{ config(materialized="table") }}

WITH deliveries AS (
    SELECT *
    FROM {{ ref('deliveries') }}
    WHERE delivery_status = 'DELIVERED'
    QUALIFY ROW_NUMBER() OVER(PARTITION BY DELIVERY_ORDER_ID ORDER BY DELIVERY_ID DESC) = 1
)
SELECT
    CAST(o.ORDER_MOMENT_CREATED AS DATE) AS date
  , o.order_id
  , o.store_id
  , o.channel_id
  , COALESCE(d.DRIVER_ID, 0) AS driver_id
  , COALESCE(p.PAYMENT_METHOD, 'N/A') AS payment_method
  , o.order_status
  , ROUND(o.ORDER_AMOUNT, 3) AS order_amount
  , ROUND(o.ORDER_DELIVERY_COST, 3) AS order_delivery_cost
  , ROUND(o.ORDER_DELIVERY_FEE, 3) AS order_delivery_fee
  , ROUND(o.ORDER_AMOUNT + o.ORDER_DELIVERY_COST + o.ORDER_DELIVERY_FEE, 3) AS order_total_gmv
  , o.order_moment_created
  , o.order_moment_finished
  --Calcular en minutos para tener precision decimal y redondearla a 2 digitos decimales
  , ROUND(DATE_DIFF(o.ORDER_MOMENT_FINISHED, o.ORDER_MOMENT_CREATED, MINUTE)/60.0, 2) AS order_tiempo_transcurrido
--- Extra dates  
  , o.order_moment_accepted
  , o.order_moment_ready
  , o.order_moment_collected
  , o.order_moment_in_expedition
  , o.order_moment_delivering
  , o.order_moment_delivered
--- Extra metricas, si estan en null no es posible calcularlas, no convertir a 0 para no afectar los promedios
  , o.order_metric_collected_time
  , o.order_metric_paused_time
  , o.order_metric_production_time
  , o.order_metric_walking_time
  , o.order_metric_expediton_speed_time
  , o.order_metric_transit_time
  , o.order_metric_cycle_time
  --No convertir a 0, para no afectar los promedios
  , d.delivery_distance_meters
FROM {{ ref('orders') }} o
    LEFT JOIN deliveries d
            ON d.DELIVERY_ORDER_ID = o.ORDER_ID
    LEFT JOIN {{ ref('dim_payments') }} p
            ON p.payment_order_id = o.order_id
