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
