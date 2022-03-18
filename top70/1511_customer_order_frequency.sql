select 
	customer_id,
	name
from 
	Customers c
join
	Orders o using(customer_id)
join 
	Product p using(product_id)
group by 
	customer_id
having
	sum( if (left(o.order_date,7) = '2020-06',quantity,0) * price) >=100
    and sum ( if (left(o.order_date,7) = '2020-07',quantity,0) * price) >=100

-- KEY INSIGHT:
-- grouping by customer id and the filtering in the having clause:
-- returning quanity if the month of june or july and summing the quantity * price