-- SGBD ORACLE 11 G

CREATE TABLE t_emc_categ_video (
    cod_cat_vdo NUMBER(5) NOT NULL,
    des_cat_vdo VARCHAR2(30) NOT NULL,
    sta_cat_vdo CHAR(1)
);

COMMENT ON COLUMN t_emc_categ_video.cod_cat_vdo IS
    'codigo da categoria do video';

COMMENT ON COLUMN t_emc_categ_video.des_cat_vdo IS
    'descricao da categoria do video. Carregar tudo em maisculo.';

COMMENT ON COLUMN t_emc_categ_video.sta_cat_vdo IS
    'status da categoria do video';

ALTER TABLE t_emc_categ_video ADD CONSTRAINT t_emc_cat_vdo_pk PRIMARY KEY ( cod_cat_vdo );

CREATE TABLE t_emc_cli (
    cod_cli       NUMBER(7) NOT NULL,
    num_telf_comp VARCHAR2(20) NOT NULL,
    uid_log       VARCHAR2(20) NOT NULL,
    uid_senh      VARCHAR2(20) NOT NULL,
    tipo_pessoa   VARCHAR2(2) NOT NULL
);

COMMENT ON COLUMN t_emc_cli.cod_cli IS
    'codigo do cliente';

COMMENT ON COLUMN t_emc_cli.num_telf_comp IS
    'numero de telefone completo do cliente';

COMMENT ON COLUMN t_emc_cli.uid_log IS
    'identificador do cliente';

COMMENT ON COLUMN t_emc_cli.uid_senh IS
    'senha do cliente';

COMMENT ON COLUMN t_emc_cli.tipo_pessoa IS
    'Tipo Pessoa. Pode Assumir 2 valores, "PF" ou "PF"';

ALTER TABLE t_emc_cli ADD CONSTRAINT t_emc_cli_pk PRIMARY KEY ( cod_cli );

CREATE TABLE t_emc_cli_email (
    cod_cli   NUMBER(7) NOT NULL,
    cod_email NUMBER(5) NOT NULL
);

COMMENT ON COLUMN t_emc_cli_email.cod_cli IS
    'codigo do cliente';

COMMENT ON COLUMN t_emc_cli_email.cod_email IS
    'codigo do email do cliente';

ALTER TABLE t_emc_cli_email ADD CONSTRAINT t_emc_cli_email_pk PRIMARY KEY ( cod_cli,
                                                                            cod_email );

