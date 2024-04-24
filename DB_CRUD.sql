CREATE DATABASE LocalDB
USE LocalDB

CREATE TABLE Details (user_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, user_name varchar(50) NOT NULL, user_age VARCHAR(50) NOT NULL);
SELECT * FROM Details

INSERT INTO Details(user_name,user_age) VALUES('Shoaib',24)

SELECT * FROM Details

UPDATE Details
SET user_name = 'Akash', user_age = 23
WHERE user_id = 2

DELETE FROM Details
WHERE user_id = 2

SELECT * FROM sys.databases

SELECT * FROM sys.tables