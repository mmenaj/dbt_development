{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_customer') }}
),

hub_customer as (
  select
    md5(UPPER(C_CUSTKEY)) as CUSTOMER_KEY,
    C_CUSTKEY as CUSTOMER_ID,
    sysdate() as loadDate,
    'staging_customer' as dataSource	
  from source
)
select
  *
from hub_customer
