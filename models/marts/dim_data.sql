WITH min_max_datas AS (
    -- Pegamos o menor e maior valor de data das tabelas fato, garantindo que sejam DATE
    SELECT 
        DATE(MIN(DATE(data_transacao))) AS data_minima,
        DATE(MAX(DATE(data_transacao))) AS data_maxima
    FROM {{ ref('stg_transacoes') }}

    UNION ALL

    SELECT 
        DATE(MIN(DATE(data_entrada_proposta))) AS data_minima,
        DATE(MAX(DATE(data_entrada_proposta))) AS data_maxima
    FROM {{ ref('stg_proposta_credito') }}
),

intervalo_datas AS (
    -- Pegamos a data mínima e máxima
    SELECT 
        DATE_TRUNC(MIN(data_minima), DAY) AS data_inicio,
        DATE_TRUNC(MAX(data_maxima), DAY) AS data_fim
    FROM min_max_datas
),

date_series AS (
    -- Geramos uma série de datas sem recursão
    SELECT 
        day AS data_completa
    FROM UNNEST(GENERATE_DATE_ARRAY(
        (SELECT data_inicio FROM intervalo_datas), 
        (SELECT data_fim FROM intervalo_datas),
        INTERVAL 1 DAY
    )) AS day
)

SELECT 
    data_completa,
    EXTRACT(YEAR FROM data_completa) AS ano,
    EXTRACT(MONTH FROM data_completa) AS mes,
    EXTRACT(DAY FROM data_completa) AS dia,
    EXTRACT(WEEK FROM data_completa) AS semana_do_ano,
    EXTRACT(QUARTER FROM data_completa) AS trimestre,
    FORMAT_DATE('%B', data_completa) AS nome_mes,
    FORMAT_DATE('%A', data_completa) AS nome_dia
FROM date_series
