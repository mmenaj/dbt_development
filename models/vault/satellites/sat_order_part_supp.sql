{{ config(materialized='incremental') }}

with source as (
  select * from {{ ref('staging_lineitem') }}
),

sat_order_part_supp as (
  select
    md5(UPPER(L_ORDERKEY) || UPPER(L_PARTKEY) || UPPER(L_SUPPKEY) || UPPER(L_SHIPMODE) || UPPER((EXTRACT(YEAR FROM l_shipdate) || LPAD(EXTRACT(MONTH FROM l_shipdate), 2, '0')))) as LINK_ORDER_PART_SUPP_KEY,
	L_LINENUMBER,
	L_QUANTITY,
	L_EXTENDEDPRICE,
	L_DISCOUNT,
	L_TAX,
	L_RETURNFLAG,
	L_LINESTATUS,
	(EXTRACT(YEAR FROM l_shipdate) || LPAD(EXTRACT(MONTH FROM l_shipdate), 2, '0')) as L_SHIPDATE,
	L_COMMITDATE,
	L_RECEIPTDATE,
	L_SHIPINSTRUCT,
	L_SHIPMODE,
	L_COMMENT,
    sysdate() as loadDate,
    'staging_lineitem' as dataSource	
  from source
)
select
  *
from sat_order_part_supp
