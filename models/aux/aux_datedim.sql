{{ config(materialized='view') }}

with source as (
  select * from {{ ref('staging_datedim') }}
)
select
  *
from source
