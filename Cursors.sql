Declare @CustomerID int;
Declare @FirstName varchar(50);
Declare @LastName varchar(50);
Declare @Gender varchar;
Declare @Phone bigint;
Declare @Email varchar(50);
Declare @City varchar(50);
Declare @RewardPoints int;
Declare @RegisteredDate date;

Declare ConsumersCodeCursor Cursor For Select * From Consumers

Open ConsumersCodeCursor

Fetch Next From ConsumersCodeCursor
Into @CustomerID, @FirstName, @LastName, @Gender, @Phone, @Email, @City, @RewardPoints, @RegisteredDate;

While @@FETCH_STATUS = 0
	Begin
		Declare @CustomerIdentity varchar(max);
		Set @CustomerIdentity = 'Cid' + Cast(@Phone As Varchar(10)) + @Email + @City + Cast(@RegisteredDate As varchar(20))
		Print @CustomerIdentity;

		Fetch Next From ConsumersCodeCursor
		Into @CustomerID, @FirstName, @LastName, @Gender, @Phone, @Email, @City, @RewardPoints, @RegisteredDate;
	End

Close ConsumersCodeCursor

Deallocate ConsumersCodeCursor

--*********************************************************************
--Another Exanple

DECLARE 
    @person_name VARCHAR(MAX), 
    @RP int;

DECLARE cursor_consumers CURSOR
FOR SELECT 
        FirstName + ' ' + LastName,
        RewardPoints
    FROM 
        Consumers;

OPEN cursor_consumers;

FETCH NEXT FROM cursor_consumers  INTO 
    @person_name, 
    @RP;

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @person_name + ': ' CAST(@RP AS varchar);
        FETCH NEXT FROM cursor_consumers INTO 
            @person_name, 
            @RP;
    END;

CLOSE cursor_consumers;

DEALLOCATE cursor_consumers;
