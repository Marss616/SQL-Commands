-- SQL script to create tables and insert data for EMPLOYEE and DEPARTMENT

-- Create the EMPLOYEE table
CREATE TABLE EMPLOYEE (
    Employee_No VARCHAR(10),
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Dept_Number VARCHAR(10),
    Salary INT
);

-- Insert data into EMPLOYEE
INSERT INTO EMPLOYEE (Employee_No, First_Name, Last_Name, Dept_Number, Salary) VALUES
('E1', 'Mandy', 'Smith', 'D1', 50000),
('E2', 'Daniel', 'Hodges', 'D2', 45000),
('E3', 'Shaskia', 'Ramanthan', 'D2', 58000),
('E4', 'Graham', 'Burke', 'D1', 64000),
('E5', 'Annie', 'Nguyen', 'D1', 60000);

-- Create the DEPARTMENT table
CREATE TABLE DEPARTMENT (
    Dept_Number VARCHAR(10),
    Dept_Name VARCHAR(50),
    Location VARCHAR(50),
    Mail_Number INT
);

-- Insert data into DEPARTMENT
INSERT INTO DEPARTMENT (Dept_Number, Dept_Name, Location, Mail_Number) VALUES
('D1', 'Computer Science', 'Bundoora', 39),
('D2', 'Information Science', 'Bendigo', 30),
('D3', 'Physics', 'Bundoora', 37),
('D4', 'Chemistry', 'Bendigo', 35);
