--*****Data Definition Language*****

CREATE SCHEMA Company;

CREATE TABLE Company.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT
);

CREATE TABLE Company.Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

INSERT INTO Company.Departments (DepartmentID, DepartmentName)
VALUES
    (101, 'Engineering'),
    (102, 'Sales');

INSERT INTO Company.Employees (EmployeeID, FirstName, LastName, DepartmentID)
VALUES
    (1, 'John', 'Doe', 101),
    (2, 'Jane', 'Smith', 102);
-- Get all employees in the Engineering department
SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Company.Employees e
INNER JOIN Company.Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Engineering';
--****************************************************
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
