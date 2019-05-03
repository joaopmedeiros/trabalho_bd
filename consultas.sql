 -- CONSULTA 1 
SELECT m.nome_munic�pio, 
       m.nome_uf, 
       To_char(a.data_acidente, 'MM-YYYY')             AS mes_ano, 
       Round(Count(1) / ( p.popula��o / 100000 ), 2) AS acidentes_por_100mil 
FROM   duncanbda.acid_trab_2018jul_2019mar_11 a 
       INNER JOIN duncanbda.municipios m 
               ON a.munic_empregador = m.cod_munic 
       INNER JOIN duncanbda.municipios_populacoes p 
               ON m.cod_munic = p.cod_munic 
GROUP  BY m.nome_munic�pio, 
          m.nome_uf, 
          p.popula��o, 
          To_char(a.data_acidente, 'MM-YYYY') 
ORDER  BY Count(1) / ( p.popula��o / 100000 ) DESC 

-- CONSULTA 2         
SELECT a.agente_causador_acidente, 
       To_char(a.data_acidente, 'MM-YYYY') AS mes_ano, 
       Count(1)                            AS acidentes 
FROM   duncanbda.acid_trab_2018jul_2019mar_11 a 
WHERE  a.indica_obito_acidente = 'Sim' 
GROUP  BY a.agente_causador_acidente, 
          To_char(a.data_acidente, 'MM-YYYY') 
HAVING Count(1) > 2 

-- CONSULTA 3      
SELECT o.desc_ocupacao, 
       To_char(a.data_acidente, 'MM-YYYY') AS mes_ano, 
       Count(1)                            AS acidentes 
FROM   duncanbda.acid_trab_2018jul_2019mar_11 a 
       INNER JOIN duncanbda.cbo2002_ocupacao o 
               ON a.cbo = o.ocupacao 
GROUP  BY o.desc_ocupacao, 
          To_char(a.data_acidente, 'MM-YYYY') 
ORDER  BY Count(1) DESC 

-- CONSULTA 4 
SELECT g.denominacao, 
       To_char(a.data_acidente, 'MM-YYYY') AS mes_ano, 
       Count(1)                            AS acidentes 
FROM   duncanbda.acid_trab_2018jul_2019mar_11 a 
       LEFT JOIN duncanbda.cnae20_classes c 
              ON a.cnae20_empregador = c.classe_num 
       LEFT JOIN duncanbda.cnae20_grupos g 
              ON c.grupo = g.grupo 
GROUP  BY g.denominacao, 
          To_char(a.data_acidente, 'MM-YYYY') 
HAVING Count(1) > 1 
ORDER  BY Count(1) DESC 

-- CONSULTA 5  
SELECT a.natureza_da_lesao, 
       Count(1) AS acidentes 
FROM   duncanbda.acid_trab_2018jul_2019mar_11 a 
GROUP  BY a.natureza_da_lesao 
HAVING Count(1) > 100 
ORDER  BY Count(1) DESC 
     
     
     
 