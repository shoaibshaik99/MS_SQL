CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(50)
);

INSERT INTO Employees (EmployeeID, EmployeeName)
VALUES (1, 'John Doe'), (2, 'Jane Smith');

CREATE PROCEDURE GetEmployeeName
    @EmpID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmpID)
        SELECT EmployeeName FROM Employees WHERE EmployeeID = @EmpID;
    ELSE
        PRINT 'Employee not found.';
END;
--*******************************************************
CREATE PROCEDURE CalculateFactorial
    @Number INT
AS
BEGIN
    DECLARE @Result BIGINT = 1;
    DECLARE @Counter INT = 1;

    WHILE @Counter <= @Number
    BEGIN
        SET @Result *= @Counter;
        SET @Counter += 1;
    END;

    PRINT 'Factorial of ' + CAST(@Number AS NVARCHAR(10)) + ' is ' + CAST(@Result AS NVARCHAR(20));
END;
--*******************************************************
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName NVARCHAR(50)
);

CREATE PROCEDURE AddDepartment
    @DeptID INT,
    @DeptName NVARCHAR(50)
AS
BEGIN
    BEGIN
        INSERT INTO Departments (DeptID, DeptName)
        VALUES (@DeptID, @DeptName);
    END;
    PRINT 'Department added successfully.';
END;
--*******************************************************

--*******************************************************
CREATE PROCEDURE InsertData
@Data VARCHAR(255)
AS
BEGIN
    INSERT INTO YourTable (ColumnName) VALUES (@Data)
END

--*******************************************************
CREATE PROCEDURE UpdateData
@ID INT,
@NewData VARCHAR(255)
AS
BEGIN
    UPDATE YourTable SET ColumnName = @NewData WHERE ID = @ID
END
--*******************************************************
CREATE PROCEDURE DeleteData
@ID INT
AS
BEGIN
    DELETE FROM YourTable WHERE ID = @ID
END
--*******************************************************
CREATE PROCEDURE SelectData
AS
BEGIN
    SELECT * FROM YourTable
END
