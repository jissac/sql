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
		(1,2, '2016-03-02', 6),
        (1,2, '2016-03-03', 6),
        (2,3, '2017-02-02', 1),
        (3,5, '2017-09-08', 0),
        (3,5, '2017-09-09', 1),
        (3,3, '2018-10-10', 5);
SELECT * FROM Activity;

SELECT ROUND(COUNT(*) / (SELECT COUNT(DISTINCT player_id) FROM Activity),2) as fraction
FROM 
(SELECT 
	player_id,
    DATEDIFF(event_date,LAG(event_date) OVER(PARTITION BY player_id ORDER BY event_date)) as diff,
    row_number() OVER(PARTITION BY player_id ORDER BY event_date) AS row_num
FROM
	Activity) t1
WHERE t1.diff = 1 AND t1.row_num=2

-- KEY INSIGHT: datediff, using row_num to get day after first login, window fns, subqueries
-- https://leetcode.com/problems/game-play-analysis-iv/ 