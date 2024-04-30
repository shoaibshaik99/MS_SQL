use LocalDB;

drop table Consumers;

create table Consumers
(
CustomerID int identity(1,1) primary key not null,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Gender varchar check(gender = 'm' or gender = 'f'),
Phone bigint check(phone>1000000000 and phone <9999999999),
Email varchar(50),
City varchar(50),
RewardPoints int check (RewardPoints > 0 and RewardPoints < 10000),
RegisteredDate date
);

-- Inserting duplicates in FirstName
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Alice', 'Smith', 'f', 1234567890, 'alice.smith@email.com', 'New York', 500, '2023-01-15'),
('Alice', 'Johnson', 'm', 9876543210, 'alice.johnson@email.com', 'Los Angeles', 700, '2022-07-22'),
('Bob', 'Brown', 'f', 5551234567, 'bob.brown@email.com', 'Chicago', 200, '2023-11-30'),
('Bob', 'Lee', 'm', 1239876543, 'bob.lee@email.com', 'Houston', 300, '2022-05-10'),
('Carol', 'Garcia', 'f', 4567890123, 'carol.garcia@email.com', 'Miami', 800, '2023-08-05');

-- Inserting duplicates in LastName
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('David', 'Smith', 'm', 7890123456, 'david.smith@email.com', 'San Francisco', 600, '2022-09-18'),
('Eva', 'Smith', 'f', 9876543210, 'eva.smith@email.com', 'New York', 900, '2023-04-25'),
('Frank', 'Smith', 'm', 1234567890, 'frank.smith@email.com', 'Los Angeles', 400, '2022-12-10'),
('Grace', 'Johnson', 'f', 5551234567, 'grace.johnson@email.com', 'Chicago', 150, '2023-02-28'),
('Henry', 'Johnson', 'm', 1239876543, 'henry.johnson@email.com', 'Houston', 750, '2023-10-15');

-- Inserting duplicates in Gender
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Isabel', 'Garcia', 'f', 4567890123, 'isabel.garcia@email.com', 'Miami', 550, '2023-06-20'),
('Jack', 'Lee', 'm', 7890123456, 'jack.lee@email.com', 'San Francisco', 650, '2022-08-12'),
('Karen', 'Brown', 'f', 9876543210, 'karen.brown@email.com', 'New York', 850, '2023-03-17'),
('Larry', 'Nguyen', 'm', 1234567890, 'larry.nguyen@email.com', 'Los Angeles', 950, '2023-09-08'),
('Mary', 'Lee', 'f', 5551234567, 'mary.lee@email.com', 'Chicago', 250, '2023-12-01');

-- Inserting duplicates in Phone
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Nancy', 'Smith', 'f', 1234567890, 'nancy.smith@email.com', 'Houston', 700, '2023-07-14'),
('Oscar', 'Johnson', 'm', 9876543210, 'oscar.johnson@email.com', 'Miami', 400, '2022-11-29'),
('Peter', 'Garcia', 'f', 5551234567, 'peter.garcia@email.com', 'San Francisco', 300, '2023-05-06'),
('Quinn', 'Nguyen', 'm', 1239876543, 'quinn.nguyen@email.com', 'New York', 150, '2023-01-02'),
('Rachel', 'Brown', 'f', 1234567890, 'rachel.brown@email.com', 'Los Angeles', 250, '2022-12-28');

-- Inserting duplicates in Email
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Sam', 'Lee', 'm', 7890123456, 'sam.lee@email.com', 'Chicago', 850, '2023-03-09'),
('Tina', 'Johnson', 'f', 9876543210, 'tina.johnson@email.com', 'Houston', 950, '2023-08-22'),
('Uma', 'Smith', 'f', 5551234567, 'uma.smith@email.com', 'Miami', 650, '2022-10-17'),
('Victor', 'Garcia', 'm', 1234567890, 'victor.garcia@email.com', 'San Francisco', 750, '2023-04-14'),
('Wendy', 'Nguyen', 'f', 1239876543, 'wendy.nguyen@email.com', 'New York', 550, '2023-11-30');

-- Inserting duplicates in City
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Xavier', 'Johnson', 'm', 4567890123, 'xavier.johnson@email.com', 'Los Angeles', 450, '2023-02-12'),
('Yolanda', 'Smith', 'f', 7890123456, 'yolanda.smith@email.com', 'Miami', 850, '2022-12-05'),
('Zack', 'Brown', 'm', 9876543210, 'zack.brown@email.com', 'New York', 950, '2023-07-18'),
('Alice', 'Garcia', 'f', 5551234567, 'alice.garcia@email.com', 'San Francisco', 550, '2023-09-21'),
('Bob', 'Nguyen', 'm', 1234567890, 'bob.nguyen@email.com', 'Chicago', 750, '2022-11-14');

--**********************************************************************************************************************************

