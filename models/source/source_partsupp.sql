{{ config(materialized='table') }}

with source_partsupp as (
  select *,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.PARTSUPP' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.PARTSUPP
)
select
  *
from source_partsupp
