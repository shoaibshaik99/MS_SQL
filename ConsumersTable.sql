create table Consumers
(
CustomerID int identity(1,1) primary key not null,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Gender varchar check(gender = 'm' or gender = 'f'),
Phone bigint check(phone>1000000000 and phone <9999999999),
Email varchar(50),
City varchar(50),
RewardPoints int check (RewardPoints > 0 and RewardPoints < 10000),
RegisteredDate date
);

-- Inserting duplicates in FirstName
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Alice', 'Smith', 'f', 1234567890, 'alice.smith@email.com', 'New York', 500, '2023-01-15'),
('Alice', 'Johnson', 'm', 9876543210, 'alice.johnson@email.com', 'Los Angeles', 700, '2022-07-22'),
('Bob', 'Brown', 'f', 5551234567, 'bob.brown@email.com', 'Chicago', 200, '2023-11-30'),
('Bob', 'Lee', 'm', 1239876543, 'bob.lee@email.com', 'Houston', 300, '2022-05-10'),
('Carol', 'Garcia', 'f', 4567890123, 'carol.garcia@email.com', 'Miami', 800, '2023-08-05');

-- Inserting duplicates in LastName
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('David', 'Smith', 'm', 7890123456, 'david.smith@email.com', 'San Francisco', 600, '2022-09-18'),
('Eva', 'Smith', 'f', 9876543210, 'eva.smith@email.com', 'New York', 900, '2023-04-25'),
('Frank', 'Smith', 'm', 1234567890, 'frank.smith@email.com', 'Los Angeles', 400, '2022-12-10'),
('Grace', 'Johnson', 'f', 5551234567, 'grace.johnson@email.com', 'Chicago', 150, '2023-02-28'),
('Henry', 'Johnson', 'm', 1239876543, 'henry.johnson@email.com', 'Houston', 750, '2023-10-15');

-- Inserting duplicates in Gender
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Isabel', 'Garcia', 'f', 4567890123, 'isabel.garcia@email.com', 'Miami', 550, '2023-06-20'),
('Jack', 'Lee', 'm', 7890123456, 'jack.lee@email.com', 'San Francisco', 650, '2022-08-12'),
('Karen', 'Brown', 'f', 9876543210, 'karen.brown@email.com', 'New York', 850, '2023-03-17'),
('Larry', 'Nguyen', 'm', 1234567890, 'larry.nguyen@email.com', 'Los Angeles', 950, '2023-09-08'),
('Mary', 'Lee', 'f', 5551234567, 'mary.lee@email.com', 'Chicago', 250, '2023-12-01');

-- Inserting duplicates in Phone
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Nancy', 'Smith', 'f', 1234567890, 'nancy.smith@email.com', 'Houston', 700, '2023-07-14'),
('Oscar', 'Johnson', 'm', 9876543210, 'oscar.johnson@email.com', 'Miami', 400, '2022-11-29'),
('Peter', 'Garcia', 'f', 5551234567, 'peter.garcia@email.com', 'San Francisco', 300, '2023-05-06'),
('Quinn', 'Nguyen', 'm', 1239876543, 'quinn.nguyen@email.com', 'New York', 150, '2023-01-02'),
('Rachel', 'Brown', 'f', 1234567890, 'rachel.brown@email.com', 'Los Angeles', 250, '2022-12-28');

-- Inserting duplicates in Email
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Sam', 'Lee', 'm', 7890123456, 'sam.lee@email.com', 'Chicago', 850, '2023-03-09'),
('Tina', 'Johnson', 'f', 9876543210, 'tina.johnson@email.com', 'Houston', 950, '2023-08-22'),
('Uma', 'Smith', 'f', 5551234567, 'uma.smith@email.com', 'Miami', 650, '2022-10-17'),
('Victor', 'Garcia', 'm', 1234567890, 'victor.garcia@email.com', 'San Francisco', 750, '2023-04-14'),
('Wendy', 'Nguyen', 'f', 1239876543, 'wendy.nguyen@email.com', 'New York', 550, '2023-11-30');

-- Inserting duplicates in City
INSERT INTO Consumers (FirstName, LastName, Gender, Phone, Email, City, RewardPoints, RegisteredDate)
VALUES 
('Xavier', 'Johnson', 'm', 4567890123, 'xavier.johnson@email.com', 'Los Angeles', 450, '2023-02-12'),
('Yolanda', 'Smith', 'f', 7890123456, 'yolanda.smith@email.com', 'Miami', 850, '2022-12-05'),
('Zack', 'Brown', 'm', 9876543210, 'zack.brown@email.com', 'New York', 950, '2023-07-18'),
('Alice', 'Garcia', 'f', 5551234567, 'alice.garcia@email.com', 'San Francisco', 550, '2023-09-21'),
('Bob', 'Nguyen', 'm', 1234567890, 'bob.nguyen@email.com', 'Chicago', 750, '2022-11-14');
