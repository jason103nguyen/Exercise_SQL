CREATE DATABASE BSQL_Assignment_201;

GO
USE BSQL_Assignment_201;

GO
SET DATEFORMAT dmy;

--Q1.1:
--Table EMPLOYEE
--EmpNo: employee code, primary key.
--EmpName: employee name.
--BirthDay: birthday of the employee.
--DeptNo: department code of the employee.
--MgrNo: manager code, not null.
--StartDate: starting date of work.
--Salary: salary of the employee, data type is money (VND).
--Level: level of the employee (accepts value range from 1 to 7 only).
--Status: status of the employee (0: working, 1: unpaid leave, 2: out)
--Note: some note about an employee, free text.

GO
CREATE TABLE EMPLOYEE (
	EmpNo smallint,
	EmpName nvarchar(100),
	BirthDay date,
	DeptNo smallint,
	MgrNo smallint NOT NULL,
	StartDate date,
	Salary money,
	[Level] tinyint,
	[Status] tinyint,
	Note nvarchar(max),
	CONSTRAINT PK_EmpNo PRIMARY KEY (EmpNo),
	CONSTRAINT CHK_Level CHECK ([Level] BETWEEN 1 AND 7),
	CONSTRAINT CHK_Status CHECK ([Status] BETWEEN 0 AND 2)
);

--Q1.2
--Table SKILL:
--SkillNo: skill code, primary key, auto-increment.
--SkillName: name of skill.
--Note: some note about skill, free text.

GO
CREATE TABLE SKILL (
	SkillNo smallint IDENTITY(1,1),
	SkillName nvarchar(100),
	Note nvarchar(max),
	CONSTRAINT PK_SkillNo PRIMARY KEY (SkillNo)
);

--Q1.3:
--Table DEPARTMENT:
--DeptNo: department code, primary key, auto-increment.
--DeptName: department name.
--Note: some note about department, free text.
GO
CREATE TABLE DEPARTMENT (
	DeptNo smallint IDENTITY(1,1),
	DeptName nvarchar(100),
	Note nvarchar(max),
	CONSTRAINT PK_DeptNo PRIMARY KEY (DeptNo)
);

--Q1.4:
--Table EMP_SKILL:
--SkillNo: skill code, foreign key.
--EmpNo: employee code, foreign key.
--SkillLevel: skill level of the employee (accepts value range from 1 to 3 only).
--RegDate: registration date.
--Description: skill description, free text.
--Primary key (SkillNo, EmpNo)

GO
CREATE TABLE EMP_SKILL (
	 SkillNo smallint,
	 EmpNo smallint,
	 SkillLevel tinyint,
	 RegDate date,
	 [Description] nvarchar(max), 
	 CONSTRAINT FK_SkillNo FOREIGN KEY (SkillNo) REFERENCES SKILL(SkillNo),
	 CONSTRAINT FK_EmpNo FOREIGN KEY (EmpNo) REFERENCES EMPLOYEE(EmpNo),
	 CONSTRAINT CHK_SkillLevel CHECK (SkillLevel BETWEEN 1 AND 3),
	 CONSTRAINT PK_SkillNo_EmpNo PRIMARY KEY (SkillNo, EmpNo)
);

--Q2.1:
--Add an Email field to EMPLOYEE table 
--And make sure that the database will not allow the value for Email to be inserted into a new row if that value has already been used in another row.
GO
ALTER TABLE EMPLOYEE
ADD Email nvarchar(100) ;

--Q2.2:
--Modify EMPLOYEE table to set default values to 0 of MgrNo and Status fields.
GO
ALTER TABLE EMPLOYEE
ADD CONSTRAINT DF_MgrNo DEFAULT 0 FOR MgrNo;

GO
ALTER TABLE EMPLOYEE
ADD CONSTRAINT DF_Status DEFAULT 0 FOR [Status];

--Q3.1:
--Add the FOREIGN KEY constrain of DeptNo field to the EMPLOYEE table that will relate the DEPARTMENT table
GO
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_DeptNo FOREIGN KEY (DeptNo) REFERENCES DEPARTMENT(DeptNo);

--Q3.2:
--Remove the Description field from the EMP_SKILL table.
GO
ALTER TABLE EMP_SKILL
DROP COLUMN [Description];

--Q4.1:
--Add at least 5 records into each of the created tables
GO
INSERT INTO DEPARTMENT VALUES 
('Project_1', 'None'),
('Project_2', 'None'),
('Project_3', 'None'),
('Project_4', 'None'),
('Project_5', 'None');

GO
INSERT INTO SKILL VALUES 
('Skill_1', 'None'),
('Skill_2', 'None'),
('Skill_3', 'None'),
('Skill_4', 'None'),
('Skill_5', 'None');

GO
INSERT INTO EMPLOYEE VALUES
('1', 'Nguyen Van A', '10/3/1996', '1', '1', '17/6/2021', '10000000', '3', '0', 'None', 'nguyenvana@gmail.com'),
('2', 'Nguyen Van B', '15/4/1996', '2', '2', '10/5/2021', '12000000', '4', '0', 'None', 'nguyenvanb@gmail.com'),
('3', 'Nguyen Van C', '1/5/1996', '3', '3', '5/4/2021', '14000000', '5', '0', 'None', 'nguyenvanc@gmail.com'),
('4', 'Nguyen Van D', '5/6/1996', '4', '4', '1/3/2021', '16000000', '6', '0', 'None', 'nguyenvand@gmail.com'),
('5', 'Nguyen Van E', '10/7/1996', '5', '5', '25/2/2021', '18000000', '7', '0', 'None', 'nguyenvane@gmail.com');

--Q4.2
--Create a VIEW called EMPLOYEE_TRACKING that will appear to the user as EmpNo, Emp_Name and Level. 
--It has Level satisfied the criteria: Level >=3 and Level <= 5.
GO
CREATE VIEW EMPLOYEE_TRACKING AS  
SELECT EmpNo, EmpName, [Level] FROM EMPLOYEE
WHERE Level BETWEEN 3 AND 5;