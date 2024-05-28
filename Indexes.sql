-- Assume we have a 'Users' table in our 'PracticeDB' database
USE PracticeDB;
GO

-- Create a 'Users' table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    City VARCHAR(50) NOT NULL
);
GO

-- Insert some sample data into 'Users' table
INSERT INTO Users (Username, Email, Age, City)
VALUES 
('Alice', 'alice@example.com', 25, 'New York'),
('Bob', 'bob@example.com', 30, 'Los Angeles'),
('Charlie', 'charlie@example.com', 22, 'Chicago');
GO

-- Create a non-clustered index on the 'City' column
CREATE NONCLUSTERED INDEX IX_Users_City ON Users(City);
GO

-- Create a clustered index on the 'Age' column
-- Note: We can only have one clustered index per table, and it reorganizes the table data.
-- If the table already has a clustered index, we need to drop it before creating a new one.
CREATE CLUSTERED INDEX IX_Users_Age ON Users(Age);
GO

-- Query to find users in 'New York' using the non-clustered index
SELECT * FROM Users WHERE City = 'New York';
GO

-- Query to find users aged 25 using the clustered index
SELECT * FROM Users WHERE Age = 25;
GO

--******************************************************************************************

-- Use the 'PracticeDB' database
USE PracticeDB;
GO

-- Create a 'LargeDataTable' table
CREATE TABLE LargeDataTable (
    ID INT PRIMARY KEY IDENTITY(1,1),
    RandomNumber INT,
    RandomString VARCHAR(50),
    EntryDate DATETIME DEFAULT GETDATE()
);
GO

-- Declare variables for the while loop
DECLARE @RowCount INT = 0;
DECLARE @MaxRows INT = 1000000; -- 1 million rows
DECLARE @RandomNumber INT;
DECLARE @RandomString VARCHAR(50);

-- Begin inserting rows using a while loop
BEGIN TRANSACTION; -- Start a transaction to batch the insert operation
WHILE @RowCount < @MaxRows
BEGIN
    SET @RandomNumber = CAST(RAND() * 100000 AS INT); -- Generate a random number
    SET @RandomString = 'String_' + CAST(@RowCount AS VARCHAR(50)); -- Generate a random string

    INSERT INTO LargeDataTable (RandomNumber, RandomString)
    VALUES (@RandomNumber, @RandomString);

    SET @RowCount = @RowCount + 1;
END
COMMIT TRANSACTION; -- Commit the transaction after all rows are inserted
GO

-- Create a non-clustered index on the 'RandomNumber' column
CREATE NONCLUSTERED INDEX IX_LargeDataTable_RandomNumber ON LargeDataTable(RandomNumber);
GO

-- Create a non-clustered index on the 'RandomString' column
CREATE NONCLUSTERED INDEX IX_LargeDataTable_RandomString ON LargeDataTable(RandomString);
GO

-- Query to test the performance of the index
SELECT * FROM LargeDataTable WHERE RandomNumber BETWEEN 50000 AND 60000;
GO