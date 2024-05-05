-- 5 - crear una función que retorne si un trabajador está vivo o muerto.
CREATE OR REPLACE FUNCTION estado_trabajador (id_trabajador persons.persons_id%type)
RETURN VARCHAR2
IS
  v_birthdate DATE;
  v_current_year NUMBER;
  v_birth_year NUMBER;
  v_age NUMBER;
BEGIN
  -- Obtener la fecha de nacimiento del trabajador
  SELECT birthdate INTO v_birthdate
  FROM persons
  WHERE persons_id = id_trabajador;

  -- Extraer el año actual y el año de nacimiento
  v_current_year := EXTRACT(YEAR FROM SYSDATE);
  v_birth_year := EXTRACT(YEAR FROM v_birthdate);

  -- Calcular la edad del trabajador
  v_age := v_current_year - v_birth_year;

  -- Determinar si el trabajador está probablemente vivo o muerto
  IF v_age < 100 THEN
    RETURN 'Vivo';
  ELSE
    RETURN 'Muerto';
  END IF;
END;

SELECT  estado_trabajador(1) FROM dual;