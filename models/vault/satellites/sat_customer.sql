{{ config(materialized='incremental') }}

with source as (
  select * from {{ ref('staging_customer') }}
),

sat_customer as (
  select
	md5(UPPER(C_CUSTKEY)) as CUSTOMER_KEY,
	C_NAME,
	C_ADDRESS,
	C_PHONE,
	C_ACCTBAL,
	C_MKTSEGMENT,
	C_COMMENT, 
  sysdate() as loadDate,
	null as loadEndDate,	
  'staging_customer' as dataSource
  from source
)
select
  *
from sat_customer
