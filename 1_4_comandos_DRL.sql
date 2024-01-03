/**** Desafio: Exibir dados utilizando comandos Select ****/

/* A Crie uma consulta por meio do comando SELECT que exiba informações das categorias de produto e respectivos produtos de cada categoria. 
Exiba as seguintes informações: código e nome da categoria, código e descrição do produto, valor unitário, tipo de embalagem e percentual do lucro de cada produto. 
Caso exista alguma categoria sem produto, favor exibir a categoria e deixar os dados do produto em branco. Classifique a consulta em ordem de categoria e nome de produto de forma ascendente.*/

SELECT  CD_CATEGORIA,
        A.DS_CATEGORIA,
        B.CD_PRODUTO,
        B.DS_PRODUTO,
        B.VL_UNITARIO,
        B.TP_EMBALAGEM,
        B.VL_PERC_LUCRO
        
FROM T_MC_CATEGORIA_PROD A LEFT OUTER JOIN
     T_MC_PRODUTO B
     USING(CD_CATEGORIA)

ORDER BY CD_CATEGORIA,
         B.DS_PRODUTO;
         
/* B Crie uma consulta por meio do comando SELECT que exiba a quantidade de clientes agrupados por Estado, cidade e bairro. 
Classifique a consulta por nome do Estado, nome da cidade e nome do bairro. Caso não existam clientes cadastrados para algum bairro, exiba o valor zero para o bairro.*/

SELECT  E.NM_ESTADO,
        D.NM_CIDADE,
        C.NM_BAIRRO,
        COUNT(DISTINCT A.NR_CLIENTE) AS QTDE_CLIENTE
        
FROM T_MC_END_CLI A LEFT OUTER JOIN
     T_MC_LOGRADOURO B
     ON(A.CD_LOGRADOURO_CLI = B.CD_LOGRADOURO)
     
     LEFT OUTER JOIN T_MC_BAIRRO C
     ON(B.CD_BAIRRO = C.CD_BAIRRO)
     
     LEFT OUTER JOIN T_MC_CIDADE D
     ON(C.CD_CIDADE = D.CD_CIDADE)
     
     LEFT OUTER JOIN T_MC_ESTADO E
     ON(D.SG_ESTADO = E.SG_ESTADO)
     
GROUP BY E.NM_ESTADO,
         D.NM_CIDADE,
         C.NM_BAIRRO
         
ORDER BY E.NM_ESTADO,
         D.NM_CIDADE,
         C.NM_BAIRRO;

/* C  - Crie uma instrução SQL que exiba o TOP 10 vídeos de produtos assistidos pelo cliente. Exiba o código do produto, nome do produto, ano e mês de visualização e a quantidade total de visualizações que o produto teve durante o ano e mês.*/

select
    cd_produto,
    prod.ds_produto,
    visualizacoes.qtde_visualizacoes
from (
    select 
        cd_produto,
        count(cd_visualizacao_video) as qtde_visualizacoes
    from T_MC_SGV_VISUALIZACAO_VIDEO
    group by cd_produto
) visualizacoes
join T_MC_PRODUTO prod
using ( cd_produto)
order by visualizacoes.qtde_visualizacoes desc
-- fetch first so funciona a partir da versao 12 do oracle
-- mantera apenas as 10 primeiras linhas
fetch first 10 rows only;

/*   D - Crie uma instrução SQL que exiba os dados dos clientes pessoa física. Exiba as seguintes informações: código e nome do cliente, e-mail, telefone, login, data de nascimento, sexo biológico e CPF. */
select
    nr_cliente,
    det.nm_cliente,
    det.ds_email,
    det.nr_telefone,
    det.nm_login,
    pf.dt_nascimento,
    pf.fl_sexo_biologico,
    pf.nr_cpf
from T_MC_CLI_FISICA pf
join T_MC_CLIENTE det
using ( nr_cliente );

/*   E - Crie uma instrução SQL que exiba os dados dos clientes pessoa jurídica. Exiba as seguintes informações: código e nome do cliente, e-mail, telefone, login, data de fundação e CNPJ. */
select
    nr_cliente,
    det.nm_cliente,
    det.ds_email,
    det.nr_telefone,
    det.nm_login,
    pj.dt_fundacao,
    pj.nr_cnpj
from T_MC_CLI_JURIDICA pj
join T_MC_CLIENTE det
using ( nr_cliente );

/*   F - Exiba qual é o dia da semana em que os vídeos são mais acessados. Exiba o dia da semana por extenso e a quantidade de vídeos acessados.
     Classifique a saída de dados por quantidade de vídeos mais acessados, ou seja, por ordem descendente. */

select
     dia_semana,
     count(cd_visualizacao_video) as qtde_visualizacoes
from (
     select
     -- tras o nome do dia da semana por extenso a partir da data passada no parametro.
     -- Exemplo: to_char(to_date('24/04/2022'), 'DAY') retornara 'DOMINGO'
          to_char(dt_visualizacao, 'DAY') as dia_semana,
          cd_visualizacao_video
     from T_MC_SGV_VISUALIZACAO_VIDEO
) aux_visualizacoes_semana
group by dia_semana
order by qtde_visualizacoes desc;

/*
     G - Exiba por ano e por mês a quantidade de chamados abertos no SAC até o momento. Exiba o ano e mês da abertura do SAC e a quantidade de ocorrências abertas pelo cliente por ano e mês.
     Classifique a consulta em ordem de ano e mês.
*/

select
     ano_mes_abert_sac,
     count(nr_sac) as qtde_chamados
