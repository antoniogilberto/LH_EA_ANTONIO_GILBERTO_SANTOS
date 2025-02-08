with 
    stg_clientes as (
        select
          cod_cliente as cliente_id
          , concat(primeiro_nome, ' ', ultimo_nome) as nome_completo
          , email
          , case 
              when tipo_cliente = 'PF' then 'Pessoa Física' end as tipo_cliente
          , date(data_inclusao) as data_inclusao
          , cpfcnpj as cpf
          , DATE_DIFF(CURRENT_DATE(), DATE(data_nascimento), YEAR) AS idade,  -- 🔥 Adicionado cálculo da idade
            CASE 
                WHEN DATE_DIFF(CURRENT_DATE(), DATE(data_nascimento), YEAR) < 18 THEN 'Menor de 18 anos'
                WHEN DATE_DIFF(CURRENT_DATE(), DATE(data_nascimento), YEAR) BETWEEN 18 AND 25 THEN '18-25 anos'
                WHEN DATE_DIFF(CURRENT_DATE(), DATE(data_nascimento), YEAR) BETWEEN 26 AND 35 THEN '26-35 anos'
                WHEN DATE_DIFF(CURRENT_DATE(), DATE(data_nascimento), YEAR) BETWEEN 36 AND 50 THEN '36-50 anos'
                ELSE 'Acima de 50 anos'
            END AS faixa_etaria
          , endereco
          , cep  
           
        from {{ source ('LH_AE_GILBERTO', 'clientes') }} 
    )
select *
from stg_clientes