create database sample_database
use sample_database
drop database sample_database

--SHOW DATABASES

--BACKUP DATABASE sample_database
--TO DISK = 'C:\Users\smdsh\Desktop\New folder\Backup.bak';

--BACKUP DATABASE sample_database
--TO DISK = 'C:\Users\smdsh\Desktop\New folder\Backup.bak';
--WITH DIFFERENTIAL;

CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    CityAddress varchar(255),
    City varchar(255)
);

INSERT INTO Persons VALUES (1,'Shaik', 'Shoaib','Kurnool','M','518006' )

INSERT INTO Persons(FirstName, Age) VALUES ('Santosh', 10)

--Create Table PersonsCopy AS
--SELECT PersonID, City
--FROM Persons;

SELECT * FROM Persons

SELECT FirstName,Initial
FROM Persons

--DROP Table Persons

--Remove data from table
TRUNCATE TABLE Persons;

--Adding column into table
ALTER TABLE Persons
ADD Gender varchar

ALTER TABLE Persons
ADD City varchar(255)

ALTER TABLE PERSONS
ADD Age INT

--Drop column from table
ALTER TABLE Persons
DROP COLUMN City

--ALTER TABLE persons DROP COLUMN 
--Rename column
EXEC sp_rename 'Persons.Address', 'CityAddress', 'COLUMN'
EXEC sp_rename 'Persons.City', 'Pincode', 'COLUMN'

--change datatype of column
ALTER TABLE Persons
ALTER COLUMN column_name datatype;

--update values of field
UPDATE Persons
SET Age = 30
WHERE FirstName = 'Anil'

--Setting primary after a table's creation


--
DELETE FROM Persons WHERE FirstName = 'Sebastian'



--new table

create table Details (user_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, user_name varchar(50) NOT NULL, user_age VARCHAR(50) NOT NULL);
SELECT * FROM Details

INSERT INTO Details(user_name,user_age) VALUES('Shoaib',24)