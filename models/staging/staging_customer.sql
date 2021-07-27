{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_customer') }}
),

staging_customer as (
  select
    *,
	sysdate() as fdate,
	'source_customer' as data_origin	
  from source
)
select
  *
from staging_customer
