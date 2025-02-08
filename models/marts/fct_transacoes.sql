with
    transacoes as (
        select *
        from {{ ref('stg_transacoes') }}
    )

    , contas as (
        select *
        from {{ ref('stg_conta') }}
    )

    , clientes as (
        select *
        from {{ ref('stg_cliente') }}
    )

    , dim_data as (
        select data_completa
        from {{ ref('dim_data') }}
    )

    , fct_transacoes as (
        select
            transacoes.transacao_id
            , transacoes.conta_id as transacao_conta_id
            , contas.conta_id as conta_conta_id
            , clientes.cliente_id
            , transacoes.nome_transacao
            , transacoes.valor_transacao
            , contas.tipo_contas
            , contas.saldo_total
            , contas.data_abertura
            , dim_data.data_completa
        from transacoes
        left join contas on transacoes.conta_id = contas.conta_id
        left join dim_data on transacoes.data_transacao = dim_data.data_completa
        left join clientes on contas.cliente_id = clientes.cliente_id
    )

select *
from fct_transacoes
