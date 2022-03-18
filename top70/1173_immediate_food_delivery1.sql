Create table If Not Exists Delivery (delivery_id int, customer_id int, order_date date, customer_pref_delivery_date date);
Truncate table Delivery;
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('1', '1', '2019-08-01', '2019-08-02');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('2', '5', '2019-08-02', '2019-08-02');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('3', '1', '2019-08-11', '2019-08-11');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('4', '3', '2019-08-24', '2019-08-26');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('5', '4', '2019-08-21', '2019-08-22');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('6', '2', '2019-08-11', '2019-08-13');


-- method 1

with orders as 
(
select
    case
		when order_date = customer_pref_delivery_date then 'immediate'
        else 'scheduled'
	end as pref,
    count(*) total
from delivery
group by pref
) 

select
	format(count(total='immediate')/sum(total) *100,4) as immediate_percentage
from orders;


-- Method 2

select 
	round(
		(select count(*) from delivery where order_date = customer_pref_delivery_date) /
		count(*)
        , 2) as immediate_percentage
from delivery


-- KEY INSIGHT
-- using a CTE to separate out the logic
-- don't have to use case statement (method 2) - cleaner and easier, gets to the 
-- point faster, dont deal with case, 'immediate'/'scheduled' step