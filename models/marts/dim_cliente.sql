with 
    clientes as (
        select *
        from {{ref('stg_cliente')}}

    )
    , contas as (
        select *
        from {{ ref('stg_conta') }}

    )
    , dim_clientes as (
        select 
            clientes.cliente_id
            , contas.conta_id
            , clientes.nome_completo
            , clientes.email
            , clientes.tipo_cliente
            , date(clientes.data_inclusao) as data_inclusao 
            , clientes.cpf
            , clientes.faixa_etaria
            , clientes.endereco
            , clientes.cep
        from clientes
        left join contas on clientes.cliente_id = contas.cliente_id
    )
select *
from dim_clientes