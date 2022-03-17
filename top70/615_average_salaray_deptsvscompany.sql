drop table if exists Salary, Employee;
Create table If Not Exists Salary (id int, employee_id int, amount int, pay_date date);
Create table If Not Exists Employee (employee_id int, department_id int);
Truncate table Salary;
insert into Salary (id, employee_id, amount, pay_date) values ('1', '1', '9000', '2017/03/31');
insert into Salary (id, employee_id, amount, pay_date) values ('2', '2', '6000', '2017/03/31');
insert into Salary (id, employee_id, amount, pay_date) values ('3', '3', '10000', '2017/03/31');
insert into Salary (id, employee_id, amount, pay_date) values ('4', '1', '7000', '2017/02/28');
insert into Salary (id, employee_id, amount, pay_date) values ('5', '2', '6000', '2017/02/28');
insert into Salary (id, employee_id, amount, pay_date) values ('6', '3', '8000', '2017/02/28');
Truncate table Employee;
insert into Employee (employee_id, department_id) values ('1', '1');
insert into Employee (employee_id, department_id) values ('2', '2');
insert into Employee (employee_id, department_id) values ('3', '2');



-- average monthly salary for whole company
with avg_c as
(select
	avg(amount) as company_avg,
    date_format(pay_date, '%Y-%m') as pay_month
from salary
group by pay_date),

-- each department's average salary each month
avg_d as 
(select
	department_id,
	avg(amount) as dept_avg,
    date_format(pay_date, '%Y-%m') as pay_month
from salary
join employee using(employee_id)
group by department_id,pay_month)

-- join above tables and compare using CASE
select 
	pay_month,
	department_id,
	(CASE
		when dept_avg > company_avg then 'higher'
		when dept_avg < company_avg then 'lower'
		else 'same'
	END) as comparison

from avg_d
join avg_c using(pay_month)


-- KEY INSIGHT:
-- break down problem using WITH CTE expression
-- use CASE statement to select and filter values from joined cte tables


