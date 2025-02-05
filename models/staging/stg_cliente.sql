with 
    stg_clientes as (
        select
          cod_cliente as cliente_id
          , concat(primeiro_nome, ' ', ultimo_nome) as nome_completo
          , email
          , case 
              when tipo_cliente = 'PF' then 'Pessoa Física' end as tipo_cliente
          , cast(data_inclusao as date) as data_inclusao
          , cpfcnpj as cpf
          , data_nascimento
          , endereco
          , cep  
           
        from {{ source ('LH_AE_GILBERTO', 'clientes') }} 
    )
select *
from stg_clientes