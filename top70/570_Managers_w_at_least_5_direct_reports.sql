DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
	id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    managerId INT,
    primary key (id)
); 
INSERT INTO Employee (id,name,department,managerId)
VALUES 
	(101,'John','A',DEFAULT),
	(102, 'Dan'    , 'A', 101),
	(103, 'James' , 'A' ,101),
	(104, 'Amy'  , 'A' ,102),
	(105, 'Anne' , 'A', 102),
	(106, 'Ron'  , 'B',101);

SELECT * FROM Employee;

-- find count of unique managerIds, keep ones > 5
SELECT name FROM Employee 
WHERE id IN
(
SELECT managerId
FROM
(
SELECT managerId, COUNT(managerId) AS direct_reports
FROM Employee 
GROUP BY managerId) t
WHERE t.direct_reports>=5
)

-- KEY INSIGHT: subqueries, IN instead of = when multiple values involved
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/submissions/