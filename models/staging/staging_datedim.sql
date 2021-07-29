{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_datedim') }}
),

staging_datedim as (
  select
    *,
	sysdate() as sdate,
	'source_datedim' as staging_origin	
  from source
)
select
  *
from staging_datedim
