Create table If Not Exists Departments (id int, name varchar(30));
Create table If Not Exists Students (id int, name varchar(30), department_id int);
Truncate table Departments;
insert into Departments (id, name) values ('1', 'Electrical Engineering');
insert into Departments (id, name) values ('7', 'Computer Engineering');
insert into Departments (id, name) values ('13', 'Bussiness Administration');
Truncate table Students;
insert into Students (id, name, department_id) values ('23', 'Alice', '1');
insert into Students (id, name, department_id) values ('1', 'Bob', '7');
insert into Students (id, name, department_id) values ('5', 'Jennifer', '13');
insert into Students (id, name, department_id) values ('2', 'John', '14');
insert into Students (id, name, department_id) values ('4', 'Jasmine', '77');
insert into Students (id, name, department_id) values ('3', 'Steve', '74');
insert into Students (id, name, department_id) values ('6', 'Luis', '1');
insert into Students (id, name, department_id) values ('8', 'Jonathan', '7');
insert into Students (id, name, department_id) values ('7', 'Daiana', '33');
insert into Students (id, name, department_id) values ('11', 'Madelynn', '1');


select s.id, s.name
from students s
left join departments d on d.id = s.department_id
where d.name is null

-- KEY INSIGHT:
-- the column names were diff so need to alias and use ON instead of USING