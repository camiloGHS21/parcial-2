CREATE TABLE mines(
mines_id NUMBER PRIMARY KEY ,
mine_name VARCHAR2(50) NOT NULL,
product_id NUMBER NOT NULL,
FOREIGN KEY (product_id) REFERENCES products(products_id)
);
