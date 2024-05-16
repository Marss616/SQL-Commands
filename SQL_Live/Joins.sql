-- show tables in the database / SQL LIVE / 9/5/2024
SELECT username
FROM all_users;
-- Create Employee table

CREATE TABLE EMPLOYEE (
    Employee_No VARCHAR(10),
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Dept_Number VARCHAR(10),
    Salary INT
);
-- add data to the EMployee table
INSERT INTO EMPLOYEE (Employee_No, First_Name, Last_Name, Dept_Number, Salary) VALUES ('E1', 'Mandy', 'Smith', 'D1', 50000);
INSERT INTO EMPLOYEE (Employee_No, First_Name, Last_Name, Dept_Number, Salary) VALUES ('E2', 'Daniel', 'Hodges', 'D2', 45000);
INSERT INTO EMPLOYEE (Employee_No, First_Name, Last_Name, Dept_Number, Salary) VALUES ('E3', 'Shaskia', 'Ramanthan', 'D2', 58000);
INSERT INTO EMPLOYEE (Employee_No, First_Name, Last_Name, Dept_Number, Salary) VALUES ('E4', 'Graham', 'Burke', 'D1', 64000);
INSERT INTO EMPLOYEE (Employee_No, First_Name, Last_Name, Dept_Number, Salary) VALUES ('E5', 'Annie', 'Nguyen', 'D1', 60000);
-- show the data in EMPLOYEE table
SELECT *
FROM EMPLOYEE;
-- create the DEPARTMENT table
CREATE TABLE DEPARTMENT (
    Dept_Number VARCHAR(10),
    Dept_Name VARCHAR(50),
    Location VARCHAR(50),
    Mail_Number INT
);
-- add the data to the DEPARTMENT table
INSERT INTO DEPARTMENT (Dept_Number, Dept_Name, Location, Mail_Number) VALUES ('D1', 'Computer Science', 'Bundoora', 39);
INSERT INTO DEPARTMENT (Dept_Number, Dept_Name, Location, Mail_Number) VALUES ('D2', 'Information Science', 'Bendigo', 30);
INSERT INTO DEPARTMENT (Dept_Number, Dept_Name, Location, Mail_Number) VALUES ('D3', 'Physics', 'Bundoora', 37);
INSERT INTO DEPARTMENT (Dept_Number, Dept_Name, Location, Mail_Number) VALUES ('D4', 'Chemistry', 'Bendigo', 35);
-- show the data in the DEPARTMENT table
SELECT *
FROM DEPARTMENT;
-- create the Projects table
CREATE TABLE PROJECTS (
    Project_Number INT,
    Project_Name VARCHAR(30)
);
-- add data to the PROJECTS table
INSERT INTO PROJECTS (Project_Number, Project_Name) VALUES (1, 'Project A');
INSERT INTO PROJECTS (Project_Number, Project_Name) VALUES (2, 'Project B');
INSERT INTO PROJECTS (Project_Number, Project_Name) VALUES (3, 'Project C');
INSERT INTO PROJECTS (Project_Number, Project_Name) VALUES (4, 'Project D');
INSERT INTO PROJECTS (Project_Number, Project_Name) VALUES (5, 'Project E');
-- show data to the PROJECTS table
SELECT *
FROM PROJECTS;
-- create the WORKS_ON table
CREATE TABLE WORKS_ON (
    EMPLOYEE_NO VARCHAR(10),
    PROJECT_NUMBER INT
);
-- add data to the WORKS_ON table
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E1', 1);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E2', 1);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E3', 2);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E4', 3);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E5', 3);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E1', 4);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E2', 4);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E3', 5);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E4', 5);
INSERT INTO WORKS_ON (EMPLOYEE_NO, PROJECT_NUMBER) VALUES ('E5', 5);
-- show the comleted table table
SELECT *
FROM WORKS_ON;
--to make a three table join
SELECT H.staffID, H.flightID, COUNT(T.ticketNum) AS numTickets
FROM HOSTING H
JOIN FLIGHT F ON H.flightID = F.flightID
JOIN TICKET T ON F.flightID = T.flightID
GROUP BY H.staffID, H.flightID;








