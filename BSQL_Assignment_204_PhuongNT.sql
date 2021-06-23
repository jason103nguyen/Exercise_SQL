CREATE DATABASE BSQL_Assignment_204;

GO
USE BSQL_Assignment_204;

--Q1.1
--Create a table called Movie to store information about movies. 
--Add columns in your table for:
-->Movie name
-->Duration
-->Genre
-->Director
-->Amount of money made at the box office 
-->Comments.
--Make sure one of your columns works as a PRIMARY KEY.
--Genre: accepts value range from 1 to 8 only (1: Action, 2: Adventure, 3: Comedy, 4: Crime (gangster), 5: Dramas, 6: Horror, 7: Musical/dance, 8: War)
--Duration: must be greater than or equal 1 hours
GO
CREATE TABLE Movie (
	MovieID char(4),
	MovieName nvarchar(100), 
	Duration time, 
	Genre nvarchar(100), 
	Director nvarchar(100), 
	AmountMoney money,
	Comments nvarchar(max),
	CONSTRAINT PK_MovieID PRIMARY KEY (MovieID),
	CONSTRAINT CHK_Genre CHECK (Genre = 'Action' or Genre = 'Adventure' or Genre = 'Comedy' or Genre = 'Crime (Gangster)' or Genre = 'Dramas' or Genre = 'Horror' or Genre = 'Musical/Dance' or Genre = 'War'),
	CONSTRAINT CHK_Duration CHECK (Duration >= '1:00:00')
);

--Q1.2
--Create another table called Actor to store information about actors. 
--Just like you did with Movie, add several columns to store actor data for the actor's:
-->Name
-->Age
-->Average movie salary
-->Nationality
--Again, make sure there is a PRIMARY KEY in your table.

GO
CREATE TABLE Actor (
	ActorID char(4),
	ActorName nvarchar(100), 
	ActorAge nvarchar(100), 
	AverageMovieSalary money,
	Nationality nvarchar(100),
	CONSTRAINT PK_ActorID PRIMARY KEY (ActorID)
);

--Q1.3
--Create a final table called ActedIn to store information about which movies certain actors have acted in. 
--Think carefully about what the columns of this table should be. 
--This table should make use of FOREIGN KEYS.
GO
CREATE TABLE ActedIn (
	MovieID char(4),
	ActorID char(4),
	CONSTRAINT PK_MovieID_ActorID PRIMARY KEY (MovieID, ActorID),
	CONSTRAINT FK_MovieID FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
	CONSTRAINT FK_ActorID FOREIGN KEY (ActorID) REFERENCES Actor(ActorID)
);

--Q2.1
--Add an ImageLink field to Movie table 
--And make sure that the database will not allow the value for ImageLink to be inserted into a new row if that value has already been used in another row.
GO
ALTER TABLE Movie
ADD ImageLink nvarchar(2048);

GO
ALTER TABLE Movie
ADD CONSTRAINT UNI_ImageLink UNIQUE (ImageLink);

--Q2.2
--Populate your tables with some data using the INSERT statement. 
--Make sure you have at least 5 tuples per table.
GO
INSERT INTO Movie VALUES 
('1', 'Movie A', '2:30:00','Action', 'Nguyen A', '1000000', 'A good movie', 'www.moviea.com/picturea'),
('2', 'Movie B', '1:30:00', 'Adventure', 'Nguyen B', '2000000', 'A good movie', 'www.movieb.com/pictureb'),
('3', 'Movie C', '1:45:00', 'Comedy', 'Nguyen C', '3000000', 'A good movie', 'www.moviec.com/picturec'),
('4', 'Movie D', '2:00:00', 'Crime (Gangster)', 'Nguyen D', '4000000', 'A good movie', 'www.movied.com/pictured'),
('5', 'Movie E', '2:15:00', 'Dramas', 'Nguyen E', '5000000', 'A good movie', 'www.moviee.com/picturee');

GO 
INSERT INTO Actor VALUES
('1', 'Tran A', '25', '500', 'Viet Nam'),
('2', 'Tran B', '30', '600', 'USA'),
('3', 'Tran C', '40', '1000', 'UK'),
('4', 'Tran D', '50', '1200', 'Japan'),
('5', 'Tran E', '60', '2000', 'Korea');

GO
INSERT INTO ActedIn VALUES
('1', '1'),
('1', '2'),
('1', '3'),
('1', '4'),
('1', '5'),
('2', '2'),
('2', '3'),
('3', '3'),
('3', '4'),
('3', '5'),
('4', '4'),
('5', '5'),
('5', '3'),
('5', '4');

--You accidentally mistyped one of the actors' names. 
--Fix your typo by using an UPDATE statement.
GO
UPDATE Movie SET Director = 'Nguyen AA' WHERE MovieID = '1';

--Q3.1
--Write a query to retrieve all the data in the Actor table for actors that are older than 50.
GO
SELECT * FROM Actor
WHERE ActorAge > 50;

--Q3.2
--Write a query to retrieve all actor names 
--And average salaries 
--From ACTOR 
--And sort the results by average salary.
GO
SELECT ActorName, AverageMovieSalary FROM Actor
ORDER BY AverageMovieSalary;

--Q3.3
--Using an actor name from your table, 
--Write a query to retrieve the names of all the movies that the actor has acted in.
GO
SELECT MovieName FROM Movie
WHERE MovieID IN (
	SELECT MovieID FROM ActedIn
	WHERE ActorID = ( SELECT ActorID FROM Actor WHERE ActorName = 'Tran B' )
);

--Q3.4*
--Write a query to retrieve the names of all the action movies 
--That amount of actor be greater than 3
GO
SELECT MovieID, COUNT(ActorID) AS NumActor FROM ActedIn
GROUP BY MovieID;
--Test
--Liệt kê các bộ phim có 3 diễn viên tham gia trở lên