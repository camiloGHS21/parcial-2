CREATE TABLE product_worker(
product_worker_id NUMBER PRIMARY KEY ,
products_id NUMBER NOT NULL,
FOREIGN KEY (products_id) REFERENCES products(products_id),
persons_id NUMBER NOT NULL,
FOREIGN KEY (persons_id) REFERENCES persons(persons_id),
kg_product NUMBER NOT NULL
);