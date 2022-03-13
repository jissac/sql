DROP TABLE IF EXISTS Cinema;
CREATE TABLE Cinema (
	seat_id INT AUTO_INCREMENT,
    free BOOL,
    PRIMARY KEY (seat_id)
);

INSERT INTO Cinema (seat_id,free)
VALUES
	(1,1),
    (2,0),
    (3,1),
    (4,1),
    (5,1);
    
SELECT * FROM Cinema;

SELECT 
    seat_id
FROM 
(SELECT 
	seat_id,
    free,
    LEAD(free,1,false) OVER(ORDER BY seat_id) AS next_free,
    LAG(free,1,false) OVER(ORDER BY seat_id) AS prev_free
FROM Cinema) AS t1
WHERE t1.free = 1 AND (t1.next_free = 1 OR t1.prev_free = 1) 
ORDER BY seat_id

-- KEY INSIGHT: add LAG and LEAD window fns to add columns to main table, then use logical operators
-- AND OR to select seat_ids, subqueries!
-- https://leetcode.com/problems/consecutive-available-seats/submissions/
