{{ config(materialized='view') }}

with source as (
  select * from {{ ref('staging_nation') }}
),

link_nation_region as (
  select
    md5(UPPER(N_NATIONKEY) || UPPER(N_REGIONKEY)) as LINK_NATION_REGION_KEY,
	md5(UPPER(N_NATIONKEY)) as NATION_KEY,
	md5(UPPER(N_REGIONKEY)) as REGION_KEY,
    sysdate() as loadDate,
    'staging_nation' as dataSource	
  from source
)
select
  *
from link_nation_region
