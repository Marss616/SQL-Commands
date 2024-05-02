CREATE TABLE EMPLOYEE
(EmployeeNumb		VARCHAR2(2)	NOT NULL,
FirstName	        VARCHAR2(50),
LastName	        VARCHAR2(50),
DeptNumb	        VARCHAR2(30),
Salary		        Number(6),

PRIMARY KEY (EmployeeNumb));

CREATE TABLE DEPARTMENT
(DeptNumb		VARCHAR2(2)	NOT NULL,
DeptName	        VARCHAR2(50),
Location	        VARCHAR2(50),
MailNumb	        Number(2),
	        

PRIMARY KEY (DeptNumb));