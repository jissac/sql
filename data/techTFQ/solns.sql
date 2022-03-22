-- https://techtfq.com/blog/learn-how-to-write-sql-queries-practice-complex-sql-queries
-- --------------------------------------------------------------------------------

-- PROBLEM 1: FIND DUPLICATES
select * from users;
-- SOLN 1
select user_id,user_name,email from users
where user_name IN 
(select user_name
from users 
group by user_name
having count(*) > 1
);

-- SOL2
select user_id, user_name, email
from
(
select *,
row_number() over (partition by user_name order by user_id) as rn
from users
order by user_id
) t1
where t1.rn > 1;
-- --------------------------------------------------------------------------------

-- PROBLEM 4a: SAME HOSPITAL DIFF SPECIALTIES
select * from doctors;
-- SOLN 1
select d1.*
from doctors d1
join doctors d2 on d1.id != d2.id and d1.hospital = d2.hospital and d1.speciality != d2.speciality
order by d1.id;
-- PROBLEM 4b: SAME HOSPITAL IRRESPECTIVE OF SPECIALTIES
select d1.name, d1.speciality,d1.hospital
from doctors d1
join doctors d2 on d1.id != d2.id and d1.hospital = d2.hospital
order by d1.id;

-- --------------------------------------------------------------------------------

-- PROBLEM 5: consecutive logins

select * from login_details;

select distinct user_name
from 
(
select *,
	case 
		when user_name = lead(user_name) over(order by login_date) and
        user_name = lead(user_name,2) over(order by login_date) then user_name
		else null
	end as repeated_users
from login_details
order by login_date) x
where x.repeated_users is not null;

-- --------------------------------------------------------------------------------

-- PROBLEM 7: cold weather for 3 consecutive days or more

select * from weather;

select id, city, temperature, day
from
(
select *,
	case 
		when temperature <0
        and lead(temperature) over(order by id) <0
        and lead(temperature,2) over(order by id) <0
        then 1
        when temperature <0
        and lag(temperature) over(order by id) <0
        and lead(temperature) over(order by id) <0
        then 1 
        when temperature <0
        and lag(temperature) over(order by id) <0
        and lag(temperature,2) over(order by id) <0
        then 1  
		else null
	end flag
from weather
) w 
where flag = 1;

-- --------------------------------------------------------------------------------

-- PROBLEM 9
select * from patient_logs;

select month, account_id,  no_of_unique_patients
from
(
select *, row_number() over (partition by month order by no_of_unique_patients,account_id desc) as rnk
from
(
select 
	date_format(date,'%M') as month,
    account_id,
    count(distinct(patient_id)) as no_of_unique_patients
from patient_logs
group by account_id, month
order by month, no_of_unique_patients desc
) t1
) x
where x.rnk <=2