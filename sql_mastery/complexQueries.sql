-- Subqueries
-- Find products that are more expensive than Lettuce (id=3)
use sql_store;
SELECT * fROM products
WHERE unit_price > 
(
SELECT unit_price
FROM products
WHERE product_id = 3
);

-- in sql_hr database, find employees who earn more than average
use sql_hr;
SELECT * from employees
WHERE salary >
(
SELECT 
	avg (salary) 
FROM employees
);

-- in sql_invoicing, find clients without invoices
use sql_invoicing;
SELECT * from clients
WHERE client_id NOT IN
(
select DISTINCT(client_id) 
FROM invoices
);

-- ALL operator
-- Select invoices larger than all invoices of client 3
use sql_invoicing;
SELECT * 
FROM invoices
WHERE invoice_total >
(
SELECT max(invoice_total) 
FROM invoices WHERE client_id = 3
);

SELECT * 
FROM invoices
WHERE invoice_total > ALL
(
SELECT invoice_total
FROM invoices WHERE client_id = 3
);

-- ANY Keyword
-- select clients with at least two invoices

SELECT *
FROM clients
WHERE client_id IN 
(
SELECT client_id
FROM invoices
GROUP by client_id
HAVING count(*) >= 2
);

SELECT *
FROM clients
WHERE client_id = ANY 
(
SELECT client_id
FROM invoices
GROUP by client_id
HAVING count(*) >= 2
);

-- Correlated Subqueries
-- get invoices that are larger than the client's avg invoice amount
SELECT * 
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
	FROM invoices
	GROUP by client_id
);

-- EXISTS operator
-- Select clients that have an invoice
SELECT * 
FROM clients
WHERE client_id IN (
	SELECT DISTINCT(client_id)
    FROM invoices
);
SELECT * 
FROM clients c
WHERE EXISTS (
	SELECT DISTINCT(client_id)
    FROM invoices
    WHERE client_id = c.client_id
);

-- find the products that have never been ordered
use sql_store;
SELECT * 
FROM products
WHERE product_id NOT IN (
SELECT 
	DISTINCT (product_id)
FROM order_items
);

SELECT * 
FROM products p
WHERE NOT EXISTS (
SELECT 
	DISTINCT (product_id)
	FROM order_items
    WHERE product_id = p.product_id
);

-- Subqueries in the SELECT clause
use sql_invoicing;
SELECT 
	invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total) FROM invoices) AS invoice_average,
	invoice_total - (SELECT invoice_average) AS difference
FROM invoices;

-- correlated subqueries do a for each row operation
select
	client_id,
    name,
    (select sum(invoice_total)
		from invoices i
        where i.client_id = c.client_id) as total_sales,
	(select avg(invoice_total)
		from invoices) as average,
	(select total_sales - average) as difference
from 
	clients c;

-- Subqueries in the FROM clause
SELECT *
FROM
(
	select
		client_id,
		name,
		(select sum(invoice_total)
			from invoices i
			where i.client_id = c.client_id) as total_sales,
		(select avg(invoice_total)
			from invoices) as average,
		(select total_sales - average) as difference
	from 
		clients c
) as sales_summary
where total_sales is not null;

-- Essential functions
use sql_store;
select 
	product_id, 
    name,
    (select count(order_id) from order_items oi
		where p.product_id = oi.product_id) as orders,
	if((select orders) > 1,'Many times', 'once') as frequency
from products p;

-- CASE
SELECT 
	concat(first_name, ' ', last_name) as customer,
    points,
    CASE
		WHEN points >= 3000 THEN 'Gold'
        WHEN points > 2000 AND points < 3000 THEN 'Silver'
        ELSE 'Bronze'
	END as category
from customers
order by points DESC

