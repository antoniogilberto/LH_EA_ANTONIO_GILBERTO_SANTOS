with 
    agencias as (
        select *
        from{{ ref('stg_agencia') }}
    )
    , colaboradores_agencias as (
        select *
        from {{ ref('stg_colaborador_agencia') }}
    )
    , colaboradores as (
        select *
        from {{ ref('stg_colaborador') }}
    )
    , dim_colaboradores_agencias as (
        select 
            agencias.agencia_id
            , colaboradores.colaborador_id
            , agencias.nome as nome_agencia
            , agencias.cidade
            , agencias.uf
            , agencias.tipo_agencia
            , colaboradores.nome_completo as nome_colaborador
            , colaboradores.idade as idade_colaborador
        from colaboradores_agencias
        left join agencias on colaboradores_agencias.agencia_id = agencias.agencia_id
        left join colaboradores on colaboradores_agencias.colaborador_id = colaboradores.colaborador_id
    )
select *
from dim_colaboradores_agencias