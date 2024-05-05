-- 6 - crear una función que retorne la cantidad de kilos que produce de una mina.
 
CREATE OR REPLACE FUNCTION kilos_mina(name_mina mines.mine_name%type)
RETURN NUMBER
IS 
 v_kilos NUMBER;
BEGIN
  SELECT SUM(p.kg_product) INTO v_kilos 
  FROM product_worker p 
  INNER JOIN mines m ON p.products_id = m.products_id 
  WHERE m.mine_name = name_mina;
  
  RETURN v_kilos;
END;

SELECT kilos_mina('Cameroon') AS kilos FROM dual;