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

--

Update Consumers
Set Phone = 1234567890 
Where Phone = 1526843790 and Email = 'bob.nguyen@email.com'

Select * from ConsumersAudit