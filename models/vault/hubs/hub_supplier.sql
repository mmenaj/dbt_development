{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_supplier') }}
),

hub_supplier as (
  select
    md5(UPPER(S_SUPPKEY)) as SUPPLIER_KEY,
    S_SUPPKEY as SUPPLIER_ID,
    sysdate() as loadDate,
    'staging_supplier' as dataSource	
  from source
)
select
  *
from hub_supplier
