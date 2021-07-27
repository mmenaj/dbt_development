with source_customer as (
  select * from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER"
)
select
  *
from source_customer