from (
     select
     -- concatena: ano e mes para um valor inteiro. Usando a data '24/04/2022' como exemplo,
     --   o calculo abaixo fica: 2022 * 100 + 4 -> 202200 + 4 = -> 202204 <-

     -- extract(year from data) -> retorna o valor do ano a partir da data do parametro.
     -- extract(month from data) -> retorna o valor do mes a partir da data do parametro.
          extract( year from dt_abertura_sac)*100 + extract(month from dt_abertura_sac) as ano_mes_abert_sac,
          nr_sac
     from T_MC_SGV_SAC
) aux_chamados
group by ano_mes_abert_sac
order by ano_mes_abert_sac desc;

/*
     H - Exiba o chamado no SAC que teve o maior tempo de atendimento total em número de horas (*utilize a técnica de subquery).
          Fica a seu critério informar as colunas que julgar necessárias. Não utilize *, selecione algumas colunas relevantes.
*/
select
    sac.nr_sac,
    sac.nr_cliente,
    cd_produto,
    prod.ds_produto,
    sac.tp_sac,
    sac.st_sac,
    sac.dt_abertura_sac,
    sac.dt_atendimento,
    case
     -- se a coluna 'dt_atendimento' estiver preenchida, trara a quantidade de dias que demorou para ocorrer
     -- o atendimento
        when sac.dt_atendimento is not null then  abs(cast(sac.dt_abertura_sac - dt_atendimento as int))
     -- caso a coluna 'dt_atendimento' estiver vazia (sera um erro pois no sub select, pegamos apenas os
     -- chamados que ja foram encerrados), trata a quantidade de dias que o chamado esta aberto sem atendimento

     -- SYSDATE: tras a data e hora atual do sistema
     -- cast( 'valor' as int) -> transforma 'valor' para o tipo int. Pode ser usado para transformar para
     --   outros tipos como: bigint, string, date, double, float, etc.
     -- abs(): tras o valor absoluto de um numero. Exemplo: abs(-2) retornara 2
        else abs(cast(sac.dt_abertura_sac - SYSDATE as int))
    end as dias_atendimento,
    sac.nr_tempo_total_sac,
    sac.ds_detalhada_sac,
    sac.ds_detalhada_retorno_sac
from (
    select 
        nr_sac, nr_cliente, cd_produto, cd_funcionario,
        tp_sac, st_sac, nr_indice_satisfacao, dt_abertura_sac, nr_tempo_total_sac,
        ds_detalhada_sac, ds_detalhada_retorno_sac, dt_atendimento
    from T_MC_SGV_SAC
     -- nao trara os chamados que estao em andamento caso seja retornado mais de um resultado
     -- com a mesmo valor de horas totais de atendimento (improvavel mas possivel)
    where st_sac != 'E' and nr_tempo_total_sac in (select max(nr_tempo_total_sac) from T_MC_SGV_SAC)
) sac
join T_MC_PRODUTO prod
using( cd_produto )
-- fetch first so funciona a partir da versao 12 do oracle
-- mantera apenas a primeira linha. Eh improvavel ter o retorno de mais de um registro
-- mas, caso ocorra, a funcao abaixo garantira o retorno de apenas um registro
fetch first 1 rows only;

/*
     I - Exiba a quantidade média do índice de satisfação informada pelo cliente para cada funcionário.
     Exiba o código e nome do funcionário, o nome do departamento onde ele trabalha, seu cargo e também
     exiba o valor do índice médio geral de satisfação aplicado em cada chamado pelo cliente.
     Os funcionários que não têm status A(tivo) não devem ser exibidos.
*/

select
     atendimento.cd_funcionario,
     func.nm_funcionario,
     dept.nm_depto,
     func.ds_cargo,
     atendimento.media_ind_satisfacao,
     atendimento.qtde_atendimentos
from (
     select
          cd_funcionario,
          avg(nr_indice_satisfacao) as media_ind_satisfacao,
          count(nr_sac) as qtde_atendimentos
     from T_MC_SGV_SAC
     -- tras apenas os chamados ja encerrados 
     where st_sac != 'E'
     group by cd_funcionario
) atendimento
inner join T_MC_FUNCIONARIO func
on atendimento.cd_funcionario = func.cd_funcionario

inner join T_MC_DEPTO dept
on func.cd_depto = dept.cd_depto
-- mantem apenas os funcionarios ativos
where func.ST_FUNC = 'A';

/*
     J - Exiba a quantidade total de vídeos agrupados por produto. Exiba o código e nome do produto, o valor unitário e o status do produto.
     Exiba somente os produtos que estejam com status A(tivo) e, caso o produto esteja sem vídeo, exiba o valor zero para o agrupamento
*/

select
     cd_produto,
     prod.ds_produto,
     prod.vl_unitario,
     prod.st_produto,
     -- caso nao exista um video cadastrado para um produto, o resultado de 'qtde_videos' sera vazio.
     -- a funcao coalesce serve justamente para evitar que o resultado seja vazio e retorne o valor
     -- estipulado. Nesse caso, retornara 0 para os produtos que nao possuirem um video cadastrado
     -- ao inves de retorna NULL
     coalesce(vid.qtde_videos, 0) as qtde_videos
from T_MC_PRODUTO prod
left join (
    select 
        cd_produto,
        count(nr_sequencia) as qtde_videos
    from T_MC_SGV_PRODUTO_VIDEO
    group by cd_produto
) vid
using ( cd_produto )
-- mantem apenas os produtos ativos
where prod.st_produto =  'A';