{{ config(materialized='view') }}

with source as (
  select * from {{ ref('staging_partsupp') }}
),

link_part_supplier as (
  select
    md5(UPPER(PS_PARTKEY) || UPPER(PS_SUPPKEY)) as LINK_PART_SUPPLIER_KEY,
	md5(UPPER(PS_PARTKEY)) as PART_KEY,
	md5(UPPER(PS_SUPPKEY)) as SUPPLIER_KEY,
    sysdate() as loadDate,
    'staging_partsupp' as dataSource	
  from source
)
select
  *
from link_part_supplier
