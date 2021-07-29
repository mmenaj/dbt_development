{{ config(materialized='incremental') }}

with source as (
  select * from {{ ref('staging_orders') }}
),

sat_orders as (
  select
	md5(UPPER(O_ORDERKEY)) as ORDER_KEY,
	O_CUSTKEY,
	O_ORDERSTATUS,
	O_TOTALPRICE,
	O_ORDERDATE,
	O_ORDERPRIORITY,
	O_CLERK,
	O_SHIPPRIORITY,
	O_COMMENT,
  sysdate() as loadDate,
	null as loadEndDate,	
  'staging_orders' as dataSource
  from source
)
select
  *
from sat_orders
