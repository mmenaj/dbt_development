{{ config(materialized='table') }}

with source_region as (
  select *,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION
)
select
  *
from source_region
