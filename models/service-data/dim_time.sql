{{ config(materialized="table") }}

WITH calendario AS (
SELECT 
  DATE_ADD(CURRENT_DATE(), INTERVAL num DAY) date
FROM UNNEST(GENERATE_ARRAY(0, 365*10)) AS num
)
SELECT
  date
  , SUBSTRING(CAST(DATE_TRUNC(date, MONTH) AS STRING), 1, 7) month
  , CONCAT(EXTRACT(YEAR from date), '-', EXTRACT(QUARTER from date)) AS quarter
  , EXTRACT(YEAR from date) AS year
FROM calendario