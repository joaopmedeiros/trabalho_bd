-- CONSULTA 1
    select m.NOME_MUNIC�PIO, m.NOME_UF, to_char(a.data_acidente,'MM-YYYY') as mes_ano, ROUND(count(1)/(p.popula��o/100000),2) as acidentes_por_100mil
        from DUNCANBDA.ACID_TRAB_2018JUL_2019MAR_11 a 
        inner join DUNCANBDA.MUNICIPIOS m on a.MUNIC_EMPREGADOR = m.COD_MUNIC
        inner join DUNCANBDA.MUNICIPIOS_POPULACOES p on m.COD_MUNIC = p.cod_munic
        group by m.NOME_MUNIC�PIO, m.NOME_UF, p.popula��o, to_char(a.data_acidente,'MM-YYYY')
        order by count(1)/(p.popula��o/100000) desc
-- CONSULTA 2        
    select a.AGENTE_CAUSADOR_ACIDENTE, to_char(a.data_acidente,'MM-YYYY') as mes_ano,  count(1) as acidentes
        from DUNCANBDA.ACID_TRAB_2018JUL_2019MAR_11 a 
        WHERE a.INDICA_OBITO_ACIDENTE = 'Sim'
        group by a.AGENTE_CAUSADOR_ACIDENTE, to_char(a.data_acidente,'MM-YYYY')
        having count(1) > 2
     