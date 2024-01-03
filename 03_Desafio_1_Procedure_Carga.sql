SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE SP_CARGA_T_MC_SGV_OCORRENCIA_SAC AS 

/*** DECLARAÇÃO DO CURSO CONSIDERANDO O SEGUINTE PEDIDO DO EXERCÍCIO:
- Número da ocorrência do SAC (coluna nr_sac na tabela t_mc_sgv_sac)
- Data de abertura do SAC (coluna dt_abertura_sac na tabela t_mc_sgv_sac)
- Hora de abertura do SAC (coluna hr_abertura_sac na tabela t_mc_sgv_sac)
- Tipo do SAC (esse conteúdo irá ser transformado posteriormente. Coluna tp_sac na tabela t_mc_sgv_sac)
- Número do índice de satisfação SAC (Coluna nr_indice_satisfacao na tabela t_mc_sgv_sac)
- Código da categoria do produto (coluna cd_categoria na tabela t_mc_categoria_prod)
- Tipo da categoria do produto (coluna tp_categoria na tabela t_mc_categoria_prod)
- Descrição da categoria do produto (coluna ds_categoria na tabela t_mc_categoria_prod)
- Código do produto (coluna cd_produto na tabela t_mc_produto)
- Nome do produto (coluna cd_produto na tabela t_mc_produto)
- Embalagem do produto (coluna tp_embalagem na tabela t_mc_produto)
- Valor unitario de venda do produto (coluna vl_unitario na tabela t_mc_produto)
- Percentual do lucro unitário do produto (coluna vl_perc_lucro na tabela t_mc_produto)
- Sigla do Estado (coluna sg_estado na tabela t_mc_estado)
- Nome do Estado (coluna nm_estado na tabela t_mc_estado)
- Nome da Cidade (coluna nm_cidade na tabela t_mc_cidade)
- Nome do Bairro (coluna nm_bairro na tabela t_mc_bairro)
- Número do Cliente (coluna nr_cliente na tabela t_mc_cliente)
- Nome do Cliente (coluna nm_cliente na tabela t_mc_cliente)
- Quantidade de estrelas do cliente (coluna qt_estrelas na tabela t_mc_cliente) ***/
    CURSOR cursor_ocorr_sac IS

        SELECT  SAC.NR_SAC,
                SAC.DT_ABERTURA_SAC,
                SAC.HR_ABERTURA_SAC,
                SAC.TP_SAC,
                SAC.NR_INDICE_SATISFACAO,
                CATPROD.CD_CATEGORIA,
                CATPROD.TP_CATEGORIA,
                CATPROD.DS_CATEGORIA,
                PROD.CD_PRODUTO,
                PROD.DS_PRODUTO,
                PROD.TP_EMBALAGEM,
                PROD.VL_UNITARIO,
                PROD.VL_PERC_LUCRO,
                ENDE_ESTADO.SG_ESTADO,
                ENDE_ESTADO.NM_ESTADO,
                ENDE_CIDADE.NM_CIDADE,
                ENDE_BAIRRO.NM_BAIRRO,
                CLIE.NR_CLIENTE,
                CLIE.NM_CLIENTE,
                CLIE.QT_ESTRELAS    
                
        FROM T_MC_SGV_SAC SAC LEFT JOIN
             T_MC_PRODUTO PROD
             ON(SAC.CD_PRODUTO = PROD.CD_PRODUTO)
             
             LEFT JOIN T_MC_CATEGORIA_PROD CATPROD
             ON(PROD.CD_CATEGORIA = CATPROD.CD_CATEGORIA)
             
             LEFT JOIN T_MC_CLIENTE CLIE
             ON(SAC.NR_CLIENTE = CLIE.NR_CLIENTE)
             
             LEFT JOIN (SELECT * FROM T_MC_END_CLI WHERE ST_END = 'A') END_CLI
             ON(SAC.NR_CLIENTE = END_CLI.NR_CLIENTE)
             
             LEFT JOIN T_MC_LOGRADOURO END_LOG
             ON(END_CLI.CD_LOGRADOURO_CLI = END_LOG.CD_LOGRADOURO)
             
             LEFT JOIN T_MC_BAIRRO ENDE_BAIRRO
             ON(ENDE_BAIRRO.CD_BAIRRO = END_LOG.CD_BAIRRO)
             
             LEFT JOIN T_MC_CIDADE ENDE_CIDADE
             ON(ENDE_CIDADE.CD_CIDADE = ENDE_BAIRRO.CD_CIDADE)
             
             LEFT JOIN T_MC_ESTADO ENDE_ESTADO
             ON(ENDE_ESTADO.SG_ESTADO = ENDE_CIDADE.SG_ESTADO)
        
        ORDER BY SAC.NR_SAC;

