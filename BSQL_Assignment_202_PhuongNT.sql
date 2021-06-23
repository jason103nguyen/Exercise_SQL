CREATE DATABASE BSQL_Assignment_202;

GO
USE BSQL_Assignment_202;

GO 
SET DATEFORMAT dmy;

--Q1:
--In the design for the Fresher Training Management, given the Trainee table with below initial attributes fields:
--TraineeID:  trainee identifier, auto-increment field
--Full_Name: full name of the trainee
--Birth_Date: trainee birth date
--Gender:  only have one of two value male, female
--ET_IQ: entry test point (IQ) of trainee, integer, value range from 0 to 20
--ET_Gmath: entry test point (GMath) of trainee, integer, value range from 0 to 20
--ET_English: entry test point (English) of trainee, integer, value range from 0 to 50
--Training_Class: the class code that trainee  is joining
--Evaluation_Notes:  trainee evaluation notes, free text.

CREATE TABLE Trainee (
	TraineeID smallint IDENTITY(1,1),
	Full_Name nvarchar(100),
	Birth_Date date,
	Gender nvarchar(10),
	ET_IQ tinyint,
	ET_Gmath tinyint, 
	ET_English tinyint,
	Training_Class char(4),
	Evaluation_Notes nvarchar(max),
	CONSTRAINT CHK_Gender CHECK (Gender='Male' or Gender='Female'),
	CONSTRAINT CHK_ET_IQ CHECK (ET_IQ BETWEEN 0 AND 20),
	CONSTRAINT CHK_ET_Gmath CHECK (ET_Gmath BETWEEN 0 AND 20),
	CONSTRAINT CHK_ET_English CHECK (ET_English BETWEEN 0 AND 50)
);

INSERT INTO Trainee VALUES 
('Nguyen Van An', '10/3/1996', 'Male', '10', '10', '25', 'CL01', 'None'),
('Tran Le Binh', '15/4/1996', 'Male', '12', '15', '30', 'CL01', 'None'),
('Nguyen Van Chu', '20/3/1996', 'Female', '14', '20', '35', 'CL01', 'None'),
('Tran Le Dung', '25/6/1996', 'Female', '16', '5', '40', 'CL01', 'None'),
('Nguyen Van Em', '30/4/1996', 'Male', '18', '7', '45', 'CL02', 'None'),
('Tran Van Phuoc', '10/8/1996', 'Male', '20', '9', '10', 'CL02', 'None'),
('Nguyen Gia', '15/9/1996', 'Female', '10', '11', '15', 'CL02', 'None'),
('Pham Van Hoang', '20/10/1996', 'Female', '12', '13', '20', 'CL02', 'None'),
('Hoang Pham Van Phuc', '25/8/1996', 'Male', '14', '17', '25', 'CL01', 'None'),
('Pham Van Khang', '30/8/1996', 'Male', '16', '19', '50', 'CL01', 'None');

--Q2:
--Change the table TRAINEE to add one more field named Fsoft_Account which is a not-null & unique field.
--ANG
GO
ALTER TABLE Trainee
ALTER COLUMN Full_Name nvarchar(100) NOT NULL;

GO
ALTER TABLE Trainee
ADD Fsoft_Account AS (
	'FSOFTER_' + RIGHT('000' + CAST(TraineeID AS varchar(10)), 3)
);

--Q3:
--Create a VIEW that includes all the ET-passed trainees. 
--One trainee is considered as ET-passed when he/she has the entry test points satisfied below criteria: 
--ET_IQ + ET_Gmath >=20
--ET_IQ>=8
--ET_Gmath>=8
--ET_English>=18​
GO
CREATE VIEW View_ET_Passed_Trainees AS
SELECT * FROM Trainee 
WHERE (ET_IQ + ET_Gmath >=20) AND (ET_IQ>=8) AND (ET_Gmath>=8) AND (ET_English>=18​);

--Q4:
--Query all the trainees who are passed the entry test
--Group them into different birth months
GO
SELECT * FROM View_ET_Passed_Trainees
ORDER BY Birth_Date;

--Q5:
--Query the trainee who has the longest name 
--Showing his/her age along with his/her basic information (as defined in the table)
GO
SELECT TOP 1 * FROM Trainee
ORDER BY LEN(Full_Name) DESC;
