-- Aggregate Functions
use sql_invoicing;
SELECT 
	'First half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date 
	BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 
	'Second half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date 
	BETWEEN '2019-07-01' AND '2019-12-31'
    
UNION
SELECT 
	'Total' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date;

-- GROUP BY clause
SELECT 
	state,
    city,
	SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients USING (client_id)
WHERE invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales DESC;

SELECT 
	date,
    pm.name AS payment_method,
    SUM(i.payment_total) AS total_payments
FROM payments p
JOIN payment_methods pm
ON (p.payment_method = pm.payment_method_id)
JOIN invoices i USING (invoice_id)
GROUP BY date, pm.name
ORDER BY date;

-- HAVING
SELECT 
	client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS number_of_invoices
FROM invoices
GROUP BY client_id
HAVING total_sales > 500 AND number_of_invoices > 5;

-- customers located in Virgina who have spent more than $100
use sql_store;
SELECT
    customer_id,
    first_name,
    last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE state = 'VA'
GROUP BY customer_id, first_name,last_name
HAVING total_sales > 100;

-- ROLLUP clause
use sql_invoicing;
SELECT 
	state,
    city,
    SUM(invoice_total) AS total_sales
    FROM invoices
    JOIN clients c USING (client_id)
    GROUP BY state, city WITH ROLLUP
    


