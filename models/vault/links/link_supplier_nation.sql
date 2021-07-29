{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_supplier') }}
),

link_supplier_nation as (
  select
    md5(UPPER(S_SUPPKEY) || UPPER(S_NATIONKEY)) as LINK_SUPPLIER_NATION_KEY,
	md5(UPPER(S_SUPPKEY)) as SUPPLIER_KEY,
	md5(UPPER(S_NATIONKEY)) as NATION_KEY,
    sysdate() as loadDate,
    'staging_supplier' as dataSource	
  from source
)
select
  *
from link_supplier_nation
