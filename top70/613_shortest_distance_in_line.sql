DROP TABLE Point;
CREATE TABLE Point (
	x int,
    primary key (x)
);

INSERT INTO Point (x)
VALUES 
			(-1),
            (0),
            (2);
SELECT 
    MIN(ABS(p1.x-p2.x)) AS shortest
FROM Point p1
JOIN Point p2 ON p1.x != p2.x;

-- KEY INSIGHT: self join need to use alias, MIN, ABS built-in fns