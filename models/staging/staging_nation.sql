{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_nation') }}
),

staging_nation as (
  select
    *,
	sysdate() as sdate,
	'source_nation' as staging_origin	
  from source
)
select
  *
from staging_nation
