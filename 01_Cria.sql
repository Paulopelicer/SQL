/* CRIANDO AS SEQUENCES */

CREATE SEQUENCE SQ_MC_CATEGORIA_PROD
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_PRODUTO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_VISUALIZACAO_VIDEO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_SAC
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_CLIENTE
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_FUNCIONARIO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_DEPTO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_LOGRADOURO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_BAIRRO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_CIDADE
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SQ_MC_SGV_OCORRENCIA_SAC
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;


CREATE TABLE t_mc_bairro (
    cd_bairro       NUMBER(8) NOT NULL,
    cd_cidade       NUMBER(8) NOT NULL,
    nm_bairro       VARCHAR2(45),
    nm_zona_bairro  VARCHAR2(20)
);

COMMENT ON COLUMN t_mc_bairro.cd_bairro IS
    'Esta coluna ir� receber o codigo do bairro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_bairro.cd_cidade IS
    'Esta coluna ir� receber o codigo da cidade e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_bairro.nm_bairro IS
    'Esta coluna ira receber o nome do Bairro. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_bairro.nm_zona_bairro IS
    'Esta coluna ir� receber a localiza��o da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.';

ALTER TABLE t_mc_bairro ADD CONSTRAINT pk_mc_bairro PRIMARY KEY ( cd_bairro );

