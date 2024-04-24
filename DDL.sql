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
