{{ config(materialized="table") }}

SELECT
    order_id
  , COALESCE(store_id, 0) AS store_id
  , COALESCE(channel_id, 0) AS channel_id
  , payment_order_id
  , delivery_order_id
  , UPPER(TRIM(order_status)) AS order_status
  , COALESCE(order_amount, 0) AS order_amount
  , COALESCE(order_delivery_fee, 0) AS order_delivery_fee
  , COALESCE(order_delivery_cost, 0) AS order_delivery_cost
  , order_created_hour
  , order_created_minute
  , order_created_day
  , order_created_month
  , order_created_year
  , order_moment_created
  , order_moment_accepted
  , order_moment_ready
  , order_moment_collected
  , order_moment_in_expedition
  , order_moment_delivering
  , order_moment_delivered
  , order_moment_finished
  , order_metric_collected_time
  , order_metric_paused_time
  , order_metric_production_time
  , order_metric_walking_time
  , order_metric_expediton_speed_time
  , order_metric_transit_time
  , order_metric_cycle_time
FROM {{ source('delivery_raw', 'orders') }}
WHERE order_id IS NOT NULL
