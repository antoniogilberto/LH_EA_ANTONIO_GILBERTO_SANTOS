with 
    proposta_credito as (
        select *
        from {{ ref('stg_proposta_credito') }}
    )

    , fct_proposta_credito as (
        select
            proposta_id
            , colaborador_id
            , cliente_id
            , data_entrada_proposta
            , taxa_juros_mensal
            , valor_proposta
            , valor_financiamento
            , valor_entrada
            , valor_prestacao
            , quantidade_parcelas
            , carencia
            , status_proposta
        from proposta_credito
    )

select *
from fct_proposta_credito

