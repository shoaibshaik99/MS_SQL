--Scope of a trigger  can be on all server or a specific database

--Prevent some specific changes to the database schema.
USE LocalDB
--Trigger to restrict table creation
CREATE TRIGGER trgRestrictTables
ON DATABASE
FOR Create_Table
As
Begin
	Print 'Table creation not allowed in this database'
	RollBack Transaction
End
--Table will be not created
Create Table Table1(Id int)
--Altering Trigger to restrict table creation, updation and deletion
Alter Trigger trgRestrictTables
On Database
For Create_Table, ALter_Table, Drop_Table
As
Begin
	Print 'Creating, Altering and Deleting Table is prohibited in this database'
	RollBack Transaction
End
--Table will not be dropped
Drop Table MyTable
--Dropping Trigger
Drop Trigger trgRestrictTables On Database
--Altering trgRestrictTables trigger Using DDL Event Groups for table
Alter Trigger trgRestrictTables
On Database
For DDL_Table_Events
As
Begin
	Print 'Creating, Altering and Deleting Table is prohibited in this database'
	RollBack Transaction
End
--Checking
Create Table Table1(Id int)

Alter Table Mytable
Add AColumn char

Drop Table MyTable
--Server scoped trigger
Create Trigger trgServerRestrictions
On All Server
For DDL_Table_Events
As
Begin
	Print 'Creating, Altering and Deleting Table is prohibited in this Server'
	Rollback Transaction
End
--Creating fee databases
Create Database db1
Create Database db2
Create Database db3
--Trying Table events in different databases
--db1
Use LocalDB
Create Table Table1(ID int)
--db2
Use db2
Create Table Table1(ID int)
--db3
Use db3
Create Table Table1(ID int)
--Resetting things !
Drop Database db1, db2, db3
--Droppingthe trigger in the database
Drop Trigger trgServerRestrictions On All Server

--**********************************
--Record changes in the database schema.
--EventData() function will be used, it returns xml type.
Use LocalDB
Create Table AuditTable(
LogId int Identity(1,1) Primary Key,
DatabaseName varchar(250),
TableName varchar(250),
EventType varchar(250),
LoginName varchar(50), --To log the user
SQLCommand varchar(250),
AuditDateTime varchar(250)
)
--Drop Table AuditTable
--Trigger to record activity in databases using event groups
Alter Trigger trgAuditTableChangesInAllDatabases
On All Server
For DDL_Table_Events
As
Begin
	Declare @EventData XML
	Select @EventData = EventData(); --Set @EventData = EventData();
	--Declare @EventData XML = EventData();
	Insert Into [Laptop\SQLEXPRESS].[LocalDB].[dbo].[AuditTable](DatabaseName, TableName,EventType,LoginName,SQLCommand,AuditDateTime)
	Values(
	@EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]','varchar(250)'),
	@EventData.value('(/EVENT_INSTANCE/TableName)[1]','varchar(250)'),
	@EventData.value('(/EVENT_INSTANCE/EventType)[1]','varchar(250)'),
	@EventData.value('(/EVENT_INSTANCE/LoginName)[1]','varchar(50)'),
	@EventData.value('(/EVENT_INSTANCE/SQLCommand)[1]','varchar(250)'),
	GETDATE()
	)
End

Use LocalDB
Create Table Table1(id int)
Drop Table Table1

Select * from AuditTable

Disable Trigger trgAuditTableChangesInAllDatabases On All Server
--***********************************************************************************************
CREATE TABLE index_logs(
	log_id INT IDENTITY(1,1) PRIMARY KEY,
	event_data XML NOT NULL,
	changed_by SYSNAME NOT NULL
)