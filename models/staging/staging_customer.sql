{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_customer') }}
),

staging_customer as (
  select
    *,
	sysdate() as sdate,
	'source_customer' as staging_origin	
  from source
)
select
  *
from staging_customer
