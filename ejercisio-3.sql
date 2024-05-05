-- 3- Cree un procedimiento que registre un trabajador. tabla: workers Nota: validar que la
-- persona exista antes de registrar como trabajador.
create or replace procedure registrar_worker(
  var_WORKERS_ID workers.WORKERS_ID%type,
  var_MINES_ID workers.MINES_ID%type,
  var_PERSONS_ID workers.PERSONS_ID%type
)
as
  var_val_id number;
begin
  select count(*) into var_val_id from persons where persons_id = var_PERSONS_ID;
    IF var_val_id = 0 THEN
        RAISE_APPLICATION_ERROR(-20001,'No existe la persona en la base de datos.');
    ELSE
        INSERT INTO WORKERS VALUES (var_WORKERS_ID, var_MINES_ID, var_PERSONS_ID, sysdate);
        DBMS_OUTPUT.PUT_LINE('Registrado Correctamente');    
    END IF;
end;

execute registrar_worker(2436780,2,24398);