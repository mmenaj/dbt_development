with 
expl_tablahechos as (
  select * from "PROD"."MODELADO"."EXPL_TABLAHECHOS"
),

source as (
  select * from {{ ref('expl_tablahechos') }}
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