--selecting all columns from a table, do not use the SELECT * for production code as it retreives more data than necessary and few more reasons
select * from Consumers;

--selecting desired columns from a table
select
	FirstName,
	LastName
from
	Consumers;

select
	FirstName,
	LastName,
	Email
from
	Consumers;

--selecting specific rows from all or desired columns using where clause
select * from Consumers where City = 'Chicago';
select * from Consumers where Gender = 'f';
select FirstName,LastName,email from Consumers where Gender = 'm';

--ordering data by values in a specific column
select * from Consumers where Gender = 'm' order by FirstName;
select * from Consumers where Gender = 'm' order by City;
select * from Consumers where Gender = 'f' order by City;
select * from Consumers order by City;

--select with Group BY 
-- Error occurs in below 4 group by queries as there is no guarantee that the other columns have a unique value in the respective group.
-- note that select on a group by displays unique value for that respective combination of columns (may be like tha value of key in LINQ group by)
select * from Consumers where Phone IS NULL group by Gender order by city;
select * from Consumers Group by Gender;
select CustomerID, FirstName, LastName, Gender, Phone, Email, City, count(Gender) from Consumers group by Gender;
select * from Consumers where Phone = 1239876543 group by Gender order by city;


select City,count(*) As City_Count from Consumers where Gender = 'f' group by city order by City_Count;
select city,count(Gender) As Gender_Count from Consumers where Gender = 'f' group by city order by city;

--WHERE clause filters rows while the HAVING clause filter groups.
select city,count(Gender) As Gender_Count from Consumers where Gender = 'f' group by city having count(Gender)  3 order by city;
--***************************************************************************************************************************************************************
--ORDER BY
select Email From Consumers order by City;
select Email, City From Consumers order by City;
select Email, City From Consumers order by City desc;
select Email, City From Consumers order by City asc;
--Here it dorts by city first and then in each city result it sorts by first name
select Email, City, FirstName From Consumers order by City, FirstName;
select Email , City, FirstName From Consumers order by City desc, FirstName asc;
--sorting by column not in selected columns
select Email, City, FirstName From Consumers order by Phone;
--sort by expression
select Phone from Customers order by LEN(FirstName) Desc;
--sorting by columns position in selected columns (ordinal position)
select Firstname, Email from Consumers order by 1,3; -- will throw error as there is 3rd columns in selected columns
select Firstname, LastName, Email from Consumers order by 1,3;

--***************************************************************************************************************************************************************
--OFFSET and FETCH clauses are the options of the ORDER BY clause,which allow limiting the number of rows to be returned by a query.
	--ORDER BY column_list [ASC |DESC]
	--OFFSET offset_row_count {ROW | ROWS}
	--FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY

--These can be used only with ORDER BY clause and not otherwise
select FirstName, City from Consumers order by Gender, Phone  ;
--offset removes first rows from result
select FirstName, City from Consumers order by Gender, Phone offset 2 rows;
--fetch selects first rows from result
select FirstName, City from Consumers order by Gender, Phone offset 2 rows fetch next 4 rows only;
--fetch needs to used with offset, below command will throw error
select FirstName, City from Consumers order by Gender, Phone fetch next 4 rows only;

--OFFSET 0 rows to FETCH top n rows
select FirstName, City from Consumers order by Gender, Phone offset 0 rows fetch next 4 rows only;

--***************************************************************************************************************************************************************
--filtering

--Distinct Clause

select FirstName from Consumers; -- execute this and below query together to observe the difference.
select distinct FirstName from Consumers;
--will throw error as city in order by is not in select while using distinct
select distinct FirstName from Consumers order by city;
--corrected query
-- ordered set of columns in selected list for distinction
select distinct FirstName,City from Consumers order by city;
select distinct FirstName, Phone, City from Consumers order by city;
--null is also treated as a distinct value.
--GROUP BY vs Distinct, both  the following queries are equiavalent in displaying result, but how?
select FirstName, LastName, City from Consumers group by FirstName, LastName, City order by FirstName, LastName, City;
select distinct FirstName, LastName, City from Consumers

--where Clause

select Firstname, LastName, Gender from Consumers where City = 'Los Angeles' order by phone;
select Firstname, LastName, Gender from Consumers where City = 'LosAngeles' and Gender = 'f' order by phone;

select * from Consumers;
select Firstname, LastName, City, Gender from Consumers where City = 'Los Angeles';
select Firstname, LastName, City, Gender from Consumers where City = 'Los Angeles' and Gender = 'f'; --not working as desired why?

select Firstname, LastName, City, Gender from Consumers where City = 'Los Angeles';
select Firstname, LastName, City, Gender from Consumers where Gender = 'f';
select Firstname, LastName, City, Gender from Consumers where City = 'Los Angeles' or Gender = 'f'; --not working as desired?

