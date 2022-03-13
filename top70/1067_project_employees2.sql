-- average is the sum of the elements / total number of elements
DROP TABLE IF EXISTS Project, Employee;
CREATE TABLE Project (
	project_id INT,
    employee_id INT,
    PRIMARY KEY (project_id,employee_id)
);

CREATE TABLE Employee (
	employee_id INT,
    name VARCHAR(50),
    experience_years INT,
    PRIMARY KEY (employee_id)
);

INSERT INTO Project(project_id, employee_id)
VALUES (1,1), (1,2),(1,3),(2,1),(2,4);

INSERT INTO Employee(employee_id,name,experience_years)
VALUES (1,'Khaled',3),(2,'Ali',2),(3,'John',1),(4,'Doe',2);




SELECT project_id
FROM Project
GROUP BY project_id
HAVING COUNT(employee_id) =
(
SELECT MAX(t1.total_employees)
FROM
(
SELECT 
	p.project_id,
    COUNT(*) as total_employees
FROM Project p
GROUP BY p.project_id
) t1
);

-- KEY INSIGHT: using the HAVING with the original max count
