select * from sys.tables
select * from Consumers

--creating stored procedure
Create Procedure usp_GetNameAndCity --usp means user defined stored procedure
as --separates the heading and the body of the stored procedure.
begin
select FirstName, LastName, City from Consumers
end;

--Stored procedure having only one statement where begin and end are optional
Create Procedure usp_GetEmail as
select FirstName, LastName, Email from Consumers;

--using Proc instead of Procedure
Create Proc usp_GetFullName as
select FirstName +' ' + LastName as Fullname, City from Consumers;


--Executing stored procedure
Exec usp_GetNameAndCity;
--OR
Execute usp_GetNameAndCity;

--Altering Stored Procedure
Alter Proc usp_GetNameAndCity
as
Begin
Select FirstName + ' ' +  LastName As 'Full Name', Email, City From Consumers
End;

--Executing altered procedure
Exec usp_GetNameAndCity;

--Displaying procedures present in current database
select * from sys.procedures

--Dropping Stored Procedures
Drop Procedure usp_GetNameAndCity;
Drop Proc usp_GetEmail, usp_GetFullName;

--****************************************************************************************

--Stored Procedures with parameters
--Consumers who have Reward Points(RP) more than a MinRP are considered PremiumConsumers
Create Proc usp_GetPremiumConsumers(@MinRP as int)
As
Begin
Select FirstName + ' ' +  LastName As 'Full Name', RewardPoints From Consumers Where RewardPoints>@MinRP;
End;

--Altering usp_GetPremiumConsumers to order by RP
Alter Proc usp_GetPremiumConsumers(@MinRP as int)
As
Begin
Select FirstName + ' ' +  LastName As 'Full Name', RewardPoints From Consumers Where RewardPoints>@MinRP Order By RewardPoints Desc;
End;

--Fetching Prmium Consumers details as per threshold set by the respective company
--The input can be asltered
Exec usp_GetPremiumConsumers 100;
Exec usp_GetPremiumConsumers 300;

--Using Multiple Parameters
--Altering usp_GetPremiumConsumers proc to get Premium users from a specific city
Alter Proc usp_GetPremiumConsumers(@MinRP as int, @City as varchar(max))
As
Begin

Select FirstName + ' ' +  LastName As 'Full Name', RewardPoints, City From Consumers
Where RewardPoints>@MinRP  and City = @City Order By RewardPoints Desc;

End;

--Fetching details of premium consumers of specific city
--Execurting altered procedure above
Exec usp_GetPremiumConsumers 400, 'Los Angeles'
Exec usp_GetPremiumConsumers 400, 'New York'
Exec usp_GetPremiumConsumers 400, 'Chicago'

--Named Parameters
--Do not forget to use @ when using parameters
Exec usp_GetPremiumConsumers @MinRP = 500, @City = 'New York';

--Alterign to include LastName as a parameter
Alter Proc usp_GetPremiumConsumers(@MinRP as int, @City as varchar(max),@LastName as varchar(max))
As
Begin
Select FirstName + ' ' +  LastName As 'Full Name', RewardPoints, City From Consumers
Where RewardPoints>@MinRP  and City = @City and LastName Like '%' + @LastName + '%'Order By RewardPoints Desc;
End;

--Executing alterered Procedure using named parameters
--Using named parameters allows to pass the parameters in any order but with correct parametername
--Feteching Premium Consumers based on city, RP and LastName
Exec usp_GetPremiumConsumers @MinRP = 500, @City = 'New York', @LastName = 'Smith';
--Changing the order of parameters
Exec usp_GetPremiumConsumers @MinRP = 200, @LastName = 'Lee', @City = 'Houston';
Exec usp_GetPremiumConsumers @City = 'Houston', @LastName = 'Lee', @MinRP = 200;

--skipping named parameters
Exec usp_GetPremiumConsumers 500, 'New York', 'Smith';
--Throws error becasue of data type mismatch
Exec usp_GetPremiumConsumers 'New York', 500, 'Smith';
 --sometimes there might be an error but the output isn't a desired one
Exec usp_GetPremiumConsumers 500, 'Smith', 'New York';

--Optional Parameters (By assigning default values to them) (Default values are set while assigining parameters)
Alter Proc usp_GetPremiumConsumers(@MinRP as int  = 250, @City as varchar(max) = 'New York', @LastName as varchar(max))
As
Begin
Select FirstName + ' ' +  LastName As 'Full Name', RewardPoints, City From Consumers
Where RewardPoints>@MinRP  and City = @City and LastName Like '%' + @LastName + '%'Order By RewardPoints Desc;
End;

--Executing Stored Procedure with optional parameters (The optional parameters can be skipped as per user preference)
Exec usp_GetPremiumConsumers @LastName = 'Smith';
Exec usp_GetPremiumConsumers @LastName = 'Smith', @MinRP = 450;
Exec usp_GetPremiumConsumers @City = 'Houston', @LastName = 'Lee', @MinRP = 200;

