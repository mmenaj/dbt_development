{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_supplier') }}
),

staging_supplier as (
  select
    *,
	sysdate() as sdate,
	'source_supplier' as staging_origin	
  from source
)
select
  *
from staging_supplier
