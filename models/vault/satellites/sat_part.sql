{{ config(materialized='incremental') }}

with source as (
  select * from {{ ref('staging_part') }}
),

sat_part as (
  select
	md5(UPPER(P_PARTKEY)) as PART_KEY,
	P_NAME,
	P_MFGR,
	P_BRAND,
	P_TYPE,
	P_SIZE,
	P_CONTAINER,
	P_RETAILPRICE,
	P_COMMENT,
  sysdate() as loadDate,
	null as loadEndDate,	
  'staging_part' as dataSource
  from source
)
select
  *
from sat_part
