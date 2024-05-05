CREATE TABLE persons_defuntions(
persons_defuntions_id NUMBER PRIMARY KEY ,
date DATE NOT NULL,
persons_id NUMBER NOT NULL,
FOREIGN KEY (persons_id) REFERENCES persons(persons_id),
deaths_id NUMBER NOT NULL,
FOREIGN KEY (deaths_id) REFERENCES deaths(deaths_id)
);