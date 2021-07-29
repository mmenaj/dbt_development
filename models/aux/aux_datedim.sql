{{ config(materialized='table') }}


with aux_datedim as (
  select * from {{ ref('staging_datedim') }}
) 

select
  *
from aux_datedim