select Firstname, phone from Consumers where phone between 1239876543 and 5551234567 order by phone; --between the specified range

select Firstname, city from Consumers where City in ('New York', 'Los Angeles') order by city; --in the selected list

select Firstname, email from Consumers where emial like '%Smith%'order by city; --% is substituition for one or many charecters

--And Operator
--boolean_expression AND boolean_expression --syntax

--The boolean_expression is any valid Boolean expression that evaluates to TRUE, FALSE, and UNKNOWN.
--Among multiples logical operators in an expression AND is evaluated first within parantheses.

select * from Consumers Where CustomerID>10 and CustomerID<20 Order by city desc;
select * from Consumers Where CustomerID>10 and CustomerID<20 and gender = 'f' Order by city desc;
select * from Consumers Where CustomerID>10 and CustomerID<20 or gender = 'f';
select * from Consumers Where CustomerID>10 and CustomerID<20 or gender = 'f' Order by city desc;
select * from Consumers Where (CustomerID>10 and gender = 'f' ) and CustomerID<20 Order by city desc;

--OR Operator
--boolean_expression OR boolean_expression -- syntax
--multiple OR operators ona  single column can be replaced by IN

select * from Consumers Where CustomerID=10 or CustomerID=20 or CustomerID = 30 Order by city desc;
select * from Consumers Where CustomerID in (10, 20, 30) Order by city desc;

--IN Operator
--column | expression IN ( v1, v2, v3, ...) --syntax

--NOT IN can be used to negate IN Operator
--column | expression NOT IN ( v1, v2, v3, ...)
-- If a list contains NULL, the result of IN or NOT IN will be UNKNOWN.

select * from Consumers where City in ('Chicago', 'Los Angeles', 'New York') order by city;

--In operator with subquery
--column | expression IN (subquery) --syntax
SELECT
    product_id
FROM
    production.stocks
WHERE
    store_id = 1 AND quantity >= 30;
--
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id IN (
        SELECT
            product_id
        FROM
            production.stocks
        WHERE
            store_id = 1 AND quantity >= 30
    )
ORDER BY
    product_name;

--BETWEEN Operator
--column | expression BETWEEN start_expression AND end_expression -- syntax
--column | expression <= end_expression AND column | expression >= start_expression --this can be substitute for between but between is more readable
--NOT BETWEEN -- column | expression < start_expression AND column | expression > end_expression --syntax

select Firstname, phone from Consumers where phone between 1239876543 and 5551234567 order by phone; --between the specified range
select Firstname, phone from Consumers where phone not between 1239876543 and 5551234567 order by phone; --not between the specified range

--between can be used with date as follows
SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM
    sales.orders
WHERE
    order_date BETWEEN '20170115' AND '20170117'
ORDER BY
    order_date;
--

--LIKE Operator
--column | expression LIKE pattern [ESCAPE escape_character] --syntax

--valid wildcard characters:
--The percent wildcard (%): any string of zero or more characters.
--The underscore (_) wildcard: any single character.
--The [list of characters] wildcard: any single character within the specified set.
--The [character-character]: any single character within the specified range.
--The [^]: any character that is not within a list or a range.

select FirstName from Consumers where Firstname like 'A%'; --starting with A
select FirstName,City from Consumers where Firstname like '%e' order by City; --ending with e
select FirstName,City from Consumers where Firstname like '%a%' order by City; --contains a
select FirstName,City from Consumers where Firstname like '_a%' order by City; --second character is a
select FirstName,City from Consumers where Firstname like '%[ab]%' order by City; --contains a or u --comparision is case insensitive
select FirstName,City from Consumers where Firstname like '%[f-i]%' order by City; --contains any char from f to h --comparision is case insensitive
select FirstName,City from Consumers where Firstname like '[^A-X]%' order by City; --doesn't start with a-x --comparision is case insensitive
select FirstName,City from Consumers where Firstname like '[YZ]%' order by City; --starts y or z -- same as above--comparision is case insensitive
select FirstName,City from Consumers where Firstname not like '[A]%' order by City; --not like starting with a--comparision is case insensitive
--Escape charecter with like
SELECT feedback_id, comment FROM sales.feedbacks WHERE comment LIKE '%30!%%' ESCAPE '!'; -- ESACPE will notify this is escape charecter to consider

--column alias
select FirstName, LastName from Consumers order by city
select FirstName + ' '+ LastName from Consumers order by city
select FirstName + '*' + LastName from Consumers order by city
select FirstName + ' ' + LastName as FullName from Consumers order by city
select FirstName + ' ' + LastName as 'Full Name' from Consumers order by city
select FirstName + ' ' + LastName as 'Full Name', city from Consumers order by city
select city, FirstName + ' ' + LastName as 'Full Name' from Consumers order by city
select city as Residence, FirstName + ' ' + LastName as 'Full Name' from Consumers order by city
select city 'Place of Residence', FirstName + ' ' + LastName as 'Full Name' from Consumers order by 'Place of Residence'
--table alias
SELECT
    c.customer_id,
    first_name,
    last_name,
    order_id
