{{ config(materialized='incremental') }}

with source as (
  select * from {{ ref('staging_nation') }}
),

sat_nation as (
  select
	md5(UPPER(N_NATIONKEY)) as NATION_KEY,
N_NAME,
N_COMMENT,
  sysdate() as loadDate,
	null as loadEndDate,	
  'staging_nation' as dataSource
  from source
)
select
  *
from sat_nation
