with 
    stg_colaboradores as (
        select
            cod_colaborador as colaborador_id
            , concat(primeiro_nome, ' ', ultimo_nome) as nome_completo
            , email
            , cpf
            , date_diff(CURRENT_DATE(), data_nascimento, YEAR) as idade
            , endereco
            , cep
            
        from {{ source ('LH_AE_GILBERTO', 'colaboradores') }} 
    )
select *
from stg_colaboradores