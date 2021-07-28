{{ config(materialized='table') }}

with source_lineitem as (
  select *,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM
)
select
  *
from source_lineitem