--Using Null as default Parameter, helps to handle unexpected or undesired ....(values?)
Alter Proc usp_GetPremiumConsumers(@MinRP as int  = 250, @City as varchar(max) = NULL, @LastName as varchar(max))
As
Begin
Select FirstName + ' ' +  LastName As 'Full Name', RewardPoints, City From Consumers
Where
		RewardPoints>@MinRP  and
		City Is Null Or City = @City and
		LastName Like '%' + @LastName + '%'
Order By RewardPoints Desc;
End;

Exec usp_GetPremiumConsumers @LastName = 'Smith'; --city is null as in city data unavailable
Exec usp_GetPremiumConsumers @LastName = 'Smith', @MinRP = 450; --city is null as in city data unavailable
Exec usp_GetPremiumConsumers @City = 'Houston', @LastName = 'Lee', @MinRP = 200;

--****************************************************************************************

--Variables
-- Note: VARCHAR meand varying character string!

--Typical use cases of Variables:
--As a loop counter to count the number of times a loop is performed.
--To hold a value to be tested by a control-of-flow statement such as WHILE.
--To store the value returned by a stored procedure or a function

--Declaring a variable
Declare @ThresholdRP int; -- syntax, assigns value and datatype.
Declare @ThresholdRP As int --  As is optional but for me it preferred fro more readability!
--Default vaule is set to NUll
--Multiple varibles declaration
Declare @Variable1 as int, @Variable2 as date

--Assigning Value to Variables
Declare @ThresholdRP int;
Set @ThresholdRP = 500; -- This line alone gives error. Variables are session variables(?)

--Using Varibles in a query
Declare @ThresholdRP int;
Set @ThresholdRP = 300
Select FirstName + ' ' +  LastName As 'Full Name', RewardPoints, City From Consumers Where RewardPoints>=@ThresholdRP Order By City

--Storing query Result in a variable
Declare @MaxRP as int
Set @MaxRP = (Select Max(RewardPoints) From Consumers) -- Do not forget to enclose select statemtn in brackets
Select @MaxRP
Select @MaxRP As MaxRP
--Print can be used to just prinr the value
Declare @MaxRP as int
Set @MaxRP = (Select Max(RewardPoints) From Consumers) -- Do not forget to enclose select statemtn in brackets
Print @MaxRP
Print 'A sample of standalone print statement'
Print 'The Max RP among the consumers is ' + Cast(@MAxRP as Varchar(max));

--Hide the number of rows affected messages using the following
SET NOCOUNT ON;

--Selecting a Record into variable
Declare @MaxRPConsumer as varchar(max), @MaxRP as int
Set @MaxRP = (Select Max(RewardPoints) From Consumers)
Set @MaxRPConsumer = (Select Top 1 FirstName + ' ' + LastName From Consumers Where RewardPoints = @MaxRP )
Select @MaxRPConsumer , @MaxRP
Select @MaxRPConsumer As MaxRPConsumer, @MaxRP As MaxRP

----Selecting a Record into variable directly within select statement
Declare @MaxRPConsumer as varchar(max), @MaxRP as int
Select Top 1 @MaxRPConsumer = FirstName + ' ' + LastName , @MaxRP = RewardPoints from Consumers where RewardPoints = 950;
Select @MaxRPConsumer As MaxRPConsumer, @MaxRP As MaxRP

--Accumulating values into a variable
Create Proc usp_GetMaxRPConsumers(@MaxRP int)
As
Begin
	Declare @MaxRPConsumers as varchar(max);
	Set @MaxRPConsumers = '';
	Select @MaxRPConsumers = @MaxRPConsumers + FirstName + Char(10)
	From Consumers 
	Where RewardPoints = @MaxRP
	Order By FirstName

	Print @MaxRPConsumers
End;
--Altering
Alter Proc usp_GetMaxRPConsumers(@MaxRP int)
As
Begin
	Declare @MaxRPConsumers as varchar(max);
	Set @MaxRPConsumers = '';

	Select @MaxRPConsumers = @MaxRPConsumers + FirstName + ' ' + LastName + Char(10)
	From Consumers 
	Where RewardPoints = @MaxRP
	Order By FirstName + ' ' + LastName

	Print @MaxRPConsumers
End;

Exec usp_GetMaxRPConsumers 950

--****************************************************************************************

--parameter_name data_type OUTPUT -- Syntax
--A Stored Procedure can have many output parameters

Create Proc usp_CountOfDistinctCities(@CountOfCities int Output) -- Input parameters can also be given here
As
Begin
	Select Distinct City From Consumers;
	Select @CountOfCities = @@ROWCOUNT;
End;
--Note that the @@ROWCOUNT is a system variable that returns the number of rows read by the previous statement.

	Declare @CountOfCities as int;
	Exec usp_CountOfDistinctCities @CountOfCities Output;
	Select @CountOfCities as 'Count of Distinct Cities'