/*** DECLARANDO DEMAIS VARIVEIS DO PROCESSO, UTILIZADAS PARA TRATAR AS INFORMAÇÕES ANTES DE INSERIR NA TABELA FINAL ***/      
    v_ds_class_sac VARCHAR2(30);
    v_ds_indc_satis VARCHAR2(30);
    v_tp_categ_prod VARCHAR2(30);
    v_vl_lucro_prod NUMBER;
    v_vl_icms_prod NUMBER;

BEGIN
/*** GERANDO VARIAVEL reg_ocorr_sac USANDO FOR, PARA EVITAR DE USAR OS COMANDO OPEN, FETCH E CLOSE DO CURSOR ***/
  FOR reg_ocorr_sac IN cursor_ocorr_sac LOOP 
   
/*** TRATATIVA PARA CARREGAR OS DADOS DA COLUNA DS_TIPO_CLASSIFICACAO_SAC, CONFORME SOLICITACAO:
A coluna DS_TIPO_CLASSIFICACAO_SAC deve ser preenchida transformando o status TP_SAC que se encontra no cursor principal. Siga as seguintes regras:
    - Caso o conteúdo seja S o texto correto deve ser SUGESTÃO. 
    - Caso seja D o texto correto deve ser DÚVIDA. 
    - Caso seja E o texto correto deve ser ELOGIO. 
    - Caso não seja nenhuma dessa classificação retorne o texto CLASSIFICAÇÃO INVÁLIDA. ***/
    IF reg_ocorr_sac.TP_SAC = 'S' THEN 
        v_ds_class_sac := 'SUGESTAO';
        
    ELSIF reg_ocorr_sac.TP_SAC = 'D' THEN 
        v_ds_class_sac := 'DUVIDA'; 
        
    ELSIF reg_ocorr_sac.TP_SAC = 'E' THEN 
        v_ds_class_sac := 'ELOGIO';
        
    ELSE 
        v_ds_class_sac := 'CLASSIFICACAO INVALIDA';
    END IF;

/*** TRATATIVA PARA CARREGAR OS DADOS DA COLUNA DS_INDICE_SATISFACAO_ATD_SAC, CONFORME SOLICITACAO:

A coluna DS_INDICE_SATISFACAO_ATD_SAC deve ser preenchida após ser acionada uma procedure que se encontra no SGBDR Oracle da FIAP (banco ORCL). 
Para sua necessidade, o primeiro parâmetro deve ser o número de satisfação do atendimento SAC, informado pelo cliente e que se encontra em seu cursor principal. 
A partir desse parâmetro, será retornado o texto contendo a qual índice pertence esse atendimento. Veja um exemplo do acesso feito a essa procedure:

declare
v_nr_indice_satisfacao number(2) := 9;
v_ds_indice_satisfacao varchar2(30) := '';

begin
  pf0110.prc_mc_gera_indice_satisfacao_atd(v_nr_indice_satisfacao, v_ds_indice_satisfacao);
  dbms_output.put_line ( 'O índice é: ' || v_ds_indice_satisfacao);
end; ***/
    pf0110.prc_mc_gera_indice_satisfacao_atd(reg_ocorr_sac.NR_INDICE_SATISFACAO, v_ds_indc_satis);
    
/*** TRATATIVA PARA CARREGAR OS DADOS DA COLUNA NM_TIPO_CATEGORIA_PROD, CONFORME SOLICITACAO:
A coluna NM_TIPO_CATEGORIA_PROD deve ser preenchida transformando o status TP_CATEGORIA que se encontra no cursor principal. Siga as seguintes regras: 
    - Caso o conteúdo seja V o texto correto deve ser VÍDEO. 
    - Caso seja P o texto correto deve ser PRODUTO. 
    - Caso não seja nenhum desses valores retorne o texto CATEGORIA INVÁLIDA. ***/
    IF reg_ocorr_sac.TP_CATEGORIA = 'V' THEN 
        v_tp_categ_prod := 'VIDEO';
        
    ELSIF reg_ocorr_sac.TP_CATEGORIA = 'P' THEN 
        v_tp_categ_prod := 'PRODUTO'; 
        
    ELSE 
        v_tp_categ_prod := 'CATEGORIA INVALIDA';
    END IF;

