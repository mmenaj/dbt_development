{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_lineitem') }}
),

staging_lineitem as (
  select
    *,
	sysdate() as sdate,
	'source_lineitem' as staging_origin	
  from source
)
select
  *
from staging_lineitem
