 -- 9- Cree un procedimiento que muestre el mejor trabajador de cada mina.
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE MejorTrabajadorPorMina AS
BEGIN
  FOR r IN (
    SELECT m1.mine_name, q1.persons_id, q1.suma
    FROM (
      SELECT m.mine_name, pw.persons_id, SUM(pw.kg_product) AS suma
      FROM product_worker pw
      JOIN mines m ON pw.products_id = m.mines_id
      GROUP BY m.mine_name, pw.persons_id
    ) q1
    JOIN (
      SELECT mine_name, MAX(suma) AS max_suma
      FROM (
        SELECT m.mine_name, pw.persons_id, SUM(pw.kg_product) AS suma
        FROM product_worker pw
        JOIN mines m ON pw.products_id = m.mines_id
        GROUP BY m.mine_name, pw.persons_id
      ) q2
      GROUP BY mine_name
    ) m1 ON q1.mine_name = m1.mine_name AND q1.suma = m1.max_suma
  ) LOOP
  DBMS_OUTPUT.PUT_LINE('Mina: ' || r.mine_name || ', Trabajador: ' || r.persons_id || ', Suma: ' || TO_CHAR(r.suma, 'FM9990.99'));
  END LOOP;
END;

execute MejorTrabajadorPorMina;