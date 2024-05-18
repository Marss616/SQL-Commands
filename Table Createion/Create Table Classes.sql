CREATE TABLE cources
 (course VARCHAR2(70),
 department VARCHAR2(50),
 currentStudents NUMBER(3)
 maxStudents NUMBER(3) NOT NULL,
PRIMARY KEY (course)
);

Add data into the cources:

INSERT INTO cources
 (course, department, currentStudents, maxStudents)
VALUES
 ('BIT', 'CSCE', 180, 200)
 ('CIS', 'CSCE', 150, 200)
 ('CSC', 'CSCE', 190, 200)
 ('CSE', 'CSCE', 200, 200)
 ('CSM', 'CSCE', 180, 150)
 ('CSW', 'CSCE', 190, 20)
 ('CST', 'CSCE', 200, 50)