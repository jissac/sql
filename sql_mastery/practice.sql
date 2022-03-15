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
ORDER BY date 

-- HAVING
