{{ config(materialized='table') }}

with source_customer as (
  select *,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER
)
select
  *
from source_customer
