{{ config(materialized='table') }}

with source_orders as (
  select *,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
)
select
  *
from source_orders
