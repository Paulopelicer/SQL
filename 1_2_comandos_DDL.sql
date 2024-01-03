/**** Melhorias no modelo de dados relacional – Instruções DDL ****/

/*A O nome do cliente dentro da tabela T_MC_CLIENTE está como único. Favor excluir essa restrição. Qual é a instrução SQL ideal para executar essa ação? */
ALTER TABLE T_MC_CLIENTE DROP CONSTRAINT UK_MC_CLIENTE_NOME_CLIENTE;

/*B As colunas QT_ESTRELAS, ST_CLIENTE e DS_EMAIL da tabela T_MC_CLIENTE devem ser obrigatórias. Favor realizar esse ajuste. Quais as instruções SQL ideais para executar essa ação?*/
ALTER TABLE T_MC_CLIENTE MODIFY (QT_ESTRELAS NUMBER(1) NOT NULL, ST_CLIENTE CHAR(1) NOT NULL, DS_EMAIL VARCHAR2(100) NOT NULL);

/*C A coluna NM_LOGIN da tabela T_MC_CLIENTE deve receber conteúdo único. Favor realizar esse ajuste. Qual é a instrução SQL ideal para executar essa ação?*/
ALTER TABLE T_MC_CLIENTE ADD CONSTRAINT UK_MC_CLIENTE_NOME_LOGIN UNIQUE (NM_LOGIN);

/*D As colunas DT_FUNDACAO e NR_CNPJ da tabela T_MC_CLI_JURIDICA devem ter conteúdo como sendo obrigatório. Quais as instruções SQL ideais para executar essa ação?*/
ALTER TABLE T_MC_CLI_JURIDICA MODIFY (DT_FUNDACAO DATE NOT NULL, NR_CNPJ VARCHAR2(20) NOT NULL);

/*E As colunas NR_MINUTO_VIDEO e NR_SEGUNDO_VIDEO na parte de controle da visualização do vídeo devem ter conteúdos obrigatórios. Identifique o nome da tabela e realize esses ajustes.*/
ALTER TABLE T_MC_SGV_VISUALIZACAO_VIDEO MODIFY (NR_MINUTO_VIDEO NUMBER(2) NOT NULL, NR_SEGUNDO_VIDEO NUMBER(2) NOT NULL);

/*F As colunas ST_PRODUTO, ST_VIDEO_PROD, ST_END, ST_FUNC e ST_CATEGORIA somente pode receber dois valores possíveis: 
A ou I, sendo (A)tivo ou (I)nativo. Identifique em quais tabelas se localizam essas colunas e realize os ajustes.*/
ALTER TABLE T_MC_PRODUTO ADD CONSTRAINT CK_T_MC_PRODUTO_ST_PRODUTO CHECK (ST_PRODUTO IN ('A', 'I'));
ALTER TABLE T_MC_SGV_PRODUTO_VIDEO ADD CONSTRAINT CK_T_MC_SGV_ST_VIDEO_PROD CHECK (ST_VIDEO_PROD IN ('A', 'I'));
ALTER TABLE T_MC_END_FUNC ADD CONSTRAINT CK_T_MC_END_FUNC_ST_END CHECK (ST_END IN ('A', 'I'));
ALTER TABLE T_MC_FUNCIONARIO ADD CONSTRAINT CK_T_MC_FUNCIONARIO_ST_FUNC CHECK (ST_FUNC IN ('A', 'I'));
ALTER TABLE T_MC_CATEGORIA_PROD ADD CONSTRAINT CK_T_MC_CATEGORIA_PROD_ST_CATEGORIA CHECK (ST_CATEGORIA IN ('A', 'I'));