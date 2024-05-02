--Creating Audit table
Create Table ConsumersAudit
(
CustomerID int not null,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Gender varchar check(gender = 'm' or gender = 'f'),
Phone bigint check(phone>1000000000 and phone <9999999999),
Email varchar(50),
City varchar(50),
RewardPoints int check (RewardPoints > 0 and RewardPoints < 10000),
RegisteredDate date,
Operation varchar(3),
RecordDateTime datetime
)

Exec sp_rename 'ConsumersAudit.RecordDateTime', 'EventDateTime', 'COLUMN';
Exec sp_rename 'ConsumersAudit.Operation', 'Event', 'COLUMN';


Drop Table ConsumersAudit

--Creating Trigger to track values inserted
Create Trigger trgAfterInsert On Consumers
After Insert
As
Set NoCount On;
Begin
Insert Into ConsumersAudit
Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'INS', GetDate()
From inserted i
End

Disable Trigger trgAfterInsert On Consumers

Drop Trigger trgAfterInsert

INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Zachary', 'Ansi', 'm', 1526843790, 'zachary.ansi@email.com', 'Austin', 700, '2024-05-02')

Select * from Consumers
Select * from ConsumersAudit

--creating trigger to track insertions, deletions and updations

Create Trigger trgAfterInsertOrDeleteOrUpdate On Consumers
After Insert, Delete, Update
As
Set NoCount On;
Begin

Insert Into ConsumersAudit

Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'INS', GetDate()
From inserted as i

Union All

Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'DEL', GetDate()
From deleted as i	

End

Disable Trigger trgAfterInsertOrDeleteOrUpdate On Consumers

Drop Trigger trgAfterInsertOrDeleteOrUpdate

--Testing trigger
Delete From Consumers Where Email = 'zachary.ansi@email.com'

Delete From Consumers Where Phone = 1234567890 and Email = 'bob.nguyen@email.com'



--Insight
--Trigger can be created without creating the repective audit table.
--But the insert query can't be executed in this case.
--And delete query will be executed but data will not be deleted.

--Checking the trigger with update event as well
Update Consumers
Set Phone = 1526843790
Where Phone = 1234567890 and Email = 'bob.nguyen@email.com'

Select * from ConsumersAudit

--Altering Trigger to check for deletion first
Alter Trigger trgAfterInsertOrDeleteOrUpdate On Consumers
After Insert, Delete, Update
As
Set NoCount On;
Begin

Insert Into ConsumersAudit

Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'DEL', GetDate()
From deleted as i

Union All

Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'INS', GetDate()
From inserted as i

End

--The order in Union all determines how you order of insertion into sudit table, critical when updating the main table.
Update Consumers
Set Phone = 1234567890 
Where Phone = 1526843790 and Email = 'bob.nguyen@email.com'

Select * from ConsumersAudit

--Altering trigger to include rollback

Alter Trigger trgAfterInsertOrDeleteOrUpdate On Consumers
After Insert, Delete, Update
As
Set NoCount On;
Begin

	Declare @RP As int
	Select @RP = i.RewardPoints From inserted i	

	If (@RP) > 5000
		Begin
		Print 'RP can''t be more than 5000'
		Rollback
		End
	Else
		Begin
		Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'DEL', GetDate()
		From deleted as i

		Union All

		Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'INS', GetDate()
		From inserted as i
	End
End

--Checking after above alteration
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Zachary', 'Ansi', 'm', 1526843790, 'zachary.ansi@email.com', 'Austin', 7000, '2024-05-02')

--using update function in the trigger
Alter Trigger trgAfterInsertOrDeleteOrUpdate On Consumers
After Insert, Delete, Update
As
Set NoCount On;
Begin

	Declare @RP As int
	Select @RP = i.RewardPoints From inserted i	

	If Update(RewardPoints)
		Begin
			Print 'RP can no longer be updated'
		Rollback
		End
	Else
		Begin
			Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'DEL', GetDate()
		From deleted as i

		Union All

		Select i.CustomerID, i.FirstName, i.LastName,i.Gender,i.Phone, i.Email, i.City,i.RewardPoints, i.RegisteredDate, 'INS', GetDate()
		From inserted as i
	End
End

--
Update Consumers
Set RewardPoints = 1000
Where CustomerID = 2

Disable Trigger trgAfterInsertOrDeleteOrUpdate on Consumers

--******************************************************************************
--INSTEAD OF (can be used to allow insertion of certain values in a table that are not in other table)
--An INSTEAD OF trigger is a trigger that allows you to skip an INSERT, DELETE, or UPDATE
--statement to a table or a view and execute other statements defined in the trigger instead.
--The actual insert, delete, or update operation does not occur at all.