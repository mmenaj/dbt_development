{{ config(materialized='incremental') }}

with source as (
  select * from {{ ref('staging_partsupp') }}
),

sat_part_supplier as (
  select
    md5(UPPER(PS_PARTKEY) || UPPER(PS_SUPPKEY)) as LINK_ORDER_PART_SUPP_KEY,
	PS_AVAILQTY,
	PS_SUPPLYCOST,
	PS_COMMENT,
    sysdate() as loadDate,
    'staging_partsupp' as dataSource	
  from source
)
select
  *
from sat_part_supplier
