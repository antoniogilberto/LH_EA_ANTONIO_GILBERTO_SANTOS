with
    stg_agencias as (
        select 
          cod_agencia as agencia_id
          , nome
          , endereco
          , cidade
          , uf
          , cast(data_abertura as date) as data_abertura
          , tipo_agencia 
          
        from {{ source ('LH_AE_GILBERTO', 'agencias') }} 
    )
select *
from stg_agencias