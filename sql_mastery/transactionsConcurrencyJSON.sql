USE sql_store;

START TRANSACTION;

INSERT INTO orders(customer_id,order_date,status)
VALUES (1,'2019-01-01',1);

INSERT INTO order_items (order_id,product_id,quantity,unit_price)
VALUES (LAST_INSERT_ID(), 1, 1, 1);

COMMIT;

SHOW VARIABLES like 'transaction_isolation';

-- DATA TYPES
-- JSON
use sql_store;
UPDATE products
SET properties = '
{
	"dimensions": [1,2,3],
    "weight": 10,
    "manufacturer": {"name": "sony"}
}'
WHERE product_id = 1;

-- another way to add JSON
UPDATE products
SET properties = JSON_OBJECT(
	'weight', 5, 
    'dimensions', JSON_ARRAY(1,2,3),
    'manufacturer', JSON_OBJECT('name','mitsubishi')
)
WHERE product_id = 2;

-- extract JSON 

SELECT product_id, JSON_EXTRACT(properties, '$.weight') as weight
FROM products
WHERE product_id = 1;

-- shorter way to write above
SELECT product_id, properties -> '$.weight'
FROM products
WHERE product_id = 1;

-- more queries
-- shorter way to write above
SELECT product_id, properties -> '$.dimensions[0]' as dim, properties ->> '$.manufacturer.name' as name
FROM products
WHERE product_id = 1;

-- JSON SET fn to update a certain parameter
UPDATE products
SET properties = JSON_SET(
	properties,
    '$.weight', 20,
    '$.age', 10
)
WHERE product_id = 2;

-- JSON_REMOVE to delete parameters
UPDATE products
SET properties = JSON_REMOVE(
	properties,
    '$.age'
)
WHERE product_id = 2;
