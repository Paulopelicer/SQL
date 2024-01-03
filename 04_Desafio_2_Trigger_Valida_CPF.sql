/*** CRIANDO A TRIGGER NA TABELA T_MC_CLI_FISICA ***/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER TG_VALIDA_CPF

BEFORE INSERT OR UPDATE ON T_MC_CLI_FISICA
   FOR EACH ROW
    
   DECLARE
   V_CPF  VARCHAR2(11) := :NEW.NR_CPF;

BEGIN

  IF FN_CPF_VALIDACAO(V_CPF) = 1 THEN
    dbms_output.put_line('CPF VALIDO. OS DADOS SERAO INSERIDOS NA TABELA.');
  ELSE
    dbms_output.put_line('O CPF INSERIDO E INVALIDO. OS DADOS NAO SERAO CARREGADOS NA TABELA.');
    RAISE_APPLICATION_ERROR(-20001,'ATENCAO: NUMERO DE CPF INVALIDO!');    
  END IF;   
   
END TG_VALIDA_CPF;

/* INSERINDO UM CPF V�LIDO */
INSERT INTO T_MC_CLI_FISICA VALUES(16, '01/01/1990', 'M', 'MASCULINO', 37251297892);

/* ATUALIZANDO A COLUNA NR_CPF COM UM N�MERO DE CPF INV�LIDO */
UPDATE T_MC_CLI_FISICA
SET NR_CPF = 37251297899
WHERE NR_CLIENTE = 16;