CREATE TABLE t_mc_categoria_prod (
    cd_categoria  NUMBER NOT NULL,
    tp_categoria  CHAR(1) NOT NULL,
    ds_categoria  VARCHAR2(500) NOT NULL,
    dt_inicio     DATE,
    dt_termino    DATE,
    st_categoria  CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_mc_categoria_prod.cd_categoria IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  ser� acionada a Sequence  SQ_MC_CATEGORIA que se encarregar� de gerar o pr�ximo n�mero �nico da categoria..';

COMMENT ON COLUMN t_mc_categoria_prod.tp_categoria IS
    'Nessa  coluna  ser�  armazenada o tipo de categoria que poder�  ser (V)�deo ou (P)rodudto. Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_categoria_prod.ds_categoria IS
    'Essa coluna ir� armazenar descri��o da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descri��o �nica e serve para organizar os produtos em categorias simliares, melhorando a tomada de decis�o.';

COMMENT ON COLUMN t_mc_categoria_prod.dt_inicio IS
    'Essa coluna ir� receber  a data de in�cio da categoria. Seu formato � dd/mm/yyyy e seu conte�do deve ser sempre  obrigat�rio.';

COMMENT ON COLUMN t_mc_categoria_prod.dt_termino IS
    'Essa coluna ir� receber  a data de encerramento  da categoria. Seu formato � dd/mm/yyyy e seu conte�do deve ser sempre  opcional. Conte�do obrigat�rio significa que a categoria foi encerrada a partir da data t�rmino. J� o conte�do opcional indica que a categoria est� ativa e operante.';

COMMENT ON COLUMN t_mc_categoria_prod.st_categoria IS
    'Essa coluna ir� armazenar o stauts da categoria da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

ALTER TABLE t_mc_categoria_prod
    ADD CONSTRAINT ck_mc_categoria_st_cat CHECK ( st_categoria IN (
        'A',
        'I'
    ) );

ALTER TABLE t_mc_categoria_prod ADD CONSTRAINT pk_mc_categoria PRIMARY KEY ( cd_categoria );

CREATE TABLE t_mc_cidade (
    cd_cidade  NUMBER(8) NOT NULL,
    sg_estado  CHAR(2) NOT NULL,
    nm_cidade  VARCHAR2(60) NOT NULL,
    cd_ibge    NUMBER(8),
    nr_ddd     NUMBER(3)
);

COMMENT ON COLUMN t_mc_cidade.cd_cidade IS
    'Esta coluna ir� receber o codigo da cidade e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_cidade.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_cidade.nm_cidade IS
    'Esta coluna ira receber o nome da Cidade. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_cidade.cd_ibge IS
    'Esta coluna ir� receber o c�digo do IBGE que fornece informa��es para gera��o da NFe.';

COMMENT ON COLUMN t_mc_cidade.nr_ddd IS
    'Esta coluna ir� receber o n�mero do DDD da cidade para ser utilizado no contato telef�nico. Seu conteudo � opcional.';

ALTER TABLE t_mc_cidade ADD CONSTRAINT pk_mc_cidade PRIMARY KEY ( cd_cidade );

CREATE TABLE t_mc_cli_fisica (
    nr_cliente         NUMBER(10) NOT NULL,
    dt_nascimento      DATE NOT NULL,
    fl_sexo_biologico  CHAR(1) NOT NULL,
    ds_genero          VARCHAR2(100),
    nr_cpf             VARCHAR2(14) NOT NULL
);

COMMENT ON COLUMN t_mc_cli_fisica.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da tabela NC_CLIENTE. ';

COMMENT ON COLUMN t_mc_cli_fisica.dt_nascimento IS
    'Essa coluna ir� armazenar a data de nascimento do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio. ';

COMMENT ON COLUMN t_mc_cli_fisica.fl_sexo_biologico IS
    'Essa coluna ir� armazenar o sexo biol�gico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.. ';

COMMENT ON COLUMN t_mc_cli_fisica.ds_genero IS
    'Genero do sexo do Cliente. Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_cli_fisica.nr_cpf IS
    'Essa coluna ir� armazenar o n�mero do CPF do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio. ';

ALTER TABLE t_mc_cli_fisica ADD CONSTRAINT pk_mc_cli_fisica PRIMARY KEY ( nr_cliente );

CREATE TABLE t_mc_cli_juridica (
    nr_cliente    NUMBER(10) NOT NULL,
    dt_fundacao   DATE NOT NULL,
    nr_cnpj       VARCHAR2(20) NOT NULL,
    nr_inscr_est  VARCHAR2(15)
);

COMMENT ON COLUMN t_mc_cli_juridica.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da tabela NC_CLIENTE. ';

COMMENT ON COLUMN t_mc_cli_juridica.dt_fundacao IS
    'Essa coluna ir� armazenar data  de funda��o do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_cli_juridica.nr_cnpj IS
    'Essa coluna ir� armazenar o  numero do CNPJ do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_cli_juridica.nr_inscr_est IS
    'Essa coluna ir� armazenar o  numero da Inscri��o Estadual  do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser opcional';

ALTER TABLE t_mc_cli_juridica ADD CONSTRAINT pk_mc_cli_juridica PRIMARY KEY ( nr_cliente );

CREATE TABLE t_mc_cliente (
    nr_cliente       NUMBER(10) NOT NULL,
    nm_cliente       VARCHAR2(160) NOT NULL,
    qt_estrelas      NUMBER(1) NOT NULL,
    vl_medio_compra  NUMBER(10, 2),
    st_cliente       CHAR(1) NOT NULL,
    ds_email         VARCHAR2(100) NOT NULL,
    nr_telefone      VARCHAR2(20),
    nm_login         VARCHAR2(50) NOT NULL,
    ds_senha         VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN t_mc_cliente.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual ter� sempre o n�mero disponivel para uso.';

COMMENT ON COLUMN t_mc_cliente.nm_cliente IS
    'Essa coluna ir� armazenar o nome do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_cliente.qt_estrelas IS
    'Essa coluna ir� armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio e ser poss�vel de estar entre 1 e 5 estrelas.';

COMMENT ON COLUMN t_mc_cliente.vl_medio_compra IS
    'Essa coluna ir� armazenar o valor  m�dio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio e deve ser calculado diariamente.';

COMMENT ON COLUMN t_mc_cliente.st_cliente IS
    'Essa coluna ir� armazenar o stauts do cliente da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN t_mc_cliente.ds_email IS
    'Essa coluna ir� armazenar o email  do cliente da Melhorees Compras. No minimo � esperado um email contendo o caractere (@) em seu conte�do.';

COMMENT ON COLUMN t_mc_cliente.nr_telefone IS
    'Essa coluna ir� armazenar o n�mero do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pr� definida.';

COMMENT ON COLUMN t_mc_cliente.nm_login IS
    'Essa coluna ir� armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conte�do deve ser obrigat�rio e  �nico para cada cliente.';

COMMENT ON COLUMN t_mc_cliente.ds_senha IS
    'Essa coluna ir� armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.';

ALTER TABLE t_mc_cliente ADD CONSTRAINT pk_mc_cliente PRIMARY KEY ( nr_cliente );

ALTER TABLE t_mc_cliente ADD CONSTRAINT uk_mc_cliente_nm_login UNIQUE ( nm_login );

CREATE TABLE t_mc_depto (
    cd_depto  NUMBER(3) NOT NULL,
    nm_depto  VARCHAR2(100) NOT NULL,
    st_depto  CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_mc_depto.cd_depto IS
    'Esta coluna ir� receber o codigo do departamento  e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_depto.nm_depto IS
    'Esta coluna ir� receber o nome do  departamento  e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_depto.st_depto IS
    'Esta coluna ir� receber o status do  departamento  e seu conte�do � obrigat�rio. Os valores poss�veis s�o: (A)tivo e (I)nativo.';

ALTER TABLE t_mc_depto
    ADD CONSTRAINT ck_mc_depto_st_depto CHECK ( st_depto IN (
        'A',
        'I'
    ) );

ALTER TABLE t_mc_depto ADD CONSTRAINT pk_mc_depto PRIMARY KEY ( cd_depto );

CREATE TABLE t_mc_end_cli (
    nr_cliente          NUMBER(10) NOT NULL,
    cd_logradouro_cli   NUMBER(10) NOT NULL,
    nr_end              NUMBER(8) NOT NULL,
    ds_complemento_end  VARCHAR2(80),
    dt_inicio           DATE,
    dt_termino          DATE,
    st_end              CHAR(1)
);

COMMENT ON COLUMN t_mc_end_cli.nr_cliente IS
    'Esta coluna ir� receber o n�mero do cliente e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_end_cli.cd_logradouro_cli IS
    'Esta coluna ir� receber o c�digo do logradouro  do cliente e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_end_cli.nr_end IS
    'N�mero do Endere�o do Cliente. O n�mero da Rua/Localidade onde o cliente est� associado.';

COMMENT ON COLUMN t_mc_end_cli.ds_complemento_end IS
    'Esta coluna ir� receber o complemento do endere�o do cliente e seu conte�do pode ser opcional.';

COMMENT ON COLUMN t_mc_end_cli.dt_inicio IS
    'Data de in�cio do endere�o associado ao cliente.';

COMMENT ON COLUMN t_mc_end_cli.dt_termino IS
    'Data de t�rmino do endere�o associado ao cliente.';

COMMENT ON COLUMN t_mc_end_cli.st_end IS
    'Status do endere�o. (A)itvo ou (I)nativo.';

ALTER TABLE t_mc_end_cli
    ADD CONSTRAINT ck_mc_end_cli_st_end CHECK ( st_end IN (
        'A',
        'I'
    ) );

ALTER TABLE t_mc_end_cli ADD CONSTRAINT pk_mc_end_cli PRIMARY KEY ( nr_cliente,
                                                                    cd_logradouro_cli );

CREATE TABLE t_mc_end_func (
    cd_funcionario      NUMBER(10) NOT NULL,
    cd_logradouro       NUMBER(10) NOT NULL,
    nr_end              NUMBER(8) NOT NULL,
    ds_complemento_end  VARCHAR2(80),
    dt_inicio           DATE NOT NULL,
    dt_termino          DATE,
    st_end              CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_mc_end_func.nr_end IS
    'N�mero do Endere�o do Cliente. O n�mero da Rua/Localidade onde o cliente est� associado.';

COMMENT ON COLUMN t_mc_end_func.dt_inicio IS
    'Data de in�cio do endere�o associado ao cliente.';

COMMENT ON COLUMN t_mc_end_func.dt_termino IS
    'Data de t�rmino do endere�o associado ao cliente.';

ALTER TABLE t_mc_end_func
    ADD CONSTRAINT ck_mc_end_func_st_end CHECK ( st_end IN (
        'A',
        'I'
    ) );

ALTER TABLE t_mc_end_func ADD CONSTRAINT pk_mc_end_func_pk PRIMARY KEY ( cd_funcionario,
                                                                         cd_logradouro );

CREATE TABLE t_mc_estado (
    sg_estado  CHAR(2) NOT NULL,
    nm_estado  VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mc_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_estado.nm_estado IS
    'Esta coluna ir� receber o nome do estado';

ALTER TABLE t_mc_estado ADD CONSTRAINT pk_mc_estado PRIMARY KEY ( sg_estado );

CREATE TABLE t_mc_funcionario (
    cd_funcionario     NUMBER(10) NOT NULL,
    cd_depto           NUMBER(3) NOT NULL,
    cd_gerente         NUMBER(10),
    nm_funcionario     VARCHAR2(160),
    dt_nascimento      DATE NOT NULL,
    fl_sexo_biologico  CHAR(1),
    ds_genero          VARCHAR2(100),
    ds_cargo           VARCHAR2(80) NOT NULL,
    vl_salario         NUMBER(10, 2),
    ds_email           VARCHAR2(80),
    st_func            CHAR(1),
    dt_cadastramento   DATE,
    dt_desligamento    DATE
);

COMMENT ON COLUMN t_mc_funcionario.cd_funcionario IS
    'Esta coluna ir� receber o codigo do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_funcionario.cd_depto IS
    'Esta coluna ir� receber o codigo do departamento onde o funcionario trabalha  e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_funcionario.cd_gerente IS
    'Esta coluna ir� receber o codigo do gestor do funcionario trabalha  e seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_funcionario.nm_funcionario IS
    'Esta coluna ir� receber o nome do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_funcionario.dt_nascimento IS
    'Esta coluna ir� receber a data de nascimento  do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_funcionario.fl_sexo_biologico IS
    'Esta coluna ir� receber o sexo biol�gico do funcion�rio e seu conte�do � obrigat�rio.Os valores permitidos aqui seriam: (F)eminino; (M)asculino ou (Hermafrodita)';

COMMENT ON COLUMN t_mc_funcionario.ds_genero IS
    'Esta coluna ir� receber o genero atribuido ao funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_funcionario.ds_cargo IS
    'Esta coluna ir� receber o cargo do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_funcionario.vl_salario IS
    'Esta coluna ir� receber o valor do sal�rio do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_funcionario.ds_email IS
    'Esta coluna ir� receber o email do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_funcionario.st_func IS
    'Essa coluna ir� armazenar o stauts do funcion�rio da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN t_mc_funcionario.dt_cadastramento IS
    'Data de cadastramento do Funcionario';

COMMENT ON COLUMN t_mc_funcionario.dt_desligamento IS
    'Data de desligamento  do Funcionario. Seu conte�do � opcional.';

ALTER TABLE t_mc_funcionario
    ADD CONSTRAINT ck_mc_funcionario_st_func CHECK ( st_func IN (
        'A',
        'I'
    ) );

ALTER TABLE t_mc_funcionario ADD CONSTRAINT pk_mc_funcionario PRIMARY KEY ( cd_funcionario );

CREATE TABLE t_mc_logradouro (
    cd_logradouro  NUMBER(10) NOT NULL,
    cd_bairro      NUMBER(8) NOT NULL,
    nm_logradouro  VARCHAR2(160) NOT NULL,
    nr_cep         NUMBER(8)
);

COMMENT ON COLUMN t_mc_logradouro.cd_logradouro IS
    'Esta coluna ir� receber o c�digo do logradouro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_logradouro.cd_bairro IS
    'Esta coluna ir� receber o codigo do bairro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_logradouro.nm_logradouro IS
    'Esta coluna ir� receber o nome do logradouro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_logradouro.nr_cep IS
    'Esta coluna ir� receber o numero do CEP do Logradouro e seu conte�do � obrigat�rio.';

ALTER TABLE t_mc_logradouro ADD CONSTRAINT pk_mc_logradouro PRIMARY KEY ( cd_logradouro );

CREATE TABLE t_mc_produto (
    cd_produto         NUMBER(10) NOT NULL,
    cd_categoria       NUMBER NOT NULL,
    nr_cd_barras_prod  VARCHAR2(50),
    ds_produto         VARCHAR2(80) NOT NULL,
    vl_unitario        NUMBER(8, 2) NOT NULL,
    tp_embalagem       VARCHAR2(15),
    st_produto         CHAR(1),
    vl_perc_lucro      NUMBER(8, 2),
    ds_completa_prod   VARCHAR2(4000) NOT NULL
);

COMMENT ON COLUMN t_mc_produto.cd_produto IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de produtos da Melhorees Compras. A cada produto cadastrado ser� acionada a Sequence  SQ_MC_PRODUTO que se encarregar� de gerar o pr�ximo n�mero �nico do produto.';

COMMENT ON COLUMN t_mc_produto.cd_categoria IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  ser� acionada a Sequence  SQ_MC_CATEGORIA que se encarregar� de gerar o pr�ximo n�mero �nico da categoria..';

COMMENT ON COLUMN t_mc_produto.nr_cd_barras_prod IS
    'Essa coluna ir� armazenar o n�mero do codigo de barras  do produto. Seu conte�do deve ser opcional.';

COMMENT ON COLUMN t_mc_produto.ds_produto IS
    'Essa coluna ir� armazenar a descri��o principal do produto. Seu conte�do deve ser  obrigatorio.';

COMMENT ON COLUMN t_mc_produto.vl_unitario IS
    'Essa coluna ir� armazenar o valor unit�rio do produto. Seu conte�do deve ser > 0 ';

COMMENT ON COLUMN t_mc_produto.tp_embalagem IS
    'Essa coluna ir� armazenar o tipo de embalagem do produto. Seu conte�do pode ser opcional.';

COMMENT ON COLUMN t_mc_produto.st_produto IS
    'Essa coluna ir� armazenar o stauts do produto da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN t_mc_produto.vl_perc_lucro IS
    'Essa coluna ir� armazenar o percentual  do lucro m�dio para cada produto. Seu conte�do deve ser opcional.';

COMMENT ON COLUMN t_mc_produto.ds_completa_prod IS
    'Essa coluna ir� armazenar a descri��o completa do produto. Seu conte�do deve ser  obrigatorio.';

ALTER TABLE t_mc_produto
    ADD CONSTRAINT ck_mc_produto_st_status CHECK ( st_produto IN (
        'A',
        'I'
    ) );

ALTER TABLE t_mc_produto ADD CONSTRAINT pk_mc_produto PRIMARY KEY ( cd_produto );

CREATE TABLE t_mc_sgv_ocorrencia_sac (
    nr_ocorrencia_sac             NUMBER NOT NULL,
    dt_abertura_sac               DATE,
    hr_abertura_sac               NUMBER(2),
    ds_tipo_classificacao_sac     VARCHAR2(30) NOT NULL,
    ds_indice_satisfacao_atd_sac  VARCHAR2(30),
    cd_categoria_prod             NUMBER NOT NULL,
    nm_tipo_categoria_prod        VARCHAR2(25) NOT NULL,
    ds_categoria_prod             VARCHAR2(500) NOT NULL,
    cd_produto                    NUMBER(10),
    ds_produto                    VARCHAR2(80) NOT NULL,
    tp_embalagem                  VARCHAR2(15),
    vl_unitario_produto           NUMBER(10, 2) NOT NULL,
    vl_perc_lucro                 NUMBER(8, 2),
    vl_unitario_lucro_produto     NUMBER(8, 2),
    sg_estado                     CHAR(2) NOT NULL,
    nm_estado                     VARCHAR2(30) NOT NULL,
    nm_cidade                     VARCHAR2(60) NOT NULL,
    nm_bairro                     VARCHAR2(45) NOT NULL,
    nr_cliente                    NUMBER(10) NOT NULL,
    nm_cliente                    VARCHAR2(160) NOT NULL,
    qt_estrelas_cliente           NUMBER(1) NOT NULL,
    vl_icms_produto               NUMBER(8, 2)
);

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nr_ocorrencia_sac IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela ocorr�ncia SAC, que ser� utilizada pela area de neg�cio da Melhores  Compras.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.dt_abertura_sac IS
    'Essa coluna  ir�  receber a data e hor�rio do chamado  SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio e deve ser uma c�pia dos dados da coluna DT_ABERTURA_SAC na  tabela T_MC_SGV_SAC.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.ds_tipo_classificacao_sac IS
    'Essa coluna  ir�  receber a descri��o da classfica��o do tipo de chamado SAC. O tipo do chamado SAC aberto pelo cliente. Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: Sugest�o; D�vida ou  Elogio. Esses valores devem ser calculados a partir do conte�do da coluna TP_SAC na tabela T_MC_SGV_SAC.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.ds_indice_satisfacao_atd_sac IS
    'Essa coluna ir� receber a descri��o do �ndice de satisfa��o  do cliente  perante o chamado aberto no SAC das Melhores Compras. Esse conte�do pode ser recuperado na tabela ORCL da FIAP pf0110.fun_gera_indice_sac_cli e deve ser selecionado sempre que necess�rio.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.cd_categoria_prod IS
    'Essa coluna ir� receber o c�digo da  categoria do produto  e seu conte�do deve ser obrigat�rio. Esse c�digo deve ser uma c�pia dos dados da coluna CD_CATEGORIA  na tabela T_MC_CATEGORIA_PROD.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_tipo_categoria_prod IS
    'Nessa  coluna  ser�  armazenada o tipo de categoria que poder�  ser V�deo ou Produdto. Seu conte�do deve ser obrigat�rio e deve ser transformado a partir da coluna TP_CATEGORIA na tabela T_MC_CATEGORIA_PROD.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.ds_categoria_prod IS
    'Essa coluna ir� armazenar descri��o da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descri��o �nica e serve para organizar os produtos em categorias simliares, melhorando a tomada de decis�o. Essa descri��o  deve ser uma c�pia dos dados da coluna DS_CATEGORIA na tabela T_MC_CATEGORIA_PROD.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.cd_produto IS
    'Essa coluna ir� receber o c�digo do produto e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna CD_PRODUTO na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.ds_produto IS
    'Essa coluna ir� receber a descri��o do produto e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna DS_PRODUTO na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.tp_embalagem IS
    'Essa coluna ir� armazenar o tipo de embalagem do produto. Seu conte�do pode ser opcional e deve ser uma c�pia da coluna TP_EMBALAGEM na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.vl_unitario_produto IS
    'Essa coluna ir� armazenar o valor unit�rio do produto. Seu conte�do deve ser > 0 e  deve ser uma c�pia dos dados da coluna VL_UNITARIO na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.vl_perc_lucro IS
    'Essa coluna ir� armazenar o valor percentual  do lucro sobre o produto ofertado. Seu conte�do deve ser uma c�pia dos dados da coluna VL_PERC_LUCRO na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.vl_unitario_lucro_produto IS
    'Essa coluna ir� armazenar o valor do lucro unitario do lucro sobre o produto ofertado. Seu conte�do deve ser calculado sobre a seguinte formula: conte�do da coluna (VL_PERC_LUCRO / 100 ) * VL_UNITARIO_PRODUTO. Esses valores se  encontram na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna SG_ESTADO  na tabela T_MC_ESTADO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_estado IS
    'Esta coluna ira receber a descri��o do nome  do Estado. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna NM_ESTADO  na tabela T_MC_ESTADO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_cidade IS
    'Esta coluna ira receber a descri��o do nome  da Cidade. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna NM_CIDADE  na tabela T_MC_CIDADE.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_bairro IS
    'Esta coluna ira receber a descri��o do nome  do  Bairro. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna NM_BAIRRO na tabela T_MC_BAIRRO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nr_cliente IS
    'Essa coluna ir� receber o c�digo do nome do cliente  e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna NR_CLIENTE  na tabela T_MC_CLIENTE.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_cliente IS
    'Essa coluna ir� receber o  nome do cliente  e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna NM_CLIENTE  na tabela T_MC_CLIENTE.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.qt_estrelas_cliente IS
    'Essa coluna ir� receber a quantidade de estrelas do cliente  e seu conte�do deve ser obrigat�rio. Esse valor deve ser uma c�pia dos dados da coluna QT_ESTRELAS  na tabela T_MC_CLIENTE.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.vl_icms_produto IS
    'Essa coluna ir� armazenar o valor m�dio do ICMS pago sobre o produto ofertado a partir do Estado onde o cliente solicita a entrega. Seu conte�do deve ser calculado sobre a seguinte formula: conte�do da coluna (VL_PERC_ALIQUOTA_MEDIA / 100 ) * VL_UNITARIO_PRODUTO. O valor da al�quota � extra�do da procedure prc_pega_aliquota_media_ICMS e o valor unit�rio do produto se  encontra na tabela T_MC_PRODUTO.';

ALTER TABLE t_mc_sgv_ocorrencia_sac ADD CONSTRAINT pk_mc_ocorrencia_sac PRIMARY KEY ( nr_ocorrencia_sac );

CREATE TABLE t_mc_sgv_produto_video (
    cd_produto          NUMBER(10) NOT NULL,
    nr_sequencia        NUMBER(3) NOT NULL,
    cd_categoria        NUMBER NOT NULL,
    vd_produto          BLOB,
    tp_video_prod       VARCHAR2(10),
    ds_path_video_prod  VARCHAR2(500),
    st_video_prod       CHAR(1)
);

COMMENT ON COLUMN t_mc_sgv_produto_video.cd_produto IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de produtos da Melhorees Compras. A cada produto cadastrado ser� acionada a Sequence  SQ_MC_PRODUTO que se encarregar� de gerar o pr�ximo n�mero �nico do produto.';

COMMENT ON COLUMN t_mc_sgv_produto_video.nr_sequencia IS
    'Essa coluna ir� armazenar a sequencia do v�deo a partir do codigo do produto. Sempre o primeiro v�deo de determinado  produto deve iniciar com o n�mero 1. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_produto_video.cd_categoria IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  ser� acionada a Sequence  SQ_MC_CATEGORIA que se encarregar� de gerar o pr�ximo n�mero �nico da categoria..';

COMMENT ON COLUMN t_mc_sgv_produto_video.vd_produto IS
    'Essa coluna ir� armazenar oo v�deo do produto no formato que melhor lhe  convier.  Para utilizar essa coluna tenha acesso a documenta��o oficial da Oracle. Seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_sgv_produto_video.tp_video_prod IS
    'Essa coluna ir� armazenar o tipo do  v�deo do produto. Seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_sgv_produto_video.ds_path_video_prod IS
    'Essa coluna ir� armazenar o caminho de acesso (link) contendo o  v�deo do produto. Seu conte�do � opcional.';

COMMENT ON COLUMN t_mc_sgv_produto_video.st_video_prod IS
    'Essa coluna ir� armazenar o stauts do v�deo do produto da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

ALTER TABLE t_mc_sgv_produto_video
    ADD CONSTRAINT ck_mc_sgv_prd_video_st_vidprd CHECK ( st_video_prod IN (
        'A',
        'I'
    ) );

ALTER TABLE t_mc_sgv_produto_video ADD CONSTRAINT pk_mc_produto_imagem PRIMARY KEY ( nr_sequencia,
                                                                                     cd_produto );

CREATE TABLE t_mc_sgv_sac (
    nr_sac                    NUMBER NOT NULL,
    nr_cliente                NUMBER(10) NOT NULL,
    cd_produto                NUMBER(10) NOT NULL,
    cd_funcionario            NUMBER(10),
    ds_detalhada_sac          CLOB,
    dt_abertura_sac           DATE,
    hr_abertura_sac           NUMBER(2),
    dt_atendimento            DATE,
    hr_atendimento_sac        NUMBER(2),
    nr_tempo_total_sac        NUMBER(10),
    ds_detalhada_retorno_sac  CLOB,
    tp_sac                    CHAR(1) NOT NULL,
    st_sac                    CHAR(1),
    nr_indice_satisfacao      NUMBER(2)
);

COMMENT ON COLUMN t_mc_sgv_sac.nr_sac IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de SAC de v�deo  da Melhorees Compras. A cada SAC cadastrado pelo cliente ser� acionada a Sequence  SQ_MC_SGV_SAC que se encarregar� de gerar o pr�ximo n�mero �nico do chamado SAC feito pelo Cliente.';

COMMENT ON COLUMN t_mc_sgv_sac.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da tabela NC_CLIENTE. ';

COMMENT ON COLUMN t_mc_sgv_sac.cd_produto IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de produtos da Melhorees Compras. A cada produto cadastrado ser� acionada a Sequence  SQ_MC_PRODUTO que se encarregar� de gerar o pr�ximo n�mero �nico do produto.';

COMMENT ON COLUMN t_mc_sgv_sac.cd_funcionario IS
    'Esta coluna ir� receber o codigo do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_sac.ds_detalhada_sac IS
    'Essa coluna  ir�  receber a descri��o completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_sac.dt_abertura_sac IS
    'Essa coluna  ir�  receber a data e hor�rio do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_sac.hr_abertura_sac IS
    'Essa coluna  ir�  receber a hora do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN t_mc_sgv_sac.dt_atendimento IS
    'Essa coluna  ir�  receber a data e hor�rio do atendmiento SAC feita pelo funcion�rio da Melhores Compras. Seu conteudo deve ser opcional..';

COMMENT ON COLUMN t_mc_sgv_sac.hr_atendimento_sac IS
    'Essa coluna  ir�  receber a hora do SAC do atendimento  feito  pelo funcionario da Melhores Compras. Seu conteudo deve ser opcional.';

COMMENT ON COLUMN t_mc_sgv_sac.nr_tempo_total_sac IS
    'Essa coluna  ir�  receber o tempo total em horas  (HH24) computado desde a abertura at� a conclus�o dele. A unidade de medida � horas, ou seja, em quantas horas o chamado foi conclu�do desde a sua abertura.';

COMMENT ON COLUMN t_mc_sgv_sac.ds_detalhada_retorno_sac IS
    'Essa coluna  ir�  receber a descri��o detalhada do retorno feito pelo funcion�rio a partir da solicita��o do cliente. Seu conte�do deve ser opcional e preenchido pelo funcion�rio.';

COMMENT ON COLUMN t_mc_sgv_sac.tp_sac IS
    'Essa coluna  ir�  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: (S)ugest�o; (D)�vida ou  (E)logio.';

COMMENT ON COLUMN t_mc_sgv_sac.st_sac IS
    'Essa coluna  ir�  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: (E)m Atendimento; (C)ancelado; (F)echado ou (X)Fechado com Insatisfa��o do cliente.';

COMMENT ON COLUMN t_mc_sgv_sac.nr_indice_satisfacao IS
    'Essa coluna  ir�  receber o �ndice de satisfa��o, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse �ndice de satisfa��o � opcional e informado pelo cliente ao final do atendimento.';

ALTER TABLE t_mc_sgv_sac ADD CONSTRAINT pk_mc_sgv_sac PRIMARY KEY ( nr_sac );

CREATE TABLE t_mc_sgv_visualizacao_video (
    cd_visualizacao_video  NUMBER(10) NOT NULL,
    nr_cliente             NUMBER(10),
    cd_produto             NUMBER(10) NOT NULL,
    dt_visualizacao        DATE NOT NULL,
    nr_hora_visualizacao   NUMBER(2) NOT NULL,
    nr_minuto_video        NUMBER(2) NOT NULL,
    nr_segundo_video       NUMBER(2) NOT NULL
);

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.cd_visualizacao_video IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de visualiza��o do v�deo, onde a cada click que o usuario logado ou an�nimo realizar, ser� anotado o acesso realizado.';

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual ter� sempre o n�mero disponivel para uso.';

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.cd_produto IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de produtos da Melhorees Compras. A cada produto cadastrado ser� acionada a Sequence  SQ_MC_PRODUTO que se encarregar� de gerar o pr�ximo n�mero �nico do produto.';

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.dt_visualizacao IS
    'Essa  coluna  ir�  receber a data da visualiza��o feita pelo  usu�rio no formato dd/mm/yyyy. Essa coluna � obrigat�ria.';

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.nr_hora_visualizacao IS
    'Essa  coluna  ir�  receber o hor�rio no formato HH24 da visualiza��o feita pelo  usu�rio. Essa coluna � obrigat�ria.';

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.nr_minuto_video IS
    'Essa  coluna  ir�  receber o hor�rio do minuto do v�deo quando foi feita a visualiza��o pelo  usu�rio. Essa coluna � obrigat�ria e os valores poss�veis est�o entre 00 e 59, representando os minutos.';

COMMENT ON COLUMN t_mc_sgv_visualizacao_video.nr_segundo_video IS
    'Essa  coluna  ir�  receber o hor�rio dos segundos do v�deo quando foi feita a visualiza��o pelo  usu�rio. Essa coluna � obrigat�ria e os valores poss�veis est�o entre 00 e 59, representando os minutos.';

ALTER TABLE t_mc_sgv_visualizacao_video ADD CONSTRAINT pk_mc_sgv_visualizacao_video PRIMARY KEY ( cd_visualizacao_video );

ALTER TABLE t_mc_bairro
    ADD CONSTRAINT fk_mc_bairro_cidade FOREIGN KEY ( cd_cidade )
        REFERENCES t_mc_cidade ( cd_cidade );

ALTER TABLE t_mc_sgv_produto_video
    ADD CONSTRAINT fk_mc_categoria_video FOREIGN KEY ( cd_categoria )
        REFERENCES t_mc_categoria_prod ( cd_categoria );

ALTER TABLE t_mc_cidade
    ADD CONSTRAINT fk_mc_cidade_estado FOREIGN KEY ( sg_estado )
        REFERENCES t_mc_estado ( sg_estado );

ALTER TABLE t_mc_end_cli
    ADD CONSTRAINT fk_mc_cliente_end FOREIGN KEY ( nr_cliente )
        REFERENCES t_mc_cliente ( nr_cliente );

ALTER TABLE t_mc_cli_fisica
    ADD CONSTRAINT fk_mc_cliente_fisica FOREIGN KEY ( nr_cliente )
        REFERENCES t_mc_cliente ( nr_cliente );

ALTER TABLE t_mc_cli_juridica
    ADD CONSTRAINT fk_mc_cliente_juridica FOREIGN KEY ( nr_cliente )
        REFERENCES t_mc_cliente ( nr_cliente );

ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT fk_mc_cliente_sgv_sac FOREIGN KEY ( nr_cliente )
        REFERENCES t_mc_cliente ( nr_cliente );

ALTER TABLE t_mc_sgv_visualizacao_video
    ADD CONSTRAINT fk_mc_cliente_visualiz_video FOREIGN KEY ( nr_cliente )
        REFERENCES t_mc_cliente ( nr_cliente );

ALTER TABLE t_mc_funcionario
    ADD CONSTRAINT fk_mc_depto_func FOREIGN KEY ( cd_depto )
        REFERENCES t_mc_depto ( cd_depto );

ALTER TABLE t_mc_end_func
    ADD CONSTRAINT fk_mc_end_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_mc_funcionario ( cd_funcionario );

ALTER TABLE t_mc_end_func
    ADD CONSTRAINT fk_mc_end_func_logradouro FOREIGN KEY ( cd_logradouro )
        REFERENCES t_mc_logradouro ( cd_logradouro );

ALTER TABLE t_mc_funcionario
    ADD CONSTRAINT fk_mc_func_superior FOREIGN KEY ( cd_gerente )
        REFERENCES t_mc_funcionario ( cd_funcionario );

ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT fk_mc_funcionario_sgv_sac FOREIGN KEY ( cd_funcionario )
        REFERENCES t_mc_funcionario ( cd_funcionario );

ALTER TABLE t_mc_logradouro
    ADD CONSTRAINT fk_mc_logradouro_bairro FOREIGN KEY ( cd_bairro )
        REFERENCES t_mc_bairro ( cd_bairro );

ALTER TABLE t_mc_end_cli
    ADD CONSTRAINT fk_mc_logradouro_end FOREIGN KEY ( cd_logradouro_cli )
        REFERENCES t_mc_logradouro ( cd_logradouro );

ALTER TABLE t_mc_sgv_produto_video
    ADD CONSTRAINT fk_mc_produto_imagem FOREIGN KEY ( cd_produto )
        REFERENCES t_mc_produto ( cd_produto );

ALTER TABLE t_mc_sgv_sac
    ADD CONSTRAINT fk_mc_produto_sgv_sac FOREIGN KEY ( cd_produto )
        REFERENCES t_mc_produto ( cd_produto );

ALTER TABLE t_mc_sgv_visualizacao_video
    ADD CONSTRAINT fk_mc_produto_visualizacao FOREIGN KEY ( cd_produto )
        REFERENCES t_mc_produto ( cd_produto );

ALTER TABLE t_mc_produto
    ADD CONSTRAINT fk_mc_sub_categoria_prod FOREIGN KEY ( cd_categoria )
        REFERENCES t_mc_categoria_prod ( cd_categoria );

CREATE OR REPLACE TRIGGER arc_fk_arco_cl_t_mc_cli_fisica BEFORE
    INSERT OR UPDATE OF nr_cliente ON t_mc_cli_fisica
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.nr_cliente
    INTO d
    FROM
        t_mc_cliente a
    WHERE
        a.nr_cliente = :new.nr_cliente;

    IF ( d IS NULL OR d <> :new.nr_cliente ) THEN
        raise_application_error(-20223, 'FK FK_MC_CLIENTE_FISICA in Table T_MC_CLI_FISICA violates Arc constraint on Table T_MC_CLIENTE - discriminator column NR_CLIENTE doesn''t have value NR_CLIENTE');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fk_arco__t_mc_cli_juridica BEFORE
    INSERT OR UPDATE OF nr_cliente ON t_mc_cli_juridica
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.nr_cliente
    INTO d
    FROM
        t_mc_cliente a
    WHERE
        a.nr_cliente = :new.nr_cliente;

    IF ( d IS NULL OR d <> :new.nr_cliente ) THEN
        raise_application_error(-20223, 'FK FK_MC_CLIENTE_JURIDICA in Table T_MC_CLI_JURIDICA violates Arc constraint on Table T_MC_CLIENTE - discriminator column NR_CLIENTE doesn''t have value NR_CLIENTE');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE TABLE t_mc_sgv_ocorrencia_sac (
    nr_ocorrencia_sac             NUMBER NOT NULL,
    dt_abertura_sac               DATE,
    hr_abertura_sac               NUMBER(2),
    ds_tipo_classificacao_sac     VARCHAR2(30) NOT NULL,
    ds_indice_satisfacao_atd_sac  VARCHAR2(30),
    cd_categoria_prod             NUMBER NOT NULL,
    nm_tipo_categoria_prod        VARCHAR2(25) NOT NULL,
    ds_categoria_prod             VARCHAR2(500) NOT NULL,
    cd_produto                    NUMBER(10),
    ds_produto                    VARCHAR2(80) NOT NULL,
    tp_embalagem                  VARCHAR2(15),
    vl_unitario_produto           NUMBER(10, 2) NOT NULL,
    vl_perc_lucro                 NUMBER(8, 2),
    vl_unitario_lucro_produto     NUMBER(8, 2),
    sg_estado                     CHAR(2) NOT NULL,
    nm_estado                     VARCHAR2(30) NOT NULL,
    nm_cidade                     VARCHAR2(60) NOT NULL,
    nm_bairro                     VARCHAR2(45) NOT NULL,
    nr_cliente                    NUMBER(10) NOT NULL,
    nm_cliente                    VARCHAR2(160) NOT NULL,
    qt_estrelas_cliente           NUMBER(1) NOT NULL,
    vl_icms_produto               NUMBER(8, 2)
);

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nr_ocorrencia_sac IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela ocorr�ncia SAC, que ser� utilizada pela area de neg�cio da Melhores  Compras.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.dt_abertura_sac IS
    'Essa coluna  ir�  receber a data e hor�rio do chamado  SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio e deve ser uma c�pia dos dados da coluna DT_ABERTURA_SAC na  tabela T_MC_SGV_SAC.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.ds_tipo_classificacao_sac IS
    'Essa coluna  ir�  receber a descri��o da classfica��o do tipo de chamado SAC. O tipo do chamado SAC aberto pelo cliente. Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: Sugest�o; D�vida ou  Elogio. Esses valores devem ser calculados a partir do conte�do da coluna TP_SAC na tabela T_MC_SGV_SAC.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.ds_indice_satisfacao_atd_sac IS
    'Essa coluna ir� receber a descri��o do �ndice de satisfa��o  do cliente  perante o chamado aberto no SAC das Melhores Compras. Esse conte�do pode ser recuperado na tabela ORCL da FIAP pf0110.fun_gera_indice_sac_cli e deve ser selecionado sempre que necess�rio.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.cd_categoria_prod IS
    'Essa coluna ir� receber o c�digo da  categoria do produto  e seu conte�do deve ser obrigat�rio. Esse c�digo deve ser uma c�pia dos dados da coluna CD_CATEGORIA  na tabela T_MC_CATEGORIA_PROD.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_tipo_categoria_prod IS
    'Nessa  coluna  ser�  armazenada o tipo de categoria que poder�  ser V�deo ou Produdto. Seu conte�do deve ser obrigat�rio e deve ser transformado a partir da coluna TP_CATEGORIA na tabela T_MC_CATEGORIA_PROD.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.ds_categoria_prod IS
    'Essa coluna ir� armazenar descri��o da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descri��o �nica e serve para organizar os produtos em categorias simliares, melhorando a tomada de decis�o. Essa descri��o  deve ser uma c�pia dos dados da coluna DS_CATEGORIA na tabela T_MC_CATEGORIA_PROD.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.cd_produto IS
    'Essa coluna ir� receber o c�digo do produto e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna CD_PRODUTO na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.ds_produto IS
    'Essa coluna ir� receber a descri��o do produto e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna DS_PRODUTO na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.tp_embalagem IS
    'Essa coluna ir� armazenar o tipo de embalagem do produto. Seu conte�do pode ser opcional e deve ser uma c�pia da coluna TP_EMBALAGEM na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.vl_unitario_produto IS
    'Essa coluna ir� armazenar o valor unit�rio do produto. Seu conte�do deve ser > 0 e  deve ser uma c�pia dos dados da coluna VL_UNITARIO na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.vl_perc_lucro IS
    'Essa coluna ir� armazenar o valor percentual  do lucro sobre o produto ofertado. Seu conte�do deve ser uma c�pia dos dados da coluna VL_PERC_LUCRO na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.vl_unitario_lucro_produto IS
    'Essa coluna ir� armazenar o valor do lucro unitario do lucro sobre o produto ofertado. Seu conte�do deve ser calculado sobre a seguinte formula: conte�do da coluna (VL_PERC_LUCRO / 100 ) * VL_UNITARIO_PRODUTO. Esses valores se  encontram na tabela T_MC_PRODUTO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna SG_ESTADO  na tabela T_MC_ESTADO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_estado IS
    'Esta coluna ira receber a descri��o do nome  do Estado. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna NM_ESTADO  na tabela T_MC_ESTADO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_cidade IS
    'Esta coluna ira receber a descri��o do nome  da Cidade. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna NM_CIDADE  na tabela T_MC_CIDADE.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_bairro IS
    'Esta coluna ira receber a descri��o do nome  do  Bairro. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna NM_BAIRRO na tabela T_MC_BAIRRO.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nr_cliente IS
    'Essa coluna ir� receber o c�digo do nome do cliente  e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna NR_CLIENTE  na tabela T_MC_CLIENTE.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.nm_cliente IS
    'Essa coluna ir� receber o  nome do cliente  e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna NM_CLIENTE  na tabela T_MC_CLIENTE.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.qt_estrelas_cliente IS
    'Essa coluna ir� receber a quantidade de estrelas do cliente  e seu conte�do deve ser obrigat�rio. Esse valor deve ser uma c�pia dos dados da coluna QT_ESTRELAS  na tabela T_MC_CLIENTE.';

COMMENT ON COLUMN t_mc_sgv_ocorrencia_sac.vl_icms_produto IS
    'Essa coluna ir� armazenar o valor m�dio do ICMS pago sobre o produto ofertado a partir do Estado onde o cliente solicita a entrega. Seu conte�do deve ser calculado sobre a seguinte formula: conte�do da coluna (VL_PERC_ALIQUOTA_MEDIA / 100 ) * VL_UNITARIO_PRODUTO. O valor da al�quota � extra�do da procedure prc_pega_aliquota_media_ICMS e o valor unit�rio do produto se  encontra na tabela T_MC_PRODUTO.';

ALTER TABLE t_mc_sgv_ocorrencia_sac ADD CONSTRAINT pk_mc_ocorrencia_sac PRIMARY KEY ( nr_ocorrencia_sac );