/*** CRIANDO FUNÇÃO PARA VALIDAR O CPF ***/

create or replace FUNCTION FN_CPF_VALIDACAO (p_cpf IN CHAR) RETURN NUMBER IS
  m_total  NUMBER := 0;
  m_digito NUMBER := 0;
  
BEGIN

/* CALCULANDO PRIMEIRO DIGITO VERIFICADOR */
  FOR i IN 1 .. 9 LOOP
    m_total := m_total + substr(p_cpf, i, 1) * (11 - i);
  END LOOP;

  m_digito := 11 - MOD(m_total, 11);

  IF m_digito > 9 THEN
    m_digito := 0;
  END IF;

  IF m_digito != substr(p_cpf, 10, 1) THEN
    RETURN 0;
  END IF;

  m_digito := 0;
  m_total  := 0;

/* CALCULANDO O SEGUNDO DIGITO VERIFICADOR */
  FOR i IN 1 .. 10 LOOP
    m_total := m_total + substr(p_cpf, i, 1) * (12 - i);
  END LOOP;

  m_digito := 11 - MOD(m_total, 11);

  IF m_digito > 9 THEN
    m_digito := 0;
  END IF;

  IF m_digito != substr(p_cpf, 11, 1) THEN
    RETURN 0;
  END IF;
  
/* SE O CPF FOR VALIDO, RETORNA 1, SENÃO, RETORNA 0 */
  RETURN 1;
    EXCEPTION 
        WHEN OTHERS THEN 
    RETURN 0;
END FN_CPF_VALIDACAO;

DECLARE 
v_cpf_valido number;

BEGIN
    v_cpf_valido := FN_CPF_VALIDACAO(37251297899);
    IF v_cpf_valido = 1 THEN
        dbms_output.put_line('CPF VALIDO');
        
    ELSE 
        dbms_output.put_line('CPF INVALIDO');
    END IF;
END;