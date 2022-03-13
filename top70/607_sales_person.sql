DROP TABLE IF EXISTS SalesPerson;
CREATE TABLE SalesPerson (
	sales_id INT,
    name varchar(50),
    salary INT,
    commission_rate INT,
    hire_date DATE,
    PRIMARY KEY (sales_id)
);

DROP TABLE IF EXISTS Company;
CREATE TABLE Company (
	com_id INT,
    name varchar(50),
    city varchar(50),
    PRIMARY KEY (com_id)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
	order_id INT,
    order_date DATE,
    com_id INT,
    sales_id INT,
    amount INT,
    PRIMARY KEY (order_id),
    FOREIGN KEY (com_id) REFERENCES Company(com_id)
);

SELECT 
    s.name 
FROM
    SalesPerson s
WHERE 
    s.sales_id NOT IN
(
SELECT 
    o.sales_id 
    FROM 
        Orders o
            LEFT JOIN
                Company c ON o.com_id = c.com_id
    WHERE 
        c.name='RED');