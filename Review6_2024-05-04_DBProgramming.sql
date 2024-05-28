--1) create a procedure , check id of user. if exist update the data else insert the data

Create Table Users (
    UserId int Primary Key Identity(1,1),
    UserData nvarchar(max)
);

Drop Table Users

Insert Into Users (UserData) values ('Sample Data 1');
Insert Into Users (UserData) values ('Sample Data 2');
Insert Into Users (UserData) values ('Sample Data 3');

--Drop table users

Create Proc usp_InsertUserData
    @UserId int,
    @NewData nvarchar(max)
As
Begin

    If Exists (Select 1 From Users Where UserId = @UserId)
    Begin
        update Users
        Set UserData = @NewData
        Where UserId = @UserId;
    End
    
	Else
    Begin
        Insert Into Users (UserData)
        Values (@NewData);
    End
End

Drop Proc usp_InsertUserData

--Execution
-- Update data for an existing user
Exec usp_InsertUserData @UserId = 1, @NewData = 'Updated Data User 1';

-- Insert data for a new user
Exec usp_InsertUserData @UserId = 4, @NewData = 'Sample Data for User 4';

Select * From Users

--2) perform any one type of trigger on table of your choice
--Using the above users table itself

-- Create an UsersAuditTable to store changes
Create Table UsersAuditTable(
    AuditId int Primary Key Identity(1,1),
    UserId int,
    OldData nvarchar(max),
    NewData nvarchar(max),
    UpdateDate datetime Default GetDate()
);

Drop Table UsersAuditTable

Drop Trigger trg_AuditUserUpdate

Create Trigger trg_AuditUserUpdate
On Users
After Update
As
Begin
    Insert Into UsersAuditTable (UserId, OldData, NewData)
    select deleted.UserId, deleted.UserData, inserted.UserData
    from inserted
    inner join deleted on inserted.UserId = deleted.UserId;
end

Update Users
Set UserData  = 'trgData'
Where UserID = 1

Insert Into Users (UserData) values ('Sample Data 6');

Select * From Users;
Select * From UsersAuditTable;

--3) Consider three tables, Employees with columns EmployeeID, FirstName, LastName,
--Projects with columns ProjectID and ProjectName,
--and Assignments with columns AssignmentID, EmployeeID, and ProjectID. Write SQL queries to:

--Drop Table Employees
Create Table Employees (
    EmployeeID int Primary Key Identity(1,1),
    FirstName nvarchar(50),
    LastName nvarchar(50)
);
Insert Into Employees (FirstName, LastName) Values ('John', 'Doe');
Insert Into Employees (FirstName, LastName) Values ('Jane', 'Smith');
Insert Into Employees (FirstName, LastName) Values ('Emily', 'Jones');

Create Table Projects (
    ProjectID int Primary Key Identity(1,1),
    ProjectName nvarchar(100)
);
Insert Into Projects (ProjectName) Values ('Project Alpha');
Insert Into Projects (ProjectName) Values ('Project Beta');
Insert into Projects (ProjectName) Values ('Project Gamma');

Create Table Assignments (
    AssignmentID int Primary Key Identity(1,1),
    EmployeeID int,
    ProjectID int,
    Foreign Key (EmployeeID) References Employees(EmployeeID),
    Foreign Key (ProjectID) References Projects(ProjectID)
);
Insert Into Assignments (EmployeeID, ProjectID) Values (1, 1);
Insert Into Assignments (EmployeeID, ProjectID) Values (2, 2);
Insert Into Assignments (EmployeeID, ProjectID) Values (3, 3);

--Retrieve a list of all employees with their corresponding assigned projects.
Select e.EmployeeID, e.FirstName, e.LastName, p.ProjectName
From Employees e Inner Join Assignments a On e.EmployeeID = e.EmployeeID Inner Join Projects p On a.ProjectID  = p.ProjectID

--Select employees along with the project information for a specific project.
Select e.EmployeeID, e.FirstName, e.LastName, p.ProjectName
From Employees e Inner Join Assignments a On e.EmployeeID = a.EmployeeID Inner Join Projects p on a.ProjectID = p.ProjectID Where p.ProjectID = 2

--4)Consider a table named Students with columns StudentID, FirstName, LastName, Address, PhoneNumber, and DateOfBirth.
--normalize it

--Rough
--Students - StudentID, FirstName, LastName, DOB
--StudentContactDetails - StudentID, Address, PhoneNumber

Create Table Students (
    StudentID int primary key,
    FirstName nvarchar(50),
    LastName nvarchar(50),
    DateOfBirth date
);

Create Table StudentContactDetails (
    StudentID int primary key references Students(StudentID),
    Address nvarchar(255),
    PhoneNumber nvarchar(20)
);

--Further Normalisation
Create Table Students (
    StudentID int primary key,
    FirstName nvarchar(50),
    LastName nvarchar(50),
    DateOfBirth date
);

-- Addresses table with address information
Create Table Addresses (
    AddressID int Primary Key Identity(1,1),
    StudentID int Foreign Key References Students(StudentID),
	LandMarks nvarchar(max),
    Street nvarchar(100),
    City nvarchar(50),
    ZipCode nvarchar(10),
    Country nvarchar(50)
);

-- ContactInfo table with contact information
Create Table ContactDetails (
    StudentID int foreign Key References Students(StudentID),
    PhoneNumber nvarchar(15)
);