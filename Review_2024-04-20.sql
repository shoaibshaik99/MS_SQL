--Modify an existing table by adding, modifying, or dropping columns or constraints.
--Deletes an existing table and all its data.
--Inserts new rows into a table.
--Modifies existing rows in a table.
--Removes rows from a table.
--Deletes all rows from a table while keeping the table structure intact.

USE LocalDB

CREATE TABLE MyTable (Id INT, PersonName VARCHAR(50))
SELECT * FROM MyTable

INSERT INTO MyTable(Id, PersonName) VALUES (1, 'Alex')

--Now I have an existing table in the DB

ALTER TABLE MyTable
ADD City varchar(50)

ALTER TABLE MyTable
DROP COLUMN City

DROP TABLE MyTable

INSERT INTO MyTable(Id, PersonName) VALUES (2, 'Bob')

UPDATE MyTable
SET Id = 5, PersonName = 'Charlie'
WHERE Id = 2

DELETE FROM MyTable
WHERE PersonName = 'Charlie'

TRUNCATE TABLE MyTable;

