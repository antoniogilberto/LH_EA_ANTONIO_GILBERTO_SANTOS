with 
    clientes as (
        select *
        from {{ref('stg_cliente')}}

    )
    , dim_clientes as (
        select 
            cliente_id
            , nome_completo
            , email
            , tipo_cliente
            , date(data_inclusao) as data_inclusao 
            , cpf
            , idade
            , endereco
            , cep
        from clientes
    )
select *
from dim_clientes