CREATE TABLE workers(
workers_id NUMBER PRIMARY KEY ,
mines_id NUMBER NOT NULL,
FOREIGN KEY (mines_id) REFERENCES mines(mines_id),
persons_id NUMBER NOT NULL,
FOREIGN KEY (persons_id) REFERENCES persons(persons_id),
ingressDate DATE NOT NULL
);