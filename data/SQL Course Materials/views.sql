use sql_invoicing;

CREATE VIEW sales_by_client AS
SELECT
	c.client_id,
    c.name,
    SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

DrOP VIEW IF EXISTS clients_balance;
CREATE VIEW clients_balance AS
SELECT 
	client_id,
    name,
    SUM(invoice_total-payment_total) AS balance
FROM invoices
JOIN clients USING (client_id)
GROUP BY client_id,name;