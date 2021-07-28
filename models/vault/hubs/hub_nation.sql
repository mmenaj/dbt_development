{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_nation') }}
),

hub_nation as (
  select
    md5(UPPER(N_NATIONKEY)) as NATION_KEY,
    N_NATIONKEY as NATION_ID,
    sysdate() as loadDate,
    'staging_nation' as dataSource	
  from source
)
select
  *
from hub_nation
