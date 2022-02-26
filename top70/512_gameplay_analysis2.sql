DROP TABLE IF EXISTS `Activity`;
CREATE TABLE `Activity` (
	`player_id` INT,
    `device_id` INT,
    `event_date` DATE, 
    `games_played` INT,
    PRIMARY KEY (`player_id`, `event_date`)
);
 INSERT INTO  `Activity` (`player_id`,`device_id`,`event_date`,`games_played`)
	VALUES 
		(1,2, '2016-03-01', 5),
		(1,2, '2016-05-02', 6),
        (2,3, '2017-02-02', 1),
        (3,5, '2017-09-08', 0),
        (3,3, '2018-10-10', 5);

-- SOLUTION 1 --        
SELECT t1.player_id, t2.device_id FROM 
(SELECT player_id, MIN(event_date) AS first_login
FROM Activity 
GROUP BY player_id) t1
JOIN
(SELECT player_id,device_id, event_date
FROM Activity) t2 
	ON t1.first_login = t2.event_date AND
    t1.player_id = t2.player_id;

-- SOLUTION 2 --
SELECT player_id, device_id
FROM Activity
WHERE (player_id, event_date) IN 
(SELECT player_id, MIN(event_date) AS min_date
FROM Activity 
GROUP BY player_id
)

-- KEY INSIGHT: can't alias unless it's used inside a subquery
