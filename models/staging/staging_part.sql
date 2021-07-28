{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_part') }}
),

staging_part as (
  select
    *,
	sysdate() as sdate,
	'source_part' as staging_origin	
  from source
)
select
  *
from staging_part
