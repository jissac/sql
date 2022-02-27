-- DROP TABLE IF EXISTS Department;
-- CREATE TABLE Department (
-- 	dept_id INT,
--     dept_name VARCHAR(50),
--     PRIMARY KEY (dept_id)
-- );

-- DROP TABLE IF EXISTS Student;
-- CREATE TABLE Student (
-- 	student_id INT,
--     student_name VARCHAR(50),
--     gender VARCHAR(2),
--     dept_id INT,
--     primary key (student_id),
--     foreign key (dept_id) REFERENCES Department(dept_id)
-- ); 

-- INSERT INTO Department (dept_id,dept_name)
-- VALUES 
-- 	(1, 'ENGINEERING'),
--     (2, 'NATURAL SCIENCE'),
--     (3, 'LITERATURE'),
--     (4, 'LAW');
--     
-- INSERT INTO Student (student_id,student_name,gender,dept_id)
-- VALUES 
-- 	(1, 'Jackey', 'F', 1),
--     (2, 'John', 'M', 4),
--     (3, 'Monk', 'M', 3);
SELECT t.dept_name, (COUNT(student_id)) AS student_number
FROM
(
SELECT dept_name,student_id FROM Department d
LEFT JOIN Student s
ON d.dept_id = s.dept_id
) t
GROUP BY t.dept_name
ORDER BY student_number DESC, dept_name

-- KEY INSIGHT: just get started, LEFT OUTER JOIN vs INNER JOIN, Group by , subqueries!, start inside out
-- https://leetcode.com/problems/count-student-number-in-departments/
