-- 8 - Generar un procedimiento que dando el nombre una mina que se ingresa por teclado
-- retorne la cantidad de trabajadores infectados con VIH.


SET SERVEROUTPUT ON;
create or replace procedure infectionsVIH
(mina mines.MINE_NAME%type )
as
cantvih number;
begin
SELECT count (*) into cantvih
FROM persons p 
INNER JOIN persons_medical_check pmc ON p.persons_id = pmc.persons_id
INNER JOIN workers w ON p.persons_id = w.persons_id 
INNER JOIN mines m ON w.mines_id = m.mines_id 
WHERE LOWER(m.mine_name) = LOWER(mina) AND pmc.diagnostics_id = 3;
DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE PACIENTES CON VIH EN LA MINA: '||mina|| ' ES DE: ' ||cantvih);

END;

EXECUTE infectionsVIH('&mina');