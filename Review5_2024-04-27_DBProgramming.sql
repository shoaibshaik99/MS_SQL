--1)You have a table Employees with a primary key EmployeeID.
--You need to change the EmployeeID to a foreign key referencing
--a new table Departments with a primary key DepartmentID.

Drop Table Employees
Create Table Employees
(
	EmployeeID int Primary Key,
	EmployeeName varchar(50)
)

Drop Table Departments
Create Table Departments
(
	DepartmentId int Primary Key,
	DepartmentName varchar(50)
)

Alter Table Employees
Add Constraint FK_EmployeeID Foreign Key (EmployeeID) References Departments(DepartmentID)

--*******************************************************************************************************************************
--2) Table Products with a check constraint ensuring that the Price column is greater than 0,
--extend this constraint to ensure that the DiscountedPrice column,
--calculated as Price - Discount, is also greater than or equal to 0.

Create Table Products
(
	ProductID int Primary Key,
	ProductName varchar(50),
	Price decimal(10,2) Check (Price > 0),
	Discount decimal(10,2) Check (Discount >=0 and Discount < Price),
	DiscountedPrice decimal(10,2)
)

Alter Table Products
Add  Constraint CHK_DiscountedPrice Check (DiscountedPrice > 0 and DiscountedPrice < Price and DiscountedPrice = Price - Discount)

Insert Into Products Values(1,'Brush', 20.5, 1.5, 19)
Insert Into Products Values(1,'Brush', 20.5, 1.5, 18) -- will fail
--*******************************************************************************************************************************
--3)Develop a SQL query to calculate the total sales amount for each product category in the Sales table,
--but only include sales that occurred in the last quarter of the year.

Drop Table Sales;

Create Table Sales
(
	ProductCategory varchar(50),
	SaleDate date,
	SaleValue decimal(10,2)
)

Insert Into Sales (ProductCategory, SaleDate, SaleValue)
Values ('Electronics', '2023-10-15', 500.00), ('Clothing', '2023-11-20', 300.00), ('Electronics', '2023-12-05', 700.00), ('Sports', '2023-02-06', 500.00)


Select ProductCategory, Sum(SaleValue) As TotalSales From Sales Where SaleDate > '2023-09-30' and SaleDate <'2024-01-01' Group By ProductCategory

--*******************************************************************************************************************************
--4)Write a SQL query to retrieve the names of employees from the Employees table who have placed orders in the Orders table.

Drop Table Employees;
Create Table Employees
(
    EmployeeID int Primary Key,
    FirstName Varchar(50),
    LastName Varchar(50)
);

Drop Table Orders;

Create table Orders
(
    OrderID int Primary Key,
    EmployeeID int,
    OrderDate date,
);

Insert Into Employees (EmployeeID, FirstName, LastName)
Values (1, 'John', 'Doe'), (2, 'Jane', 'Smith'), (3, 'Alice', 'Johnson');

Insert Into Orders (OrderID, EmployeeID, OrderDate)
Values (101, 1, '2024-04-25'), (102, 2, '2024-04-26'), (103, 1, '2024-04-27');

-- Using Inner Join
Select * FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID;
Select Distinct * FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID;
Select e.FirstName FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID;
Select Distinct e.FirstName + ' ' + e.LastName As FullName From Employees e Inner Join Orders o On e.EmployeeID = o.EmployeeID;

--Using Subquery
Select e.FirstName + ' ' + e.LastName As FullName From Employees e Where e.EmployeeID IN ( Select Distinct o.EmployeeID FROM Orders o);

--*******************************************************************************************************************************
--5)OrderID	CustomerName	CustomerEmail	ProductID	ProductName	UnitPrice	Quantity	TotalPrice
--these are columns of a table , normalize it

--Rough
--Orders - OrderId, Quantity, TotalPrice
--Customer - CustomerName, CustomerEmail
--Product - ProductID, ProductName, UnitPrice

Create Table Customers
(
    CustomerID int Primary Key,
    CustomerName varchar(100),
    CustomerEmail varchar(100)
);

Create table Products (
    ProductID int Primary Key,
    ProductName varchar(100),
    UnitPrice decimal(10, 2)
);


Create Table Orders (
    OrderID int Primary Key,
    CustomerID int,
    ProductID int,
    Quantity int,
    TotalPrice decimal(10, 2),
    Foreign Key (CustomerID) References Customers(CustomerID),
    Foreign Key (ProductID) References Products(ProductID)
);