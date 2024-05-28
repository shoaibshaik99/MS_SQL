--1)Select all customers along with the name and city of their country:

Select FirstName + ' ' + LastName As 'Full Name', City, Country From Customers;
--Select all products along with their supplier name:
Select p, s.Name From Products p Inner Join Suppliers s On p.ProductID = s.ProductID

--2)Problem: Create a stored procedure that updates a 'Products' table with the provided product name
--and price for the record that matches the provided product ID.

Create Proc UpdateProducts (@ProductName as varchar(50), @ProductPrice as int, @ProductID as int)
As
Begin
	Update Products
	Set ProductName = @ProductName, ProductPrice = @ProductPrice Where ProductID = @ProductID
End
--3)Problem: Create a function that returns the average price of a product by taking the product ID as input and
--calculating the average of all prices for that product.

Create Function GetAvgPrice(@ProductID as varchar(50))
Returns int
Begin
	Declare @Avg int;
	Set @Avg = Select AVG(Price) From Products Where ProductID = @ProductID;
	Return @Avg;

End