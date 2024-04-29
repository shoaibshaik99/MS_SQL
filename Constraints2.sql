USE LocalDB

-- Create the Employee table with NOT NULL constraint
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,  -- Primary key for uniquely identifying employees
    Name NVARCHAR(50) NOT NULL,  -- Employee name (cannot be NULL)
    Salary DECIMAL(10, 2)        -- Employee salary
);

-- Add a UNIQUE constraint on PhoneNumber
ALTER TABLE Employee
ADD PhoneNumber NVARCHAR(15) UNIQUE;  -- Each phone number must be unique

-- Create the Department table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,  -- Primary key for uniquely identifying departments
    DepartmentName NVARCHAR(50)   -- Department name
);

--The foreign key (not necessarily primary key) column can have the values in present in primary key of pareant table or null.
-- Add a FOREIGN KEY constraint linking Employee to Department
ALTER TABLE Employee
ADD DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);  -- Prevents destroying links

-- Add a CHECK constraint on Gender (only 'Male' or 'Female' allowed)
ALTER TABLE Employee
ADD Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female'));

-- Set a DEFAULT constraint for Salary (default value: $50,000)
ALTER TABLE Employee
ADD CONSTRAINT DF_Employee_Salary DEFAULT 50000 FOR Salary;

--***********************************************************************************************************************************************************
--Adding Inline constraints
-- Creating EmployeeInfo table with relevant columns and constraints
CREATE TABLE EmployeeInfo (
    EmployeeID INT PRIMARY KEY,       -- Unique identifier for employees
    FirstName NVARCHAR(50) NOT NULL,  -- First name (cannot be NULL)
    LastName NVARCHAR(50) NOT NULL,   -- Last name (cannot be NULL)
    BirthDate DATE,                   -- Date of birth
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female')),  -- Gender (only 'Male' or 'Female')
    Salary DECIMAL(10, 2) DEFAULT 50000,  -- Salary with default value
    DepartmentID INT,  -- Foreign key linking to Department table
	--Foreign jey can be declared in line as below
	--DepartmentID INT FOREIGN KEY REFERENCES Department(Department ID)
    PhoneNumber NVARCHAR(15) UNIQUE,  -- Unique phone number
    Email NVARCHAR(100) UNIQUE,       -- Unique email address
    HireDate DATE,                    -- Date of hire
    CONSTRAINT FK_EmployeeInfo_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)  -- Foreign key constraint
);

-- Insert sample data into the EmployeeInfo table
INSERT INTO EmployeeInfo (EmployeeID, FirstName, LastName, BirthDate, Gender, Salary, DepartmentID, PhoneNumber, Email, HireDate)
VALUES
    (1, 'John', 'Doe', '1990-05-15', 'Male', 60000, 101, '123-456-7890', 'john.doe@example.com', '2020-01-10'),
    (2, 'Jane', 'Smith', '1985-08-20', 'Female', 55000, 102, '987-654-3210', 'jane.smith@example.com', '2019-03-22'),
    (3, 'Michael', 'Johnson', '1995-02-28', 'Male', 52000, 101, '555-123-4567', 'michael.johnson@example.com', '2021-07-05');

--***********************************************************************************************************************************************************

CREATE TABLE EmployeeInfo (
    EmployeeID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE,
    Gender NVARCHAR(10),
    Salary DECIMAL(10, 2)
);


ALTER TABLE EmployeeInfo
ALTER COLUMN FirstName NVARCHAR(50) NOT NULL;

ALTER TABLE EmployeeInfo
ALTER COLUMN LastName NVARCHAR(50) NOT NULL;


ALTER TABLE EmployeeInfo
ADD CONSTRAINT UQ_EmployeeID UNIQUE (EmployeeID);

ALTER TABLE EmployeeInfo
ADD CONSTRAINT PK_EmployeeInfo PRIMARY KEY (EmployeeID);

ALTER TABLE EmployeeInfo
ADD DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

ALTER TABLE EmployeeInfo
ADD CONSTRAINT CHK_Gender CHECK (Gender IN ('Male', 'Female'));

ALTER TABLE EmployeeInfo
ADD CONSTRAINT DF_Salary DEFAULT 50000 FOR Salary;

INSERT INTO EmployeeInfo (EmployeeID, FirstName, LastName, BirthDate, Gender, Salary, DepartmentID)
VALUES
    (101, 'John', 'Doe', '1990-05-15', 'Male', 60000, 1),
    (102, 'Jane', 'Smith', '1985-08-20', 'Female', 55000, 2);


--***********************************************************************************************************************************************************

CREATE TABLE NotNullDemo (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);

-- Attempt to insert a row with NULL value for Name (should fail)
INSERT INTO NotNullDemo (ID, Name) VALUES (1, NULL);


--***********************************************************************************************************************************************************

CREATE TABLE UniqueDemo (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    PhoneNumber NVARCHAR(15) UNIQUE
);

-- Insert sample data with unique phone numbers
INSERT INTO UniqueDemo (ID, Name, PhoneNumber)
VALUES
    (1, 'Alice', '123-456-7890'),
    (2, 'Bob', '987-654-3210');


--***********************************************************************************************************************************************************

CREATE TABLE PrimaryKeyDemo (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);

-- Insert employees with unique EmployeeIDs
INSERT INTO PrimaryKeyDemo (EmployeeID, FirstName, LastName)
VALUES
    (101, 'John', 'Doe'),
    (102, 'Jane', 'Smith');

--***********************************************************************************************************************************************************

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Insert a department
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES (101, 'Engineering');

-- Link employees to the Engineering department
UPDATE Employee
SET DepartmentID = 101
WHERE EmployeeID IN (101, 102);

--***********************************************************************************************************************************************************

CREATE TABLE CheckDemo (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female'))
);

-- Insert employees with valid gender values
INSERT INTO CheckDemo (ID, Name, Gender)
VALUES
    (1, 'Alex', 'Male'),
    (2, 'Sam', 'Female');

--***********************************************************************************************************************************************************

CREATE TABLE DefaultDemo (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Salary DECIMAL(10, 2) DEFAULT 50000
);

-- Insert employees without specifying salary (default value: $50,000)
INSERT INTO DefaultDemo (ID, Name)
VALUES
    (1, 'Eva'),
    (2, 'Max');

--***********************************************************************************************************************************************************