FROM
    sales.customers c
INNER JOIN sales.orders o ON o.customer_id = c.customer_id;
--
--***************************************************************************************************************************************************************
--Grouping Data

--GROUP BY
-- Error occurs in below 4 group by queries as there is no guarantee that the other columns have a unique value in the respective group.
-- note that select on a group by displays unique value for that respective combination of columns (may be like tha value of key in LINQ group by)
select * from Consumers where Phone IS NULL group by Gender order by city;
select * from Consumers Group by Gender;
select CustomerID, FirstName, LastName, Gender, Phone, Email, City, count(Gender) from Consumers group by Gender;
select * from Consumers where Phone = 1239876543 group by Gender order by city;
-- group by firstname and count the number of occurrences
select firstname, count(*) as occurrences from consumers group by firstname;
select FirstName from Consumers group by FirstName, City;
select FirstName,City from Consumers group by FirstName, City;
select distinct FirstName, City from Consumers order by FirstName, City; -- functionally this query is same as above!

select City, Count(FirstName) 'No of Persons' from Consumers Group By City; -- count of number of persons in each group, grouping is based on city
select City, Min(Phone) 'Lowest Phone Num', Max(Phone) 'Highest Phone Num' from Consumers Group By City;
select City, AVG(Phone) from Consumers Group By City;
select City, SUM(Phone) from Consumers Group By City;
select City, SUM(Phone+5) from Consumers Group By City;
--+++++++++++++++
SELECT
    brand_name,
    AVG (list_price) avg_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY
    brand_name;
--+++++++++++++++
SELECT
    order_id,
    SUM (
        quantity * list_price * (1 - discount)
    ) net_value
FROM
    sales.order_items
GROUP BY
    order_id;
--+++++++++++++++

-- HAVING clause, often used with GROUP BY clause to filter groups
-- SELECT select_list FROM table_name GROUP BY group_list HAVING conditions;
--Aggregate functions can't be referred by their alias in having, as it is executed after group by clause
-- SELECT column_name1, column_name2, aggregate_function (column_name3) column_alias FROM table_name GROUP BY column_name1, column_name2 HAVING column_alias > value;
-- above query fails
select City, Count(FirstName) from Consumers group by city having Count(FirstName) = 5 order by city;
-- group by city and count the number of consumers in each city, only showing cities with more than 1 consumer
select city, count(*) as 'Number of consumers' from consumers group by city having count(*) > 1;
select city, avg(RewardPoints) as 'Least active consumers' from consumers group by city having avg(RewardPoints) < 500;
select city, avg(RewardPoints) as 'Moderately active consumers' from consumers group by city having avg(RewardPoints) between 500 and 800;

--Grouping sets

--SUB QUERY
SELECT employee_id, first_name, last_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT product_name, list_price, category_id FROM production.products p1 WHERE list_price IN
(SELECT MAX(p2.list_price) FROM production.products p2 WHERE p2.category_id = p1.category_id GROUP BY p2.category_id)
ORDER BY category_id, product_name;

--in select statement
SELECT
    employee_id, first_name, last_name, department_name, salary,
    (SELECT ROUND(AVG(salary), 0)
     FROM employees e2
     WHERE e2.department_id = e1.department_id) AS avg_salary_in_department
FROM employees e1;


SELECT
    employee_id, first_name, last_name, department_name, salary,
    (SELECT ROUND(AVG(salary), 0)
     FROM employees e2
     WHERE e2.department_id = e1.department_id) AS avg_salary_in_department
FROM employees e1;



--****************************************************************************************************
-- grouping sets: group by gender and city, and also provide a total count for each gender and for each city
select gender, city, count(*) as numberofconsumers from consumers group by grouping sets ((gender, city), (gender), (city), ());

-- cube: show the total count of consumers for all combinations of gender, city, and gender/city
select gender, city, count(*) as numberofconsumers from consumers group by cube (gender, city);

-- rollup: show the total count of consumers for all combinations of gender and city, including subtotals for each gender and for each city
select gender, city, count(*) as numberofconsumers from consumers group by rollup (gender, city);

-- union: combine the results of two queries to get a single result set
select firstname, lastname, city from consumers where gender = 'm' union select firstname, lastname, city from consumers where gender = 'f';

-- intersect: find the common consumers between two queries
select firstname, lastname, city from consumers where gender = 'm' intersect select firstname, lastname, city from consumers where gender = 'f';

-- except: find consumers who are male but not female
select firstname, lastname, city from consumers where gender = 'm' except select firstname, lastname, city from consumers where gender = 'f';
