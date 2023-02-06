--Creating database.

CREATE database SQL_portfolio;

-- Use database function.

Use SQL_portfolio;

-- Drop database function.

Drop database SQL_portfolio;

--Creating the table.

Create table Employee(
e_id int not null,
e_name varchar(20),
e_salary int,
e_age int,
e_gender varchar(20),
e_dept varchar(20),
primary key(e_id)
);

-- inserting values in side the table.

insert into Employee
values (1,'Sam','95000','45','Male','Operations' );

insert into Employee
values (2,'Bob','80000','21','Male','Support');

insert into Employee
values (3,'Anne','125000','25','Female','Analytics');

insert into Employee
values (4,'Julia','73000','30','Female','Analytics');

insert into Employee
values (5,'Matt','159000','33','Male','Sales');

insert into Employee
values (6,'Jeff','112000','27','Male','Operations');

-- Selecting the colums from the above table.

Select e_name, e_gender, e_salary from employee;

Select * from Employee; -- To select entire data.

-- Distinct values.

Select distinct e_gender, e_dept from employee;

--WHERE operator.

select * from employee where e_gender = 'female';

select * from employee where e_age<30;

select * from employee where e_salary>100000;

--AND operator.

select * from employee where e_gender = 'male' and e_age<30;

select * from employee where e_dept = 'Operations' and e_salary>100000;

--OR operator.

select * from employee where e_dept = 'operations' or e_dept = 'analytics';

select * from employee where e_salary>100000 or e_age>30;

-- NOT operator

Select * from employee where not e_gender = 'female';

Select * from employee where not e_age<30;

-- LIKE operator.

select * from employee where e_name like 'j%';

select * from employee where e_age like '3%';

-- BETWEEN operator.

select * from employee where e_age BETWEEN 25 AND 35;

select * from employee where e_salary BETWEEN 90000 AND 120000;

--MIN() and MAX() Function.

Select min(e_age)from employee;

Select min(e_salary)from employee;

Select max(e_age) from employee;

Select max(e_salary) from employee;

-- COUNT() Function.

select count(*) from employee where e_gender='male';

select count(*) from employee where e_gender='female';

-- SUM() and AVG() Function.

select sum(e_salary) from employee;
 
select AVG(e_salary) from employee;

-- ORDER BY function.

select * from employee order by e_salary DESC;

select top 3 * from employee order by e_age desc;

-- GROUP BY Clause.

select avg(e_salary),e_gender from employee group by e_gender;

select avg(e_age), e_dept from employee group by e_dept  order by avg(e_age);

select e_dept, avg(e_salary) as avg_salary
from employee
group by e_dept
having avg(e_salary)>100000;

--UPDATING Data.

Select * From employee

UPDATE employee
set e_age = 42
where e_name ='sam';

Update employee
set e_dept = 'Tech'
where e_gender ='female';

update employee set e_salary = 500000;

--Delete, Truncate and Drop functions.

Delete from Employee where e_age = 21;

truncate table employee;

select * from employee;

Create table Department(
d_id int ,
d_name varchar(20),
d_location varchar (20)
);

select * from Department;

insert into Department values
(1,'Content','New York'),
(2,'Support','Chicago'),
(3,'Analytics','New York'),
(4,'Sales','Boston'),
(5,'Tech','Dallas'),
(6,'Fianance','Chicago');

--Inner join.

Select employee.e_name, employee.e_dept, department.d_name, department.d_location
from employee
 INNER JOIN department
 ON employee.e_id = department.d_id

--left join.

select employee.e_name, employee.e_dept, department.d_name, department.d_location
from employee
 LEFT JOIN department
 ON employee.e_dept = department.d_name;

--Right join.

select employee.e_name, employee.e_dept, department.d_name, department.d_location
from employee
 RIGHT JOIN department
 ON employee.e_dept = Department.d_name;

 --Full join.

select employee.e_name, employee.e_dept, department.d_name, Department.d_location
 from employee
 FULL join Department
 on employee.e_dept = department.d_name;

 ---------------------------------------------------------
select * from department;
select * from employee;

update employee
set e_age=e_age+10
from employee
join department on employee.e_dept=Department.d_name
where d_location='new york';

delete employee
from employee
join department on employee.e_dept=department.d_name
where d_location='New york';

Create table student_details1(
s_id int,
s_name varchar(20),
s_marks varchar (20)
);

insert into student_details1
values (1,'Sam','45'),
(2,'Bob','87'),
(3,'Anne','73'),
(4,'Julia','92');

create table student_details2(
s_id int,
s_name varchar(20),
s_marks varchar (20)
);

insert into student_details2
values (3,'Anne','73'),
(4,'Julia','92'),
(5,'Matt','65');

Select * from student_details1
Union							-- Not indlude duplicates
select * from student_details2;

Select * from student_details1
Union all						-- Includes Duplucates
select * from student_details2;

Select * from student_details1
Except						    -- Includes Duplucates
select * from student_details2;

