Create table If Not Exists Logs (log_id int);
Truncate table Logs;
insert into Logs (log_id) values ('1');
insert into Logs (log_id) values ('2');
insert into Logs (log_id) values ('3');
insert into Logs (log_id) values ('7');
insert into Logs (log_id) values ('8');
insert into Logs (log_id) values ('10');

select min(log_id), max(log_id)
from
(
select 
	log_id,
    log_id - row_number() over() as diff
from logs
) a
group by diff

-- KEY INSIGHT:
-- row number window function
-- create another column with just the row_number
-- subtract the log_id from the row number and group by