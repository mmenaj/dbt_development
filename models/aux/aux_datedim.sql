{{ config(materialized='table') }}


with source as (
  select * from {{ ref('staging_datedim') }}
),

aux_datedim as (
  select
    *,
	sysdate() as sdate,
	'staging_datedim' as staging_origin	
  from source
)
select
  *
from aux_datedim
