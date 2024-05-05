-- 4- crear un cursor que muestre el id, nombre, apellido, fecha de nacimiento de todas las
-- mujeres que trabajan en una mina, la mina debe ser indicada por entrada de teclado
 
CREATE OR REPLACE PROCEDURE mujeres(nombre_mina mines.mine_name%type)
AS
  CURSOR c_empleadas IS 
     SELECT p.persons_id, p.name, p.lastname, p.birthdate 
     FROM persons p 
     INNER JOIN workers w ON w.persons_id = p.persons_id 
     INNER JOIN mines m ON w.mines_id = m.mines_id
     WHERE p.sex = 'F' AND m.mine_name = nombre_mina; 
BEGIN
  FOR empleado IN c_empleadas LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || empleado.persons_id || ' Nombre: ' || empleado.name || ' Apellido: ' || empleado.lastname || ' Fecha de Nacimiento: ' || TO_CHAR(empleado.birthdate, 'DD/MM/YYYY'));
  END LOOP;
END;
 
EXECUTE mujeres('Cameroon');