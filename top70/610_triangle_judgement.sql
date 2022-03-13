-- KEY INSIGHT: In Math, three segments can form a triangle only if 
-- the sum of any of the two segments is larger than the third one. 
-- (In other words, the subtraction of any of the two segments are smaller than the third one.)


SELECT 
	x,
    y,
    z,
    CASE 
		WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes' 
        ELSE 'No'
	END AS 'triangle'
FROM 
	Triangle