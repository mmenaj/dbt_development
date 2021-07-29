{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_orders') }}
),

link_order_customer as (
  select
    md5(UPPER(O_ORDERKEY) || UPPER(O_CUSTKEY)) as LINK_ORDER_CUSTOM_KEY,
	md5(UPPER(O_ORDERKEY)) as ORDER_KEY,
	md5(UPPER(O_CUSTKEY)) as CUSTOMER_KEY,
    sysdate() as loadDate,
    'staging_orders' as dataSource	
  from source
)
select
  *
from link_order_customer
