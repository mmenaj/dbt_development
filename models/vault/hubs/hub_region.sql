{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_region') }}
),

hub_region as (
  select
    md5(UPPER(R_REGIONKEY)) as REGION_KEY,
    R_REGIONKEY as REGION_ID,
    sysdate() as loadDate,
    'staging_region' as dataSource	
  from source
)
select
  *
from hub_region
