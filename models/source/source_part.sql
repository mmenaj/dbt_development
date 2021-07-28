{{ config(materialized='table') }}

with source_part as (
  select *,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.PART' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.PART
)
select
  *
from source_part
