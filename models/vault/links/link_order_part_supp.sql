{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_lineitem') }}
),

link_order_part_supp as (
  select
    md5(UPPER(L_ORDERKEY) || UPPER(L_PARTKEY) || UPPER(L_SUPPKEY) || UPPER(L_SHIPMODE) || UPPER((EXTRACT(YEAR FROM l_shipdate) || LPAD(EXTRACT(MONTH FROM l_shipdate), 2, '0')))) as LINK_ORDER_PART_SUPP_KEY,
	md5(UPPER(L_ORDERKEY)) as ORDER_KEY,
	md5(UPPER(L_PARTKEY)) as PART_KEY,
	md5(UPPER(L_SUPPKEY)) as SUPPLIER_KEY,
	md5(UPPER(L_SHIPMODE)) as SHIPMODE_KEY,
	md5(UPPER((EXTRACT(YEAR FROM l_shipdate) || LPAD(EXTRACT(MONTH FROM l_shipdate), 2, '0')))) AS SHIPDATE_KEY,
    sysdate() as loadDate,
    'staging_lineitem' as dataSource	
  from source
)
select
  *
from link_order_part_supp
