CREATE TABLE Employees (
	employee_id INT,
    employee_name varchar(50),
    manager_id INT,
    primary key (employee_id)
);

INSERT INTO Employees (employee_id,employee_name,manager_id) 
	VALUES (1, 'Boss', 1),
			(3, 'Alice', 3),
            (2, 'Bob', 1),
            (4, 'Daniel',2),
            (7, 'Luis', 4),
            (8, 'Jhon', 3),
            (9, 'Angela', 8),
            (77, 'Robert', 1);

-- Subquery solution
select employee_id from Employees where manager_id IN
(select employee_id from Employees where manager_id IN
(select employee_id from Employees where manager_id = 1))
AND employee_id != 1;

-- Self joins
select 
	e1.employee_id
from 
	Employees e1
join Employees e2 on e1.manager_id = e2.employee_id
join Employees e3 on e2.manager_id = e3.employee_id
where e3.manager_id = 1 and e1.employee_id !=1



-- KEY INSIGHT:
-- nested subqueries
-- self joins for heirarchical data, draw it out, each join exposes the level above