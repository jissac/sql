Explain SELECT points FROM customers where points>1000;
CREATE INDEX idx_points ON customers (points);

SHOW INDEXES in customers;

ANALYZE TABLE customers;

CREATE INDEX idx_lastname ON customers (last_name(20));

-- full text index
CREATE FULLTEXT INDEX idx_title_body ON posts (title, body) ;
SELECT *, MATCH(title, body) AGAINST('react redux') AS relevancy_score
FROM posts
WHERE MATCH(title, body) AGAINST('react redux');

-- full text in boolean mode to exclude/include items
SELECT *, MATCH(title, body) AGAINST('react redux') AS relevancy_score
FROM posts
WHERE MATCH(title, body) AGAINST('react -redux +form' IN BOOLEAN MODE);

-- full text exact phrase
SELECT *, MATCH(title, body) AGAINST('react redux') AS relevancy_score
FROM posts
WHERE MATCH(title, body) AGAINST("handling a form" IN BOOLEAN MODE);

-- Composite Index
USE sql_store;
SHOW INDEXES in customers;
EXPLAIN SELECT customer_id FROM customers 
WHERE state = 'CA' AND points > 1000;

CREATE INDEX idx_state_points ON customers (state, points);
EXPLAIN SELECT customer_id FROM customers 
WHERE state = 'CA' AND points > 1000;

-- When indexes are ignored
EXPLAIN SELECT customer_id FROM customers
WHERE points > 2000;
-- vs
EXPLAIN SELECT customer_id FROM customers
WHERE points + 10> 2010;

-- indexes for sorting
SHOW INDEXES in customers;
