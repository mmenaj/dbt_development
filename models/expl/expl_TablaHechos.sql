{{ config(materialized='table') }}

with LN_OPS as (
  select * from {{ ref('link_order_part_supp') }} 
),
     S_OPS as (
  select * from {{ ref('sat_order_part_supp') }}
),
     H_ORDER as (
  select * from {{ ref('hub_order') }}
),
     S_PART as (
  select * from {{ ref('sat_part') }}
),
     LN_OC as (
  select * from {{ ref('link_order_customer') }}
),
     S_CUSTOMER as (
  select * from {{ ref('sat_customer') }}
),
     S_ORDERS as (
  select * from {{ ref('sat_orders') }}
),
     S_SUPPLIER as (
  select * from {{ ref('sat_supplier') }}
),
     A_DATEDIM as (
  select * from {{ ref('aux_datedim') }}
)



select 
ho.ORDER_ID,
sops.L_LINENUMBER as LINE_NUMBER,
sc.C_MKTSEGMENT as CUSTOMER_MKTSEGMENT,
sc.C_NAME as CUSTOMER_NAME,
sp.P_NAME as PART_NAME,
ss.S_NAME as SUPPLIER_NAME,
so.O_ORDERDATE as ORDER_DATE,
dod.D_YEAR as ORDER_DATE_YEAR,  
dod.D_MONTH as ORDER_DATE_MONTH,
dod.D_DAY as ORDER_DATE_DAY,  
so.O_ORDERPRIORITY as ORDER_PRIORITY,
so.O_SHIPPRIORITY as SHIP_PRIORITY,
sops.L_SHIPMODE as SHIPPING_MODE,
sops.L_QUANTITY as HC_QUANTITY,
sops.L_EXTENDEDPRICE HC_EXTENDEDPRICE,
so.O_TOTALPRICE as HC_ORDER_TOTAL_PRICE,
sops.L_DISCOUNT as HC_DISCOUNT,
--sps.PS_SUPPLYCOST as HC_SUPPLYCOST,
--sps.PS_AVAILQTY as HC_AVAILABLE_QTY,
sops.L_TAX as HC_TAX,
(sops.L_EXTENDEDPRICE * (1 - sops.L_DISCOUNT)) as CC_REVENUE,
(sops.L_EXTENDEDPRICE * (1 - sops.L_DISCOUNT) * (1 + sops.L_TAX)) as CC_FINAL_CHARGE,
--(sps.PS_SUPPLYCOST * sps.PS_AVAILQTY) as CC_SUPPLY_COST,
sops.L_COMMITDATE as COMMIT_DATE,
dcd.D_YEAR as COMMIT_DATE_YEAR,
dcd.D_MONTH as COMMIT_DATE_MONTH,
dcd.D_DAY as COMMIT_DATE_DAY,  
1 as FLG_COUNT
  
from  LN_OPS lops
INNER JOIN S_OPS sops
on lops.link_order_part_supp_key=sops.link_order_part_supp_key
INNER JOIN H_ORDER ho
on lops.order_key=ho.order_key
INNER JOIN S_PART sp
on lops.part_key=sp.part_key
INNER JOIN LN_OC loc
on lops.order_key=loc.order_key
INNER JOIN S_CUSTOMER sc
on loc.customer_key=sc.customer_key
INNER JOIN S_ORDERS so
on loc.order_key=so.order_key
INNER JOIN S_SUPPLIER ss
on lops.supplier_key=ss.supplier_key
INNER JOIN A_DATEDIM dod
on dod.d_date=so.O_ORDERDATE
INNER JOIN A_DATEDIM dcd
on dcd.d_date=sops.L_COMMITDATE 


WHERE
    sops.loadDate=(select max(loadDate) from S_OPS)
and   sp.loadDate=(select max(loadDate) from S_PART)
and   ss.loadDate=(select max(loadDate) from S_SUPPLIER)    
and   sc.loadDate=(select max(loadDate) from S_CUSTOMER)
and   so.loadDate=(select max(loadDate) from S_ORDERS)
