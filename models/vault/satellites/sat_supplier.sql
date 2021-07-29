{{ config(materialized='incremental') }}

with source as (
  select * from {{ ref('staging_supplier') }}
),

sat_supplier as (
  select
	md5(UPPER(S_SUPPKEY)) as SUPPLIER_KEY,
	S_NAME,
	S_ADDRESS,
	S_NATIONKEY,
	S_PHONE,
	S_ACCTBAL,
	S_COMMENT,
  sysdate() as loadDate,
	null as loadEndDate,	
  'staging_supplier' as dataSource
  from source
)
select
  *
from sat_supplier
