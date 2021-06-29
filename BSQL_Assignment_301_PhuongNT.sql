CREATE DATABASE ASQL_Assignment_301_8
GO 

USE ASQL_Assignment_301_8
GO 

-- Create table Employee, Status = 1: are working
CREATE TABLE [dbo].[Employee](
	[EmpNo] [int] NOT NULL
,	[EmpName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[BirthDay] [datetime] NOT NULL
,	[DeptNo] [int] NOT NULL
, 	[MgrNo] [int]
,	[StartDate] [datetime] NOT NULL
,	[Salary] [money] NOT NULL
,	[Status] [int] NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
,	[Level] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE Employee 
ADD CONSTRAINT PK_Emp PRIMARY KEY (EmpNo)
GO

ALTER TABLE [dbo].[Employee]  
ADD CONSTRAINT [chk_Level] 
	CHECK  (([Level]=(7) OR [Level]=(6) OR [Level]=(5) OR [Level]=(4) OR [Level]=(3) OR [Level]=(2) OR [Level]=(1)))
GO

ALTER TABLE [dbo].[Employee]  
ADD CONSTRAINT [chk_Status] 
	CHECK  (([Status]=(2) OR [Status]=(1) OR [Status]=(0)))
GO

ALTER TABLE [dbo].[Employee]
ADD Email NCHAR(30) 
GO

ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT chk_Email CHECK (Email IS NOT NULL)
GO

ALTER TABLE [dbo].[Employee] 
ADD CONSTRAINT chk_Email1 UNIQUE(Email)
GO

ALTER TABLE Employee
ADD CONSTRAINT DF_EmpNo DEFAULT 0 FOR EmpNo
GO

ALTER TABLE Employee
ADD CONSTRAINT DF_Status DEFAULT 0 FOR Status
GO

CREATE TABLE [dbo].[Skill](
	[SkillNo] [int] IDENTITY(1,1) NOT NULL
,	[SkillName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

ALTER TABLE Skill
ADD CONSTRAINT PK_Skill PRIMARY KEY (SkillNo)
GO

CREATE TABLE [dbo].[Department](
	[DeptNo] [int] IDENTITY(1,1) NOT NULL
,	[DeptName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

ALTER TABLE Department
ADD CONSTRAINT PK_Dept PRIMARY KEY (DeptNo)
GO

CREATE TABLE [dbo].[Emp_Skill](
	[SkillNo] [int] NOT NULL
,	[EmpNo] [int] NOT NULL
,	[SkillLevel] [int] NOT NULL
,	[RegDate] [datetime] NOT NULL
,	[Description] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO

ALTER TABLE Emp_Skill
ADD CONSTRAINT PK_Emp_Skill PRIMARY KEY (SkillNo, EmpNo)
GO

ALTER TABLE Employee  
ADD CONSTRAINT [FK_1] FOREIGN KEY([DeptNo])
REFERENCES Department (DeptNo)
GO

ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_2] FOREIGN KEY ([EmpNo])
REFERENCES Employee([EmpNo])
GO

ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_3] FOREIGN KEY ([SkillNo])
REFERENCES Skill([SkillNo])
GO

--Write SQL statements for following activities & print out respectively 
--the screenshots to show test data (the table data that you create to test each query) & query results:
--1. Add at least 8 records into each created tables.

ALTER TABLE [dbo].[Employee]
ALTER COLUMN [EmpName] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
GO

SET DATEFORMAT dmy
GO

INSERT INTO [dbo].[Skill] VALUES 
('C++', 'None'),
('.NET', 'None'),
('JAVA', 'None'),
('PYTHON', 'None'),
('C#', 'None'),
('SQL', 'None'),
('C', 'None'),
('EMBEDDED', 'None')
GO 

INSERT INTO [dbo].[Department] VALUES 
('A', 'None'),
('B', 'None'),
('C', 'None')
GO

INSERT INTO [dbo].[Employee] VALUES 
('1', 'Nguyen Van A', '10/3/1996', '1', '1', '28/6/2021', '1000', '1', 'None', '3', 'a103nguyen@gmail.com'),
('2', 'Nguyen Van B', '10/4/1996', '2', '1', '28/5/2021', '1000', '0', 'None', '3', 'b103nguyen@gmail.com'),
('3', 'Nguyen Van C', '10/5/1996', '2', '2', '28/4/2020', '1100', '1', 'None', '4', 'c103nguyen@gmail.com'),
('4', 'Nguyen Van D', '10/6/1996', '2', '2', '28/3/2020', '1100', '0', 'None', '4', 'd103nguyen@gmail.com'),
('5', 'Nguyen Van E', '10/7/1996', '3', '3', '28/2/2019', '1200', '1', 'None', '5', 'e103nguyen@gmail.com'),
('6', 'Nguyen Van F', '10/8/1996', '3', '3', '28/1/2019', '1200', '0', 'None', '5', 'f103nguyen@gmail.com'),
('7', 'Nguyen Van G', '10/9/1996', '3', '3', '28/9/2018', '1300', '1', 'None', '6', 'g103nguyen@gmail.com'),
('8', 'Nguyen Van H', '10/2/1996', '3', '3', '28/8/2018', '1300', '0', 'None', '6', 'h103nguyen@gmail.com')
GO

ALTER TABLE [dbo].[Emp_Skill] 
ALTER COLUMN [Description] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

INSERT INTO [dbo].[Emp_Skill] VALUES 
('1', '1', '1', '28/6/2021', 'None'),
('2', '1', '1', '28/6/2021', 'None'),
('3', '2', '1', '27/6/2021', 'None'),
('4', '2', '2', '27/6/2021', 'None'),
('5', '3', '2', '26/6/2021', 'None'),
('6', '3', '2', '26/6/2021', 'None'),
('7', '4', '3', '25/6/2021', 'None'),
('8', '4', '3', '25/6/2021', 'None'),
('1', '5', '1', '28/6/2021', 'None'),
('2', '6', '1', '28/6/2021', 'None'),
('3', '7', '1', '27/6/2021', 'None'),
('4', '8', '2', '27/6/2021', 'None'),
('5', '7', '2', '26/6/2021', 'None'),
('6', '6', '2', '26/6/2021', 'None'),
('7', '5', '3', '25/6/2021', 'None')
GO

--2. Specify the name, email and department name of the employees 
--that have been working at least six months.
SELECT Employee.EmpName, Employee.Email, Employee.DeptNo, DATEDIFF(month, Employee.StartDate, GETDATE()) FROM Employee
WHERE DATEDIFF(month, Employee.StartDate, GETDATE()) >= 6
GO

--3. Specify the names of the employees whore have either ‘C++’ or ‘.NET’ skills.
SELECT Employee.EmpName FROM Skill 
FULL JOIN Emp_Skill ON Emp_Skill.SkillNo = Skill.SkillNo
FULL JOIN Employee ON Employee.EmpNo = Emp_Skill.EmpNo
WHERE Skill.SkillName = 'C++' OR Skill.SkillName = '.NET'
GO

--4. List all employee names, manager names, manager emails of those employees

--5. Specify the departments which have >=2 employees, 
--print out the list of departments’ employees right after each department.
SELECT e.DeptNo, e.EmpName FROM Employee e
WHERE e.DeptNo IN (
	SELECT e.DeptNo FROM Employee e
	GROUP BY e.DeptNo
	HAVING COUNT(e.EmpNo) >= 2
)
GO 

--6. List all name, email and number of skills of the employees 
--and sort ascending order by employee’s name.
SELECT e.EmpName, e.Email, COUNT(es.SkillNo) AS Number_Skill FROM Employee e
INNER JOIN Emp_Skill es ON es.EmpNo = e.EmpNo
GROUP BY e.EmpName, e.Email
ORDER BY e.EmpName
GO 

--7. Use SUB-QUERY technique to list out the different employees (include name, email, birthday) 
--who are working and have multiple skills.
SELECT e.EmpName, e.Email, e.BirthDay FROM Employee e
WHERE e.EmpNo IN (
	SELECT e2.EmpNo FROM Employee e2
	INNER JOIN Emp_Skill es ON es.EmpNo = e2.EmpNo
	INNER JOIN Skill s ON s.SkillNo = es.SkillNo
	GROUP BY e2.EmpNo, e2.[Status]
	HAVING e2.[Status] = '1' AND COUNT(s.SkillName) >= 2
)
GO

--8. Create a view to list all employees are working 
--(include: name of employee and skill name, department name).
CREATE VIEW vw_InfoEmployee AS
SELECT e.EmpName, s.SkillName, d.DeptName FROM Employee e
INNER JOIN Emp_Skill es ON es.EmpNo = e.EmpNo
INNER JOIN Department d on d.DeptNo = e.DeptNo
INNER JOIN Skill s ON s.SkillNo = es.SkillNo
GO