{{ config(materialized='table') }}

with source_datedim as (
  select D_DATE,
		 D_YEAR AS D_YEAR,
		 D_MOY AS D_MONTH,
		 D_DOM AS D_DAY,
         sysdate() as fdate,
         'SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.DATE_DIM' as data_origin  
         from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.DATE_DIM
)
select
  *
from source_datedim
