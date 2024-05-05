-- 2- los niños y viejos y enfermos no pueden trabajar en la mina. por ello cree un trigger que
-- sea capaz de garantizar que ningún empleado viole esas restricciones.
-- Nota: niño es considerado inferior a 12 años y un viejo es alguien mayor de 70 años
-- Recuerda que no se admiten personas enfermas.
 
CREATE OR REPLACE TRIGGER no_puede_trabajar
BEFORE INSERT OR UPDATE ON persons
FOR EACH ROW
DECLARE
    v_edad NUMBER;
    v_enfermo NUMBER;
BEGIN
    -- Calcular la edad del empleado
    v_edad := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM :NEW.birthdate);
    
    -- Verificar si el empleado es menor de 12 años, mayor de 70 años o está enfermo
    IF v_edad < 12 OR v_edad > 70 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El empleado no puede trabajar en la mina debido a su edad.');
    END IF;

    -- Verificar si el empleado está enfermo
    SELECT diagnostics_id INTO v_enfermo FROM persons_medical_check  WHERE persons_id = :NEW.persons_id;
    IF v_enfermo != 1 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El empleado está enfermo y no puede trabajar en la mina.');
    END IF;
END;
