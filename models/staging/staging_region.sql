{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_region') }}
),

staging_region as (
  select
    *,
	sysdate() as sdate,
	'source_region' as staging_origin	
  from source
)
select
  *
from staging_region
