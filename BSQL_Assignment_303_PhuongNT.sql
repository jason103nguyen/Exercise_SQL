CREATE DATABASE ASQL_Assignment_303_1
GO 

USE ASQL_Assignment_303_1
GO 

--1. Create the tables with the most appropriate/economic 
--field/column constraints & types. 
--Add at least 8 records into each created tables.

CREATE TABLE DEPARTMENT (
    DeptNo INT IDENTITY(1,1),
    DeptName NVARCHAR(100),
    Note NVARCHAR(MAX),
    CONSTRAINT PK_DEPARTMENT PRIMARY KEY (DeptNo)
)
GO 

CREATE TABLE SKILL (
    SkillNo INT IDENTITY(1,1),
    SkillName NVARCHAR(100),
    Note NVARCHAR(MAX),
    CONSTRAINT PK_SKILL PRIMARY KEY (SkillNo)
)
GO 

CREATE TABLE EMPLOYEE (
    EmpNo INT,
    EmpName NVARCHAR(50),
    BirthDay DATE,
    Email NVARCHAR(200),
    DeptNo INT,
    MgrNo INT NOT NULL DEFAULT 0,
    StartDate DATE,
    Salary MONEY,
    [Level] TINYINT,
    [Status] TINYINT,
    Note NVARCHAR(MAX),
    CONSTRAINT CHK_Status CHECK ([Status] BETWEEN 0 AND 2),
    CONSTRAINT CHK_Level CHECK ([Level] BETWEEN 1 AND 7),
    CONSTRAINT UNI_Email UNIQUE (Email),
    CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EmpNo),
    CONSTRAINT FK_EMPLOYEE_DEPARTMENT FOREIGN KEY (DeptNo) REFERENCES DEPARTMENT(DeptNo)
)
GO 

CREATE TABLE EMP_SKILL (
    SkillNo INT,
    EmpNo INT,
    SkillLevel TINYINT,
    RegDate DATE,
    [Description] NVARCHAR(MAX),
    CONSTRAINT PK_EMP_SKILL PRIMARY KEY (SkillNo, EmpNo),
    CONSTRAINT CHK_SkillLevel CHECK (SkillLevel BETWEEN 1 AND 3),
    CONSTRAINT FK_EMP_SKILL_EMPLOYEE FOREIGN KEY (EmpNo) REFERENCES EMPLOYEE(EmpNo),
    CONSTRAINT FK_EMP_SKILL_SKILL FOREIGN KEY (SkillNo) REFERENCES SKILL(SkillNo)
)
GO 

INSERT INTO DEPARTMENT VALUES 
(N'Bộ phận A', 'None'),
(N'Bộ phận B', 'None'),
(N'Bộ phận C', 'None'),
(N'Bộ phận D', 'None'),
(N'Bộ phận E', 'None'),
(N'Bộ phận F', 'None'),
(N'Bộ phận G', 'None'),
(N'Bộ phận H', 'None')
GO

INSERT INTO SKILL VALUES 
('C++', 'None'),
('C#', 'None'),
('Java', 'None'),
('Python', 'None'),
('C', 'None'),
('Embedded', 'None'),
('.NET', 'None'),
('Golang', 'None')
GO 

SET DATEFORMAT dmy 
GO 

INSERT INTO EMPLOYEE VALUES 
('1', N'Nguyễn Văn A', '10/3/1996', 'a103nguyen@gmail.com', '1', '1', '10/6/2021', '1000', '1', '0', 'None'),
('2', N'Nguyễn Văn B', '15/4/1995', 'b103nguyen@gmail.com', '1', '1', '15/6/2021', '1200', '1', '0', 'None'),
('3', N'Nguyễn Văn C', '20/5/1994', 'c103nguyen@gmail.com', '2', '2', '20/7/2020', '1200', '2', '1', 'None'),
('4', N'Nguyễn Văn D', '25/6/1993', 'd103nguyen@gmail.com', '2', '2', '25/7/2020', '1300', '2', '1', 'None'),
('5', N'Nguyễn Văn E', '22/7/1994', 'e103nguyen@gmail.com', '3', '3', '30/8/2019', '1400', '3', '2', 'None'),
('6', N'Nguyễn Văn F', '23/8/1993', 'f103nguyen@gmail.com', '3', '3', '05/8/2019', '1500', '3', '0', 'None'),
('7', N'Nguyễn Văn G', '24/9/1992', 'g103nguyen@gmail.com', '4', '4', '10/9/2018', '1600', '4', '0', 'None'),
('8', N'Nguyễn Văn H', '25/8/1991', 'h103nguyen@gmail.com', '5', '5', '12/1/2017', '2000', '5', '0', 'None')
GO 

