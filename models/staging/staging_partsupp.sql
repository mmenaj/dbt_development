{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_partsupp') }}
),

staging_partsupp as (
  select
    *,
	sysdate() as sdate,
	'source_partsupp' as staging_origin	
  from source
)
select
  *
from staging_partsupp
