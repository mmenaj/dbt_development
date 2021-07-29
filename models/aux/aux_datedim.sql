{{ config(materialized='table') }}

with source as (
  select * from {{ ref('staging_datedim') }}
)
select
  *
from source
