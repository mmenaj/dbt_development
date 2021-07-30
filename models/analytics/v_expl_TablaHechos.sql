with source as (
  select * from {{ var('explo_tablahechos') }}
),

v_expl_TablaHechos as (
  select
    *,
	sysdate() as snapshot
  from source
)
select
  *
from v_expl_TablaHechos