--[SkillNo][EmpNo][SkillLevel:1-3][RegDate][Description]
INSERT INTO EMP_SKILL VALUES
('1', '1', '1', '30/6/2021', 'None'),
('2', '1', '1', '25/5/2021', 'None'),
('3', '2', '1', '20/4/2021', 'None'),
('4', '2', '1', '15/3/2021', 'None'),
('5', '2', '1', '10/1/2021', 'None'),
('6', '4', '1', '05/1/2021', 'None'),
('7', '5', '1', '02/6/2021', 'None'),
('8', '6', '1', '01/5/2021', 'None')
GO 

--2. Specify name, email and department name of 
--the employees that have been working at least six months.
SELECT e.EmpName, e.Email, DEPARTMENT.DeptName FROM EMPLOYEE e 
INNER JOIN DEPARTMENT ON DEPARTMENT.DeptNo = e.DeptNo
WHERE DATEDIFF(MONTH, e.StartDate, GETDATE()) >= 6

--3. Specify the names of the employees 
--whore have either ‘C++’ or ‘.NET’ skills.

SELECT e.EmpName FROM EMPLOYEE e
INNER JOIN EMP_SKILL ON EMP_SKILL.EmpNo = e.EmpNo
INNER JOIN SKILL ON SKILL.SkillNo = EMP_SKILL.SkillNo
WHERE SKILL.SkillName = 'C++' OR SKILL.SkillName = '.NET'
GO 

--4. List all employee names, manager names, 
--manager emails of those employees.

--5. Specify the departments which have >=2 employees, 
--print out the list of departments’ employees right after each department.
SELECT DEPARTMENT.DeptName, EMPLOYEE.EmpName FROM DEPARTMENT
INNER JOIN EMPLOYEE ON EMPLOYEE.DeptNo = DEPARTMENT.DeptNo
WHERE DEPARTMENT.DeptNo IN (
    SELECT EMPLOYEE.DeptNo FROM EMPLOYEE
    GROUP BY EMPLOYEE.DeptNo
    HAVING COUNT(EMPLOYEE.EmpName) >= 2
)
GO 

--6. List all name, email and skill number of the employees 
--and sort ascending order by employee’s name.
SELECT e.EmpName, e.Email, COUNT(es.SkillNo) AS Skill_Number FROM EMPLOYEE e
INNER JOIN EMP_SKILL es ON es.EmpNo = e.EmpNo
GROUP BY e.EmpName, e.Email
ORDER BY e.EmpName

--7. Use SUB-QUERY technique to list out the different employees 
--(include name, email, birthday) who are working and have 
--multiple skills.

SELECT e.EmpName, e.Email, e.BirthDay FROM EMPLOYEE e 
WHERE e.[Status] = '0' AND e.EmpNo IN (
    SELECT EMP_SKILL.EmpNo FROM EMP_SKILL
    GROUP BY EMP_SKILL.EmpNo
    HAVING COUNT(EMP_SKILL.SkillNo) >= 2
)
GO 

--8. Create a view to list all employees are working 
--(include: name of employee and skill name, department name)

CREATE VIEW vw_InfoEmployee AS
SELECT e.EmpName, s.SkillName, d.DeptName FROM EMPLOYEE e 
INNER JOIN DEPARTMENT d ON d.DeptNo = e.DeptNo
INNER JOIN EMP_SKILL es ON es.EmpNo = e.EmpNo
INNER JOIN SKILL s ON s.SkillNo = es.SkillNo
GO