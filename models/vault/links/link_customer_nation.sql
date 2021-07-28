{{ config(materialized='view') }}

with source as (
  select * from {{ ref('staging_customer') }}
),

link_customer_nation as (
  select
    md5(UPPER(C_CUSTKEY) || UPPER(C_NATIONKEY)) as LINK_CUSTOMER_NATION_KEY,
	  md5(UPPER(C_CUSTKEY)) as CUSTOMER_KEY,
	  md5(UPPER(C_NATIONKEY)) as NATION_KEY,
    sysdate() as loadDate,
    'staging_customer' as dataSource	
  from source
)
select
  *
from link_customer_nation
