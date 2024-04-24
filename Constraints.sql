select * from sys.tables;

--Display the table
SELECT * FROM Customers;

--Display the table
SELECT * FROM employees

--Adding UNIQUE Constraint
ALTER TABLE Customers
ADD CONSTRAINT UQ_customerName UNIQUE (customerName);

--Delete UNIQUE Constraint
ALTER TABLE Customers
DROP CONSTRAINT UQ_customerName

--Delete a table
DROP TABLE Customers;

--Checking if a column with constraints can be dropped
--It can be dropped ofter dropping it's respective constraint
ALTER TABLE Customers
Add SampleColumn INT

Insert into customers values ('First Customer','2024-04-24',0,1)

--adding unique constraint
ALTER TABLE Customers
ADD CONSTRAINT UQ_SampleColumn UNIQUE (SampleColumn)

--column can't be dropped as a constraint is dependent on it
ALTER TABLE Customers
Drop column samplecolumn

--so, drop constraint first
ALTER TABLE Customers
DROP CONSTRAINT UQ_SampleColumn

--and then drop the column
ALTER TABLE Customers
Drop column samplecolumn

--Primary key
create table employees
(
	id int PRIMARY Key Identity(1,1),
	emp_name varchar(50),
	salary int check (15000<salary and salary < 30000),
	date_of_joining date
)

drop table employees

--NOT NUll constraint-
alter table employees
alter column id int NOT NULL

--Adding primary key constraint after table creation
ALTER TABLE employees
ADD CONSTRAINT PK_employees PRIMARY KEY (id);

--Dropping primary key constraint
alter table Employees
drop constraint pk_employees

--An inline constraint can be dropped if it's name is known, here the name was accessed by error message
alter table Employees
drop constraint PK__employee__3213E83F9936E7A9

--dropping a column
alter table employees
drop column id

--Identity is a property (constraint), which needs to be added while table creation it self
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
SELECT * FROM employees