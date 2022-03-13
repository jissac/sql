DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
	`order_number` INT,
    `customer_number` INT,
    PRIMARY KEY (`order_number`)
);
 INSERT INTO  `Orders` (`order_number`,`customer_number`)
	VALUES 
		(1,1),
		(2,1),
        (3,2),
        (4,3);

SELECT * FROM Orders;

SELECT t.customer_number
FROM
(
SELECT customer_number, COUNT(order_number) AS num_ordered
FROM Orders o
GROUP BY customer_number
ORDER BY num_ordered DESC
) t
LIMIT 1

-- KEY INSIGHT: ORDER BY DESC to get the highest value first, then LIMIT 1, subqueries!
-- https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/submissions/