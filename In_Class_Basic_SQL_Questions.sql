--1) fetch last two rows from a table.
--2)Retrieve all the records from a table where a certain condition is met (e.g., all employees with a price greater than 50,000).
--3)Group data from a table based on a specific column and apply aggregate functions on each group (e.g., find the total sales amount for each product category).
--4)Use OFFSET and FETCH to retrieve 2 records from a table, skipping 2 rows.
--5)Retrieve all orders placed in January 2024
--6)Retrieve all customers whose names start with 'J'.

select * from Mytable;

drop table MyTable;

create table Mytable
(
	id int identity(1,1) primary key,
	Category varchar(20),
	Price int,
	OrderDate date,
	SalesCount int
);

insert into Mytable (Category, Price, OrderDate, SalesCount)
values
    ('Electronics', 100, '2024-04-01',5),
    ('Clothing', 50, '2024-04-02', 10),
    ('Books', 20, '2024-04-03', 2),
    ('Furniture', 200, '2024-04-04',20),
    ('Toys', 30, '2024-04-05',16);

--First
select * from Mytable order by id desc offset 0 rows fetch next 2 rows only;

--Second
select * from Mytable where price >= 50;

--Third
select category, sum(SalesCount) as TotalSales from Mytable group by category;

--Fourth
select * from MyTable order by OrderDate offset 2 rows fetch next 2 rows only;

--Fifth
select * from Mytable where OrderDate like '2024-01-%';
select * from Mytable where OrderDate >= '2024-01-01' and OrderDate < '2024-02-01';
--Sixt
select * from MyTable where Category like 'B%';