{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_part') }}
),

hub_part as (
  select
    md5(UPPER(P_PARTKEY)) as PART_KEY,
    P_PARTKEY as PART_ID,
    sysdate() as loadDate,
    'staging_part' as dataSource	
  from source
)
select
  *
from hub_part
