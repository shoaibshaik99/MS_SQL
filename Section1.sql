use LocalDB;

create table consumers
(
customer_id int identity(1,1) primary key not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar check(gender = 'm' or gender = 'f'),
phone int check(phone>1000000000 and phone <9999999999),
email varchar(50),
city varchar(50)
);

insert into consumers values('Alice', 'Spence', 'f',1234567890,'alice.spence@email.com','Phoenix')
insert into consumers values('Ana', 'Newman', 'f',null,'alice.spence@email.com','Phoenix')
INSERT INTO consumers VALUES('Bob', 'Smith', 'm',987654321,'bob.smith@email.com','New York'),
('Carol', 'Johnson', 'f',null,'carol.johnson@email.com','Los Angeles');

INSERT INTO consumers VALUES('Carol', 'Johnson', 'f',null,'carol.johnson@email.com','Los Angeles');

-- Data Entry 3
INSERT INTO consumers VALUES('David', 'Brown', 'm',5551234567,'david.brown@email.com','Chicago');

-- Data Entry 4
INSERT INTO consumers VALUES('Eva', 'Garcia', 'f',null,'eva.garcia@email.com','Miami');

-- Data Entry 5
INSERT INTO consumers VALUES('Frank', 'Lee', 'm',1239876543,'frank.lee@email.com','Houston');

-- Data Entry 6
INSERT INTO consumers VALUES('Grace', 'Martinez', 'f',null,'grace.martinez@email.com','San Francisco');

-- Data Entry 7
INSERT INTO consumers VALUES('Henry', 'Nguyen', 'm',null,'henry.nguyen@email.com','Seattle');

-- Data Entry 8
INSERT INTO consumers VALUES('Isabel', 'Chen', 'f',4567890123,'isabel.chen@email.com','Boston');

-- Data Entry 9
INSERT INTO consumers VALUES('Jack', 'Thompson', 'm',null,'jack.thompson@email.com','Denver');

-- Data Entry 10
INSERT INTO consumers VALUES('Karen', 'Wang', 'f',null,'karen.wang@email.com','Atlanta');


update consumers
set gender  = 'f'
where customer_id = 1;

update consumers
set email  = 'alice.spence@email.com'
where customer_id = 1;


--do not use the SELECT * for production code as it retreives more data than necessary and few more reasons
select * from consumers;

select first_name,last_name from consumers;

select first_name,last_name,email from consumers;

select * from consumers where customer_id =2;