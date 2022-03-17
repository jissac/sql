DROP table if exists Employee;
Create table If Not Exists Employee (employee_id int, team_id int);
Truncate table Employee;
insert into Employee (employee_id, team_id) values ('1', '8');
insert into Employee (employee_id, team_id) values ('2', '8');
insert into Employee (employee_id, team_id) values ('3', '8');
insert into Employee (employee_id, team_id) values ('4', '7');
insert into Employee (employee_id, team_id) values ('5', '9');
insert into Employee (employee_id, team_id) values ('6', '9');


-- using subquery and join
select e.employee_id, ts.team_size
from employee e
join
(
select 
team_id,
count(team_id) as team_size
from Employee
group by team_id
) ts
using (team_id);


-- using window function
select 
	employee_id,
    count(*) over(partition by team_id) as team_size
from employee


-- KEY INSIGHT:
-- if can't think of a solution, think of all related operations possible and then answer will appear
-- window function - aggregates rows and produces result for each query row unlike a group by
