--List all databses in the server
SELECT * FROM sys.databases

--Comprehensive list of all objects in the current database, regardless of their type.
SELECT * FROM sys.all_objects

--List all the tables in current database
SELECT * FROM sys.tables

--using database named LocalDB 
USE LocalDB

--List all Tables in current databse using SQL Server
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

--List all Tables in a specific database databse
SELECT TABLE_NAME
FROM LocalDB.INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
-------------------------------------------------------------
--Some of The Most Important SQL Commands
--SELECT - extracts data from a database
--UPDATE - updates data in a database
--DELETE - deletes data from a database
--INSERT INTO - inserts new data into a database
--CREATE DATABASE - creates a new database
--ALTER DATABASE - modifies a database
--CREATE TABLE - creates a new table
--ALTER TABLE - modifies a table
--DROP TABLE - deletes a table
--CREATE INDEX - creates an index (search key)
--DROP INDEX - deletes an index
-------------------------------------------------------------

--*****Data Definition Language*****

--Creating a table
CREATE TABLE Customers
(
	customerID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	customerName VARCHAR(50) NOT NULL,
	registeredDate DATE NOT NULL,	
	isRegular BIT NOT NULL
)

--Add age column | Adding single column
ALTER TABLE Customers
ADD age INT

--Add phoneNumer and email column | Adding multiple columns
ALTER TABLE Customers
ADD phoneNumber INT, email VARCHAR(50)

--Delete phoneNumber, age, email Columns
ALTER TABLE Customers
DROP COLUMN age, phoneNumber, email;

--Rename column
EXEC sp_rename 'table_name.old_name',  'new_name', 'COLUMN'; --syntax

EXEC sp_rename 'Customers.isRegular',  'regular', 'COLUMN'

EXEC sp_rename 'Customers.regular',  'isRegular', 'COLUMN'

EXEC sp_rename 'Customers.CustomerName', 'customerName', 'COLUMN'

--Adding UNIQUE Constraint
ALTER TABLE Customers
ADD CONSTRAINT UQ_customerName UNIQUE (customerName);

--Delete UNIQUE Constraint
ALTER TABLE Customers
DROP CONSTRAINT UQ_customerName

--Delete a table
DROP TABLE Customers;

--*****Data Manipulation Language*****

--Display the table
SELECT * FROM Customers;

--Adding a record (row) into table | INSERT INTO
INSERT INTO Customers(customerName, registeredDate, isRegular)
VALUES ('Ana', '01-05-1995', 0),
	('Jane', '2000-12-29', 1);

UPDATE Customers
SET registeredDate = '2005-05-27' Where customerID=1

--Delete a row (Record) from table
DELETE FROM Customers WHERE customerID = 2 AND customerID = 4;
--or 
DELETE FROM Customers WHERE customerID IN (2,4);

--Checking if a column with constraints can be dropped
--It can be dropped
ALTER TABLE Customers
Add SampleColumn INT

UPDATE Customers
SET Samplecolumn = 100 Where customerID=1

UPDATE Customers
SET Samplecolumn = 200 Where customerID=3

UPDATE Customers
SET Samplecolumn = 500 Where customerID=5

ALTER TABLE Customers
Drop column samplecolumn 

ALTER TABLE Customers
ADD CONSTRAINT UQ_SampleColumn UNIQUE (SampleColumn)

ALTER TABLE Customers
DROP CONSTRAINT SampleColumn
-----
--*****Modifying constraints*****
create table employees
(
	id int PRIMARY Key Identity(1,1),
	emp_name varchar(50),
	salary int check (15000<salary and salary < 30000),
	date_of_joining date
)

drop table employees

--Adding NOT NUll constraint--ddl
alter table employees
alter column id int NOT NULL

--Adding primary key constraint later on
ALTER TABLE employees
ADD CONSTRAINT PK_employees PRIMARY KEY (id);

--Dropping primary key constraint
alter table Employees
drop constraint pk_employees

--An inline constraint can be dropped if it's name is known, here the name was accessed by 
alter table Employees
drop constraint PK__employee__3213E83F9936E7A9

--dropping a clumn
alter table employees
drop column id

--Identity is a property, which needs to be added while table creation it self
--and can't be added to an existing column later on,
--but can be added to a new column which is being added to the table
ALTER TABLE employees
Add id INT IDENTITY(1,1);

--Adding a column later on with primary key and identity property
ALTER TABLE employees
ADD id INT IDENTITY(1,1) PRIMARY KEY;

--insert 
Insert into Employees Values ('Alice', 25000, '2024-02-24')



--Display the table
SELECT * FROM Customers;

--Display the table
SELECT * FROM employees