/*** TRATATIVA PARA CARREGAR OS DADOS DA COLUNA VL_UNITARIO_LUCRO_PRODUTO, CONFORME SOLICITACAO:
A coluna VL_UNITARIO_LUCRO_PRODUTO armazenará o valor do lucro unitário sobre o produto ofertado. 
Seu conteúdo deve ser calculado sobre a seguinte fórmula: 
    - VL_PERC_LUCRO / 100 * VL_UNITARIO_PRODUTO
Esses valores se encontram no seu cursor principal. ***/
    v_vl_lucro_prod := reg_ocorr_sac.VL_PERC_LUCRO / 100 * reg_ocorr_sac.VL_UNITARIO;
    
/*** TRATATIVA PARA CARREGAR OS DADOS DA COLUNA VL_ICMS_PRODUTO, CONFORME SOLICITACAO: 
A coluna VL_ICMS_PRODUTO armazenará o valor médio do ICMS da unidade do produto a ser pago de acordo ao Estado onde o cliente está localizado. 
Essa informação será utilizada pela área fiscal das melhores compras nos casos de devolução ou ressarcimento do produto. 
Para calcular esse valor siga os seguintes passos: 
    1) Acione a função pf0110.fun_mc_gera_aliquota_media_icms_estado(p_sg_estado in varchar) que se encontra no SGBDR Oracle da FIAP (banco ORCL). 
    Essa função irá retornará o % médio da alíquota do ICMS do Estado do cliente (que se encontra em seu cursor principal). 
    2) A partir desse percentual, é só aplicar a fórmula: VL_PERC_ICMS_ESTADO/ 100 * VL_UNITARIO_PRODUTO
Esse resultado deve ser associado a coluna vl_icms_produto. ***/    
    v_vl_icms_prod := pf0110.fun_mc_gera_aliquota_media_icms_estado(reg_ocorr_sac.SG_ESTADO) / 100 * reg_ocorr_sac.VL_UNITARIO;

/*** INSERINDO OS REGISTROS NA TABELA T_MC_SGV_OCORRENCIA_SAC ***/

    INSERT INTO T_MC_SGV_OCORRENCIA_SAC
    VALUES (SQ_MC_SGV_OCORRENCIA_SAC.NEXTVAL, 
            reg_ocorr_sac.DT_ABERTURA_SAC,
            reg_ocorr_sac.HR_ABERTURA_SAC,
            v_ds_class_sac,
            v_ds_indc_satis,
            reg_ocorr_sac.CD_CATEGORIA,
            reg_ocorr_sac.TP_CATEGORIA,
            reg_ocorr_sac.DS_CATEGORIA,
            reg_ocorr_sac.CD_PRODUTO,
            reg_ocorr_sac.DS_PRODUTO,
            reg_ocorr_sac.TP_EMBALAGEM,
            reg_ocorr_sac.VL_UNITARIO,
            reg_ocorr_sac.VL_PERC_LUCRO,
            v_vl_lucro_prod,
            reg_ocorr_sac.SG_ESTADO,
            reg_ocorr_sac.NM_ESTADO,
            reg_ocorr_sac.NM_CIDADE,
            reg_ocorr_sac.NM_BAIRRO,
            reg_ocorr_sac.NR_CLIENTE,
            reg_ocorr_sac.NM_CLIENTE,
            reg_ocorr_sac.QT_ESTRELAS,
            v_vl_icms_prod);
    COMMIT;
  END LOOP; 
END SP_CARGA_T_MC_SGV_OCORRENCIA_SAC;

BEGIN
    SP_CARGA_T_MC_SGV_OCORRENCIA_SAC();
END;

/* VISUALIZACAO DOS DADOS CARREGADOS */
SELECT * FROM T_MC_SGV_OCORRENCIA_SAC;



       