CREATE TABLE t_emc_departamento (
    cod_dep NUMBER(4) NOT NULL,
    nom_dep VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN t_emc_departamento.cod_dep IS
    'codigo do departamento';

COMMENT ON COLUMN t_emc_departamento.nom_dep IS
    'nome do departamento.Carregar usando InitCap.';

ALTER TABLE t_emc_departamento ADD CONSTRAINT t_emc_dep_pk PRIMARY KEY ( cod_dep );

CREATE TABLE t_emc_emailv1 (
    cod_email NUMBER(5) NOT NULL,
    des_email VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN t_emc_emailv1.cod_email IS
    'codigo do email.';

COMMENT ON COLUMN t_emc_emailv1.des_email IS
    'descricao do email.Carregar tudo em maisculo. ';

ALTER TABLE t_emc_emailv1 ADD CONSTRAINT t_emc_emailv2_pk PRIMARY KEY ( cod_email );

CREATE TABLE t_emc_emailv2 (
    cod_email NUMBER(5) NOT NULL,
    des_email VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN t_emc_emailv2.cod_email IS
    'codigo do email do cliente';

COMMENT ON COLUMN t_emc_emailv2.des_email IS
    'descricao do email.Carregar tudo em maisculo. ';

ALTER TABLE t_emc_emailv2 ADD CONSTRAINT t_emc_email_pk PRIMARY KEY ( cod_email );

CREATE TABLE t_emc_fornecedor (
    cod_forn          NUMBER(5) NOT NULL,
    des_forn          VARCHAR2(50) NOT NULL,
    num_cnpj_forn     NUMBER(14) NOT NULL,
    num_insc_est_forn NUMBER(9)
);

COMMENT ON COLUMN t_emc_fornecedor.cod_forn IS
    'codigo do fornecedor';

COMMENT ON COLUMN t_emc_fornecedor.des_forn IS
    'descricao do fornecedor. Carregar tudo em maisculo.';

COMMENT ON COLUMN t_emc_fornecedor.num_cnpj_forn IS
    'numero do cnpj do fornecedor';

COMMENT ON COLUMN t_emc_fornecedor.num_insc_est_forn IS
    'numero de inscricao estadual do fornecedor';

ALTER TABLE t_emc_fornecedor ADD CONSTRAINT t_emc_forn_pk PRIMARY KEY ( cod_forn );

CREATE TABLE t_emc_func (
    cod_func      NUMBER(4) NOT NULL,
    cod_dep       NUMBER(4) NOT NULL,
    mat_func      NUMBER(4) NOT NULL,
    nom_func      VARCHAR2(50) NOT NULL,
    dat_nasc      DATE NOT NULL,
    dat_adm       DATE NOT NULL,
    des_carg_func VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_emc_func.cod_func IS
    'codigo do funcionario';

COMMENT ON COLUMN t_emc_func.cod_dep IS
    'codigo do departamento';

COMMENT ON COLUMN t_emc_func.mat_func IS
    'matricula do funcionario';

COMMENT ON COLUMN t_emc_func.nom_func IS
    'nome do funcionario. Carregar usando InitCap';

COMMENT ON COLUMN t_emc_func.dat_nasc IS
    'data de nascimento do funcionario. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_func.dat_adm IS
    'data de admissão do funcionario. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_func.des_carg_func IS
    'cargo do funcionario. Carregar tudo em maisculo.';

ALTER TABLE t_emc_func ADD CONSTRAINT t_emc_func_pk PRIMARY KEY ( cod_func );

CREATE TABLE t_emc_func_email (
    cod_func  NUMBER(4) NOT NULL,
    cod_email NUMBER(5) NOT NULL
);

COMMENT ON COLUMN t_emc_func_email.cod_func IS
    'codigo do funcionario.';

COMMENT ON COLUMN t_emc_func_email.cod_email IS
    'codigo do email';

ALTER TABLE t_emc_func_email ADD CONSTRAINT t_emc_func_email_pk PRIMARY KEY ( cod_func );

CREATE TABLE t_emc_func_telf (
    num_telf_comp VARCHAR2(20) NOT NULL,
    cod_tpo_telf  NUMBER(5) NOT NULL,
    cod_func      NUMBER(4) NOT NULL,
    num_ddd       NUMBER(3) NOT NULL,
    num_telf      NUMBER(10) NOT NULL
);

COMMENT ON COLUMN t_emc_func_telf.num_telf_comp IS
    'numero de telefone completo';

COMMENT ON COLUMN t_emc_func_telf.cod_tpo_telf IS
    'codigo do tipo do telefone';

COMMENT ON COLUMN t_emc_func_telf.cod_func IS
    'codigo do funcionario';

COMMENT ON COLUMN t_emc_func_telf.num_ddd IS
    'numero de ddd do telefone';

COMMENT ON COLUMN t_emc_func_telf.num_telf IS
    'numero de telefone';

ALTER TABLE t_emc_func_telf ADD CONSTRAINT t_emc_func_telf_pk PRIMARY KEY ( num_telf_comp );

CREATE TABLE t_emc_pf (
    cod_cli      NUMBER(7) NOT NULL,
    nom_cli      VARCHAR2(50) NOT NULL,
    num_rg       NUMBER(9) NOT NULL,
    num_cpf      NUMBER(11) NOT NULL,
    dat_nasc_cli DATE NOT NULL,
    des_gen_cli  CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_emc_pf.cod_cli IS
    'codigo do cliente';

COMMENT ON COLUMN t_emc_pf.nom_cli IS
    'nome do cliente. Carregar usando InitCap.';

COMMENT ON COLUMN t_emc_pf.num_rg IS
    'numero do rg do cliente';

COMMENT ON COLUMN t_emc_pf.num_cpf IS
    'numero do cpf do cliente';

COMMENT ON COLUMN t_emc_pf.dat_nasc_cli IS
    'data de nascimento do cliente. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_pf.des_gen_cli IS
    'descricao do genêro de nascimento do cliente "M" masculino ou "F" feminino';

ALTER TABLE t_emc_pf ADD CONSTRAINT t_emc_pf_pk PRIMARY KEY ( cod_cli );

CREATE TABLE t_emc_pj (
    cod_cli      NUMBER(7) NOT NULL,
    nom_fant     VARCHAR2(50) NOT NULL,
    des_raz_soc  VARCHAR2(50) NOT NULL,
    des_marc     VARCHAR2(50),
    num_cnpj     NUMBER(14) NOT NULL,
    num_insc_est NUMBER(10)
);

COMMENT ON COLUMN t_emc_pj.cod_cli IS
    'codigo do cliente';

COMMENT ON COLUMN t_emc_pj.nom_fant IS
    'nome fantasia do cliente. Carregar usando InitCap';

COMMENT ON COLUMN t_emc_pj.des_raz_soc IS
    'descricao da razao social do cliente. Carregar tudo em maisculo';

COMMENT ON COLUMN t_emc_pj.des_marc IS
    'descricao da marca do cliente. Carregar tudo em maisculo.';

COMMENT ON COLUMN t_emc_pj.num_cnpj IS
    'numero do cnpj do cliente';

COMMENT ON COLUMN t_emc_pj.num_insc_est IS
    'numero de inscricao estadual do cliente';

ALTER TABLE t_emc_pj ADD CONSTRAINT t_emc_pj_pk PRIMARY KEY ( cod_cli );

CREATE TABLE t_emc_prod_categoria (
    cod_cat_prod NUMBER(5) NOT NULL,
    des_cat_prod VARCHAR2(30) NOT NULL,
    sta_cat_prod CHAR(1) NOT NULL,
    dat_ini      DATE NOT NULL,
    dat_term     DATE
);

COMMENT ON COLUMN t_emc_prod_categoria.cod_cat_prod IS
    'codigo da categoria do produto';

COMMENT ON COLUMN t_emc_prod_categoria.des_cat_prod IS
    'descricao da categoria do produto';

COMMENT ON COLUMN t_emc_prod_categoria.sta_cat_prod IS
    'status da categoria "A" ativo ou "I" inativo';

COMMENT ON COLUMN t_emc_prod_categoria.dat_ini IS
    'data de inicio. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_prod_categoria.dat_term IS
    'data de termino. Formato da data AAAA-MM-DD';

ALTER TABLE t_emc_prod_categoria ADD CONSTRAINT t_emc_prod_cat_pk PRIMARY KEY ( cod_cat_prod );

CREATE TABLE t_emc_prod_fornecedor (
    cod_prod NUMBER(5) NOT NULL,
    cod_forn NUMBER(5) NOT NULL,
    dat_forn DATE NOT NULL,
    qtd_prod NUMBER(5) NOT NULL
);

COMMENT ON COLUMN t_emc_prod_fornecedor.cod_prod IS
    'codigo do produto';

COMMENT ON COLUMN t_emc_prod_fornecedor.cod_forn IS
    'codigo do fornecedor';

COMMENT ON COLUMN t_emc_prod_fornecedor.dat_forn IS
    'data de fornecimento do produto. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_prod_fornecedor.qtd_prod IS
    'quantidade de produtos fornecidos';

ALTER TABLE t_emc_prod_fornecedor ADD CONSTRAINT t_emc_prod_forn_pk PRIMARY KEY ( cod_prod,
                                                                                  cod_forn );

CREATE TABLE t_emc_produto (
    cod_prod      NUMBER(5) NOT NULL,
    cod_cat_prod  NUMBER(5),
    des_prod      VARCHAR2(50) NOT NULL,
    des_prod_comp VARCHAR2(100) NOT NULL,
    val_unit_prod NUMBER(5, 2) NOT NULL,
    sta_prod      CHAR(1) NOT NULL,
    cod_barr_prod VARCHAR2(13)
);

COMMENT ON COLUMN t_emc_produto.cod_prod IS
    'codigo do produto';

COMMENT ON COLUMN t_emc_produto.cod_cat_prod IS
    'codigo da categoria do produto';

COMMENT ON COLUMN t_emc_produto.des_prod IS
    'descricao do produto. Carregar tudo em maisculo';

COMMENT ON COLUMN t_emc_produto.des_prod_comp IS
    'descricao completa do produto. Carregar tudo em maisculo';

COMMENT ON COLUMN t_emc_produto.val_unit_prod IS
    'valor unitário do produto';

COMMENT ON COLUMN t_emc_produto.sta_prod IS
    'status do produto "A" ativo ou "I" inativo';

COMMENT ON COLUMN t_emc_produto.cod_barr_prod IS
    'codigo de barras do produto padrao EAN13 ou correspondentes';

ALTER TABLE t_emc_produto ADD CONSTRAINT t_emc_prod_pk PRIMARY KEY ( cod_prod );

CREATE TABLE t_emc_sac (
    cod_cham        NUMBER(5) NOT NULL,
    cod_cli         NUMBER(7) NOT NULL,
    cod_func        NUMBER(4) NOT NULL,
    cod_prod        NUMBER(5) NOT NULL,
    des_cham        VARCHAR2(50) NOT NULL,
    dat_hr_aber     DATE NOT NULL,
    dat_hr_aten     DATE,
    sta_cham        CHAR(1) NOT NULL,
    qtd_temp_aten   DATE NOT NULL,
    ind_satis_cham  NUMBER(2),
    cod_tpo_cham    CHAR(1) NOT NULL,
    txt_cont_cham   CLOB NOT NULL,
    txt_cont_cham_1 CLOB
);

COMMENT ON COLUMN t_emc_sac.cod_cham IS
    'codigo do chamado';

COMMENT ON COLUMN t_emc_sac.cod_cli IS
    'codigo do cliente';

COMMENT ON COLUMN t_emc_sac.cod_func IS
    'codigo do funcionario';

COMMENT ON COLUMN t_emc_sac.cod_prod IS
    'codigo do produto';

COMMENT ON COLUMN t_emc_sac.des_cham IS
    'descricao do chamado.Carregar tudo em maisculo.';

COMMENT ON COLUMN t_emc_sac.dat_hr_aber IS
    'data e hora de abertura do chamado pelo cliente. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_sac.dat_hr_aten IS
    'data e hora do atendimento ao cliente. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_sac.sta_cham IS
    'status do chamado "A" aberto, "E" em atendimento, "C" cancelado, "F" fechado com sucesso ou "X" fechado com insatisfacao do cliente';

COMMENT ON COLUMN t_emc_sac.qtd_temp_aten IS
    'tempo total de atendimento ao cliente. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_sac.ind_satis_cham IS
    'indice de satiscacao do cliente computada de 1 a 10';

COMMENT ON COLUMN t_emc_sac.cod_tpo_cham IS
    'tipo do chamado "1" sugestao ou "2" reclamacao';

COMMENT ON COLUMN t_emc_sac.txt_cont_cham IS
    'todo chamado deve conter um texto de no maximo 10.000 caracteres. Carregar tudo em maisculo.';

COMMENT ON COLUMN t_emc_sac.txt_cont_cham_1 IS
    'todo chamado pode conter um texto de no maximo 20.000 caracteres. Carregar tudo em maisculo.';

ALTER TABLE t_emc_sac ADD CONSTRAINT t_emc_sac_pk PRIMARY KEY ( cod_cham );

CREATE TABLE t_emc_telf_cli (
    num_telf_comp VARCHAR2(20) NOT NULL,
    cod_tpo_telf  NUMBER(5) NOT NULL,
    cod_ddd       NUMBER(4) NOT NULL,
    num_telf      NUMBER(10) NOT NULL
);

COMMENT ON COLUMN t_emc_telf_cli.num_telf_comp IS
    'numero de telefone completo do cliente';

COMMENT ON COLUMN t_emc_telf_cli.cod_tpo_telf IS
    'codigo do tipo de telefone do cliente';

COMMENT ON COLUMN t_emc_telf_cli.cod_ddd IS
    'codigo ddd do telefone do cliente';

COMMENT ON COLUMN t_emc_telf_cli.num_telf IS
    'numero de telefone do cliente';

ALTER TABLE t_emc_telf_cli ADD CONSTRAINT t_emc_telf_cli_pk PRIMARY KEY ( num_telf_comp );

CREATE TABLE t_emc_tipo_telf_func (
    cod_tpo_telf NUMBER(5) NOT NULL,
    des_tpo_telf VARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN t_emc_tipo_telf_func.cod_tpo_telf IS
    'codigo do tipo do telefone';

COMMENT ON COLUMN t_emc_tipo_telf_func.des_tpo_telf IS
    'descricao do tipo de telefone';

ALTER TABLE t_emc_tipo_telf_func ADD CONSTRAINT t_emc_tipo_telf_pk PRIMARY KEY ( cod_tpo_telf );

CREATE TABLE t_emc_tpo_telf_cli (
    cod_tpo_telf NUMBER(5) NOT NULL,
    des_tpo_telf VARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN t_emc_tpo_telf_cli.cod_tpo_telf IS
    'codigo do tipo de telefone do cliente';

COMMENT ON COLUMN t_emc_tpo_telf_cli.des_tpo_telf IS
    'descricao do tipo de telefone do cliente';

ALTER TABLE t_emc_tpo_telf_cli ADD CONSTRAINT t_emc_tpo_telf_pk PRIMARY KEY ( cod_tpo_telf );

CREATE TABLE t_emc_video (
    cod_vdo     NUMBER(4) NOT NULL,
    cod_prod    NUMBER(5) NOT NULL,
    cod_cat_vdo NUMBER(5) NOT NULL,
    des_vdo     VARCHAR2(20) NOT NULL,
    sta_vdo     CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_emc_video.cod_vdo IS
    'codigo do video';

COMMENT ON COLUMN t_emc_video.cod_prod IS
    'codigo do produto';

COMMENT ON COLUMN t_emc_video.cod_cat_vdo IS
    'codigo da categoria do video';

COMMENT ON COLUMN t_emc_video.des_vdo IS
    'descricao do video. Carregar tudo em maisculo';

COMMENT ON COLUMN t_emc_video.sta_vdo IS
    'status do video "A" ativo ou "I" inativo';

ALTER TABLE t_emc_video ADD CONSTRAINT t_emc_vdo_pk PRIMARY KEY ( cod_vdo );

CREATE TABLE t_emc_visualizacao (
    cod_visualizacao    NUMBER(4) NOT NULL,
    cod_vdo             NUMBER(4) NOT NULL,
    cod_usu             NUMBER(5) NOT NULL,
    des_usu             VARCHAR2(20) NOT NULL,
    dat_hr_visualizacao DATE NOT NULL,
    sta_vdo             CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_emc_visualizacao.cod_visualizacao IS
    'codigo de visualizacao do video.';

COMMENT ON COLUMN t_emc_visualizacao.cod_vdo IS
    'codigo do video';

COMMENT ON COLUMN t_emc_visualizacao.cod_usu IS
    'codigo do usuario';

COMMENT ON COLUMN t_emc_visualizacao.des_usu IS
    'descricao do usuario. Carregar tudo em maisculo.';

COMMENT ON COLUMN t_emc_visualizacao.dat_hr_visualizacao IS
    'data, hora e minutos da visualizacao do video. Formato da data AAAA-MM-DD';

COMMENT ON COLUMN t_emc_visualizacao.sta_vdo IS
    'status do video "A" ativo ou "I" inativo';

ALTER TABLE t_emc_visualizacao ADD CONSTRAINT t_emc_visu_pk PRIMARY KEY ( cod_visualizacao );

ALTER TABLE t_emc_video
    ADD CONSTRAINT t_emc_cat_vdo_fk FOREIGN KEY ( cod_cat_vdo )
        REFERENCES t_emc_categ_video ( cod_cat_vdo );

ALTER TABLE t_emc_cli_email
    ADD CONSTRAINT t_emc_cli_fk FOREIGN KEY ( cod_cli )
        REFERENCES t_emc_cli ( cod_cli );

ALTER TABLE t_emc_sac
    ADD CONSTRAINT t_emc_cli_fkv2 FOREIGN KEY ( cod_cli )
        REFERENCES t_emc_cli ( cod_cli );

ALTER TABLE t_emc_cli_email
    ADD CONSTRAINT t_emc_email_fk FOREIGN KEY ( cod_email )
        REFERENCES t_emc_emailv2 ( cod_email );

ALTER TABLE t_emc_func_email
    ADD CONSTRAINT t_emc_emailv2_fk FOREIGN KEY ( cod_email )
        REFERENCES t_emc_emailv1 ( cod_email );

ALTER TABLE t_emc_prod_fornecedor
    ADD CONSTRAINT t_emc_forn_fk FOREIGN KEY ( cod_forn )
        REFERENCES t_emc_fornecedor ( cod_forn );

ALTER TABLE t_emc_func_email
    ADD CONSTRAINT t_emc_func_fk FOREIGN KEY ( cod_func )
        REFERENCES t_emc_func ( cod_func );

ALTER TABLE t_emc_sac
    ADD CONSTRAINT t_emc_func_fkv2 FOREIGN KEY ( cod_func )
        REFERENCES t_emc_func ( cod_func );

ALTER TABLE t_emc_func
    ADD CONSTRAINT t_emc_func_t_emc_dep_fk FOREIGN KEY ( cod_dep )
        REFERENCES t_emc_departamento ( cod_dep );

ALTER TABLE t_emc_func_telf
    ADD CONSTRAINT t_emc_func_telf_fk FOREIGN KEY ( cod_func )
        REFERENCES t_emc_func ( cod_func );

ALTER TABLE t_emc_pf
    ADD CONSTRAINT t_emc_pf_fk FOREIGN KEY ( cod_cli )
        REFERENCES t_emc_cli ( cod_cli );

ALTER TABLE t_emc_pj
    ADD CONSTRAINT t_emc_pj_fk FOREIGN KEY ( cod_cli )
        REFERENCES t_emc_cli ( cod_cli );

ALTER TABLE t_emc_produto
    ADD CONSTRAINT t_emc_prod_cat_fk FOREIGN KEY ( cod_cat_prod )
        REFERENCES t_emc_prod_categoria ( cod_cat_prod );

ALTER TABLE t_emc_prod_fornecedor
    ADD CONSTRAINT t_emc_prod_fk FOREIGN KEY ( cod_prod )
        REFERENCES t_emc_produto ( cod_prod );

ALTER TABLE t_emc_video
    ADD CONSTRAINT t_emc_prod_fkv2 FOREIGN KEY ( cod_prod )
        REFERENCES t_emc_produto ( cod_prod );

ALTER TABLE t_emc_sac
    ADD CONSTRAINT t_emc_prod_fkv3 FOREIGN KEY ( cod_prod )
        REFERENCES t_emc_produto ( cod_prod );

ALTER TABLE t_emc_cli
    ADD CONSTRAINT t_emc_telf_cli_fk FOREIGN KEY ( num_telf_comp )
        REFERENCES t_emc_telf_cli ( num_telf_comp );

ALTER TABLE t_emc_func_telf
    ADD CONSTRAINT t_emc_tipo_telf_fk FOREIGN KEY ( cod_tpo_telf )
        REFERENCES t_emc_tipo_telf_func ( cod_tpo_telf );

ALTER TABLE t_emc_telf_cli
    ADD CONSTRAINT t_emc_tpo_telf_cli_fk FOREIGN KEY ( cod_tpo_telf )
        REFERENCES t_emc_tpo_telf_cli ( cod_tpo_telf );

ALTER TABLE t_emc_visualizacao
    ADD CONSTRAINT t_emc_visu_fk FOREIGN KEY ( cod_vdo )
        REFERENCES t_emc_video ( cod_vdo );

CREATE OR REPLACE TRIGGER arc_arc_2_t_emc_pf BEFORE
    INSERT OR UPDATE OF cod_cli ON t_emc_pf
    FOR EACH ROW
DECLARE
    d VARCHAR2(2);
BEGIN
    SELECT
        a.tipo_pessoa
    INTO d
    FROM
        t_emc_cli a
    WHERE
        a.cod_cli = :new.cod_cli;

    IF ( d IS NULL OR d <> 'PF' ) THEN
        raise_application_error(
                               -20223,
                               'FK T_EMC_PF_FK in Table T_EMC_PF violates Arc constraint on Table T_EMC_CLI - discriminator column tipo_pessoa doesn''t have value ''PF'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_2_t_emc_pj BEFORE
    INSERT OR UPDATE OF cod_cli ON t_emc_pj
    FOR EACH ROW
DECLARE
    d VARCHAR2(2);
BEGIN
    SELECT
        a.tipo_pessoa
    INTO d
    FROM
        t_emc_cli a
    WHERE
        a.cod_cli = :new.cod_cli;

    IF ( d IS NULL OR d <> 'PJ' ) THEN
        raise_application_error(
                               -20223,
                               'FK T_EMC_PJ_FK in Table T_EMC_PJ violates Arc constraint on Table T_EMC_CLI - discriminator column tipo_pessoa doesn''t have value ''PJ'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/