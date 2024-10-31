
DROP TABLE IF EXISTS employees_history;
DROP TABLE IF EXISTS employees_able;
drop table IF EXISTS departments_table;
DROP table IF EXISTS sales_table;

create table departments_table
(
	dept_id		int ,
	dept_name	varchar(50) PRIMARY KEY,
	location	varchar(100)
);
insert into departments_table values (1, 'Admin', 'Bangalore');
insert into departments_table values (2, 'HR', 'Bangalore');
insert into departments_table values (3, 'IT', 'Bangalore');
insert into departments_table values (4, 'Finance', 'Mumbai');
insert into departments_table values (5, 'Marketing', 'Bangalore');
insert into departments_table values (6, 'Sales', 'Mumbai');

CREATE TABLE employees_table
(
    EMP_ID      INT PRIMARY KEY,
    EMP_NAME    VARCHAR(50) NOT NULL,
    DEPT_NAME   VARCHAR(50) NOT NULL,
    SALARY      INT,
    constraint fk_emp foreign key(dept_name) references departments_table(dept_name)
);
insert into employees_table values(101, 'Mohan', 'Admin', 4000);
insert into employees_table values(102, 'Rajkumar', 'HR', 3000);
insert into employees_table values(103, 'Akbar', 'IT', 4000);
insert into employees_table values(104, 'Dorvin', 'Finance', 6500);
insert into employees_table values(105, 'Rohit', 'HR', 3000);
insert into employees_table values(106, 'Rajesh',  'Finance', 5000);
insert into employees_table values(107, 'Preet', 'HR', 7000);
insert into employees_table values(108, 'Maryam', 'Admin', 4000);
insert into employees_table values(109, 'Sanjay', 'IT', 6500);
insert into employees_table values(110, 'Vasudha', 'IT', 7000);
insert into employees_table values(111, 'Melinda', 'IT', 8000);
insert into employees_table values(112, 'Komal', 'IT', 10000);
insert into employees_table values(113, 'Gautham', 'Admin', 2000);
insert into employees_table values(114, 'Manisha', 'HR', 3000);
insert into employees_table values(115, 'Chandni', 'IT', 4500);
insert into employees_table values(116, 'Satya', 'Finance', 6500);
insert into employees_table values(117, 'Adarsh', 'HR', 3500);
insert into employees_table values(118, 'Tejaswi', 'Finance', 5500);
insert into employees_table values(119, 'Cory', 'HR', 8000);
insert into employees_table values(120, 'Monica', 'Admin', 5000);
insert into employees_table values(121, 'Rosalin', 'IT', 6000);
insert into employees_table values(122, 'Ibrahim', 'IT', 8000);
insert into employees_table values(123, 'Vikram', 'IT', 8000);
insert into employees_table values(124, 'Dheeraj', 'IT', 11000);


CREATE TABLE employees_history
(
    emp_id      INT PRIMARY KEY,
    emp_name    VARCHAR(50) NOT NULL,
    dept_name   VARCHAR(50),
    salary      INT,
    location    VARCHAR(100),
    constraint fk_emp_hist_01 foreign key(dept_name) references departments_table(dept_name),
    constraint fk_emp_hist_02 foreign key(emp_id) references employees_table(emp_id)
);

create table sales_table
(
	store_id  		int,
	store_name  	varchar(50),
	product_name	varchar(50),
	quantity		int,
	price	     	int
);
insert into sales_table values
(1, 'Apple Store 1','iPhone 13 Pro', 1, 1000),
(1, 'Apple Store 1','MacBook pro 14', 3, 6000),
(1, 'Apple Store 1','AirPods Pro', 2, 500),
(2, 'Apple Store 2','iPhone 13 Pro', 2, 2000),
(3, 'Apple Store 3','iPhone 12 Pro', 1, 750),
(3, 'Apple Store 3','MacBook pro 14', 1, 2000),
(3, 'Apple Store 3','MacBook Air', 4, 4400),
(3, 'Apple Store 3','iPhone 13', 2, 1800),
(3, 'Apple Store 3','AirPods Pro', 3, 750),
(4, 'Apple Store 4','iPhone 12 Pro', 2, 1500),
(4, 'Apple Store 4','MacBook pro 16', 1, 3500);
