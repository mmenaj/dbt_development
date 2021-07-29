{{ config(materialized='incremental') }}

with source as (
  select * from {{ ref('staging_region') }}
),

sat_region as (
  select
	md5(UPPER(R_REGIONKEY)) as REGION_KEY,
	R_NAME,
	R_COMMENT,
  sysdate() as loadDate,
	null as loadEndDate,	
  'staging_region' as dataSource
  from source
)
select
  *
from sat_region
