{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_orders') }}
),

hub_order as (
  select
    md5(UPPER(O_ORDERKEY)) as ORDER_KEY,
    O_ORDERKEY as ORDER_ID,
    sysdate() as loadDate,
    'staging_orders' as dataSource	
  from source
)
select
  *
from hub_order
