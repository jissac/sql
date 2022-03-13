DROP TABLE ActorDirector;
CREATE TABLE ActorDirector (
	actor_id INT,
    director_id INT,
    timestamp INT,
    PRIMARY KEY (timestamp)
); 

SELECT actor_id, director_id FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3