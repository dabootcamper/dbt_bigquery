{{ config(materialized="table") }}

SELECT
    c.channel_id
    , c.channel_name
    , c.channel_type
FROM {{ ref('channels') }} c