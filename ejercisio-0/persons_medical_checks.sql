CREATE TABLE persons_medical_checks(
persons_medical_checks_id NUMBER PRIMARY KEY ,
persons_id NUMBER NOT NULL,
FOREIGN KEY (persons_id) REFERENCES persons(persons_id),
diagnosis_id NUMBER NOT NULL,
FOREIGN KEY (diagnosis_id) REFERENCES diagnosis(diagnosis_id)
);