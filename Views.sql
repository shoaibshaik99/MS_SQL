--Creating a view
Create View ConsumersView
As
Select c.Firstname, c.LastName, co.OrderId, co.OrderDate, co.OrderTotal
From Consumers c Inner Join ConsumersOrders co On c.CustomerId  = co.CustomerID;

--Referencing to a view in select statement
Select * From ConsumersView

--Altering a view
Create OR ALTER View ConsumersView
As
Select c.CustomerID, c.Firstname, c.LastName, co.OrderId, co.OrderDate, co.OrderTotal
From Consumers c Inner Join ConsumersOrders co On c.CustomerId  = co.CustomerID;

--Renaming a view
EXEC sp_rename @objname = 'ConsumersView', @newname = 'ConsumersOrdersView';
Select * From ConsumersOrdersView

--Listing views
Select * From sys.views

--Dropping View
Drop View If Exists ConsumersOrdersView;
Drop View If Exists ConsumersView;