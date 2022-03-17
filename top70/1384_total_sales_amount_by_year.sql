DROP TABLE IF EXISTS Product, Sales;
CREATE TABLE Product(
	product_id INT,
    product_name varchar(50),
    PRIMARY KEY (product_id));
CREATE TABLE Sales(
    product_id INT,
    period_start date,
    period_end date,
    average_daily_sales INT,
    PRIMARY KEY (product_id)
);

INSERT INTO Product(product_id,product_name)
VALUES (1,'LC Phone'), (2,'LC T-Shirt'), (3,'LC Keychain');

INSERT INTO Sales(product_id,period_start,period_end,average_daily_sales)
VALUES  (1, '2019-01-25' , '2019-02-28', 100),
		(2, '2019-12-01' , '2020-01-01', 10),
		(3, '2019-12-01' , '2020-01-31', 1),
		(4, '2018-04-01' , '2020-01-31', 1);

SELECT 
	s.product_id,
    p.product_name,
    s.average_daily_sales,
    datediff( period_end, period_start) as days,
    LEFT(period_start,4) as start_year,
    left(period_end, 4) as end_year,
    s.average_daily_sales * (select days) as total
FROM 
	Sales s
JOIN Product p USING(product_id)
ORDER BY s.product_id;



select
        '2018-01-01' year_start,
        '2018-12-31' year_end
    union all
    select
        '2019-01-01' , 
        '2019-12-31' 
    union all
    select
        '2020-01-01',
        '2020-12-31'

