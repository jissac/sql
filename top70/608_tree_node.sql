CREATE TABLE Tree (
	id INT,
    p_id INT,
    PRIMARY KEY (id)
);

INSERT INTO Tree (id, p_id)
VALUES (1,NULL),(2,1),(3,1),(4,2),(5,2);

select
	id,
	(CASE 
		when p_id is null then 'Root'
        when id in (select p_id from Tree) then 'Inner'
        else 'Leaf'
	 END) as type
from
	Tree
order by id


-- KEY INSIGHT:
-- the subquery inside the CASE, if the id is in the parent id col, then it is a parent, hence an inner