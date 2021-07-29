with S_SUPPLIER as (
  select * from {{ ref('sat_supplier') }}
),
 H_SUPPLIER as (
  select * from {{ ref('hub_supplier') }}
),
 LINK_SN as (
  select * from {{ ref('link_supplier_nation') }}
),
 H_NATION as (
  select * from {{ ref('hub_nation') }}
),
 S_NATION as (
  select * from {{ ref('sat_nation') }}
),
 LINK_NR as (
  select * from {{ ref('link_nation_region') }}
),
 S_REGION as (
  select * from {{ ref('sat_region') }}
)


select 
    sn.N_NAME as PAIS,
    sr.R_NAME as AREA,
    sum(ss.s_acctbal) as fact_balance
from S_SUPPLIER ss
inner join H_SUPPLIER s
on s.supplier_key=ss.supplier_key
inner join LINK_SN lsn
on lsn.supplier_key=ss.supplier_key
inner join H_NATION n
on n.nation_key=lsn.nation_key
inner join S_NATION sn
on sn.nation_key=n.nation_key
inner join LINK_NR lnr
on lnr.nation_key=sn.nation_key
inner join S_REGION sr
on sr.region_key=lnr.region_key
where sn.loaddate=(select max(loaddate) from S_NATION)
  and ss.loaddate=(select max(loaddate) from S_SUPPLIER)
  and sr.loaddate=(select max(loaddate) from S_REGION)                             
                               

group by
PAIS,AREA
