{{ config(materialized='table') }}

with source_supplier as (
  select *,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.SUPPLIER' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.SUPPLIER
)
select
  *
from source_supplier
