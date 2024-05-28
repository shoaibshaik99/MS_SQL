--Inbuilt Fucntions
Select GetDate(); -- Fetches Current date
--Cast() and Convert() -- ocnverts expression of one data ty to to another
Select APP_NAME();
Select Current_User;
Select User_Name();

--@FirstName is Null hence Coalesce returns second parameter
Declare @FirstName varchar(50);
Select Coalesce(@FirstName, 'Miller');
--@FirstName is Not Null hence Coalesce returns First parameter
Declare @FirstName varchar(50);
Select Coalesce(@FirstName, 'Miller');

--UDF (User defined functions) or custom Functions

--Functions always return a value or table
--Can be used in scripts, SP,trigger and other UDFs within a databse
--It can be modified independent of source code
--Helps in reducing network traffic

--Two Types, scaler valued and table valued functions
--Table valued can be classified into
	--Inline table valued Function: Contains single select statement
	--and
	--Multi-Statement Table valued Function: Contains mmultiple sql statements eclosed in Begin adn End Blocks.

--scaler valued function
Create Function AddTwoDigits (@num1 as int,@num2 as int)
Returns int
As
Begin
Return @num1+@num2;	
End;

Select dbo.AddTwoDigits(2,17);

--Alterting the function
Alter Function AddTwoDigits (@num1 as int,@num2 as int)
Returns int
As
Begin
Declare @Result as int;
Set @Result = @num1 + @num2;
Return @Result;	
End;

Select dbo.AddTwoDigits(205,508);

--Function to calculate total reward points disbursed
Create Function TotalRPDisbursed()
Returns int
As
Begin
Return (Select sum(RewardPoints) from Consumers);
End;

Select dbo.TotalRPDisbursed();

Drop Function TotalRPDisbursed;
Drop Function dbo.TotalRPDisbursed;
Drop Function TotalRPDisbursed(); --incorrect syntax
Drop Function dbo.TotalRPDisbursed(); -- incorrect syntax

-- Giving appropriate name to the function to fetch total RP disbursed
Create Function GetTotalRP()
Returns int
As
Begin
Return (Select sum(RewardPoints) from Consumers);
End;

Select dbo.GetTotalRP();

--Function to fetch Total RP dibursed for each city
Create Function GetTotalCityRP(@City as varchar(max))
Returns int
As
Begin
Return (Select Sum(RewardPoints) From Consumers Where City = @City);
End;

Select City, dbo.GetTotalCityRP(City) From Consumers;
Select Distinct City, dbo.GetTotalCityRP(City) From Consumers
Select City, dbo.GetTotalCityRP(City) From Consumers Group By City; -- This is computationally better than using Distinct?

--Function to get FullName of a consumer from the consumers table
Create Function FullName(@CustomerID as int)
Returns varchar(max)
As
Begin
Return (Select FirstName + ' ' + LastName From Consumers Where CustomerID = @CustomerID)
End;

Select dbo.FullName(15);

Drop Function dbo.FullName

--Table Valued Functions

--1)Inline Table valued Function. Begin and end are not to be added here.
Create Function GetConsumersAndRP(@City as varchar(max))
Returns Table
As
Return (Select CustomerID, dbo.FullName(CustomerID) as FullName, RewardPoints from Consumers Where City = @City)


Drop Function GetConsumersAndRP;

Select dbo.GetConsumersAndRP('New York'); -- incorrect syntax.
Select * From dbo.GetConsumersAndRP('New York'); --As it it returns table, it needs to be used with From Clause

--2) Multi statement Table Valued Functions
--Return type is a variable, which is to be declared in the beginning
--so as to be returned automatically at the return statement

--Returns summary table of RP data of a city to whicha a spcific user belongs to.
Create Function GetRPSummaryOfCityOfUser(@User As varchar(max))
Returns @RPSummaryOfCityOfUser Table (NoOfCustomers As NoOfFemales + NoOfMales, TotalCityRP int, NoOfFemales int,NoOfMales int)
As
Begin
Declare @NoOfCustomers int,	@TotalCityRP int, @NoOfFemales int, @NoOfMales int, @City varchar(50);
Set @City  = (Select City From Consumers Where FirstName = @User);
Select @TotalCityRP =  Sum(RewardPoints) From Consumers Where City = @City;
Select @NoOfFemales = Count(Gender) From Consumers Where Gender = 'F' and City = @City;
Select @NoOfmales = Count(Gender) From Consumers Where Gender = 'M' and City = @City;
Insert Into @RPSummaryOfCityOfUser Values(@TotalCityRP,@NoOfFemales,@NoOfmales)
Return
End

Drop Function GetRPSummaryOfCityOfUser;

--Use SET or direct assignment with SELECT to assign values to variables.
--Use INSERT INTO ... VALUES to insert specific, known values into a table.
--Use INSERT INTO ... SELECT to insert the result of a query or computation into a table.

Alter FUNCTION GetRPSummaryOfCityOfUser(@User AS VARCHAR(MAX))
RETURNS @RPSummaryOfCityOfUser TABLE (NoOfCustomers INT, TotalCityRP INT, NoOfFemales INT, NoOfMales INT, City VARCHAR(max))
AS
BEGIN
    DECLARE @City VARCHAR(50);
    SELECT @City = City FROM Consumers WHERE FirstName = @User;
    INSERT INTO @RPSummaryOfCityOfUser (NoOfCustomers, TotalCityRP, NoOfFemales, NoOfMales, City)
    SELECT
        (SELECT COUNT(*) FROM Consumers WHERE City = @City),
        (SELECT SUM(RewardPoints) FROM Consumers WHERE City = @City),
        (SELECT COUNT(*) FROM Consumers WHERE Gender = 'F' AND City = @City),
        (SELECT COUNT(*) FROM Consumers WHERE Gender = 'M' AND City = @City),
		(SELECT @City);

    RETURN;
END

Select * From Consumers

--Executing Multi statement table valued Function
Select * from GetRPSummaryOfCityOfUser('Jane');
Select * from GetRPSummaryOfCityOfUser('Michael');
Select * from GetRPSummaryOfCityOfUser('Alice');
Select * from GetRPSummaryOfCityOfUser('David');