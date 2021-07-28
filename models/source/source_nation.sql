{{ config(materialized='table') }}

with source_nation as (
  select *,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION
)
select
  *
from source_nation
