--List all databses in the server
SELECT * FROM sys.databases

--Comprehensive list of all objects in the current database, regardless of their type.
SELECT * FROM sys.all_objects

--List all the tables in current database
SELECT * FROM sys.tables

--using database named LocalDB 
USE LocalDB

--List all Tables in current databse using SQL Server
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

--List all Tables in a specific database databse
SELECT TABLE_NAME
FROM LocalDB.INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
-------------------------------------------------------------
--Some of The Most Important SQL Commands
--SELECT - extracts data from a database
--UPDATE - updates data in a database
--DELETE - deletes data from a database
--INSERT INTO - inserts new data into a database
--CREATE DATABASE - creates a new database
--ALTER DATABASE - modifies a database
--CREATE TABLE - creates a new table
--ALTER TABLE - modifies a table
--DROP TABLE - deletes a table
--CREATE INDEX - creates an index (search key)
--DROP INDEX - deletes an index
-------------------------------------------------------------
