{{ config(materialized='table') }}

with source as (
  select * from {{ ref('source_orders') }}
),

staging_orders as (
  select
    *,
	sysdate() as sdate,
	'source_orders' as staging_origin	
  from source
)
select
  *
from staging_orders
