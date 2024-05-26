CREATE TABLE courses (
    course VARCHAR2(70),
    department VARCHAR2(50),
    currentStudents NUMBER(3),
    maxStudents NUMBER(3) NOT NULL,
    PRIMARY KEY (course)
);

INSERT INTO courses VALUES ('BIT', 'CSCE', 150, 200);
INSERT INTO courses VALUES ('CIS', 'CSCE', 182, 150);
INSERT INTO courses VALUES ('MATH', 'CSCE', 50, 90);
INSERT INTO courses VALUES ('PHYS', 'PHYS', 30, 50);
INSERT INTO courses VALUES ('CHEM', 'CHEM', 20, 40);


