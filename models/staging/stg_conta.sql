with 
    stg_contas as (
        select
            num_conta as conta_id
            , cod_cliente as cliente_id
            , cod_agencia as agencia_id
            , cod_colaborador as colaborador_id
            , case 
                when tipo_conta = 'PF' then 'Pessoa Física' end as tipo_contas
            , date(data_abertura) as data_abertura
            , saldo_total
            , saldo_disponivel
            , cast(data_ultimo_lancamento as date) as data_ultimo_lancamento
            
        from {{ source ('LH_AE_GILBERTO', 'contas') }} 
    )
select *
from stg_contas