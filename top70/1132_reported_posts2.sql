SELECT * FROM leetcode.Actions;

select round(avg(perc),2) as average_daily_percent
from
(
select
action_date,
count(r.remove_date),
COUNT(DISTINCT r.post_id)/ COUNT(DISTINCT a.post_id)*100 as perc
from actions a
left join removals r using(post_id)
where action like '%report%' and extra like 'spam'
group by action_date
) a;

select
*
from actions
left join removals r using(post_id)
where action like '%report%' and extra like 'spam'

-- KEY INSIGHT:
-- subquery, work inside out
-- distinct in count statement, as there may be duplicate rows