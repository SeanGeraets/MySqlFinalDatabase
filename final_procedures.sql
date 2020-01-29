USE final;

SELECT quarterback_id, 
quarterback_passing_yards AS 'Passing Yards', 
quarterback_passing_touchdowns AS 'Passing Touchdowns', 
quarterback_rushing_yards AS 'Rushing Yards', 
quarterback_rushing_touchdowns AS 'Rushing Touchdowns',
quarterback_interception AS Interceptions,
quarterback_fumbles AS Fumbles
FROM Quarterback
WHERE quarterback_id = 2;

DELIMITER //
DROP PROCEDURE IF EXISTS update_quarterback;
CREATE PROCEDURE update_quarterback
(
	quarterback_id_param 			INT,
	quarterback_passing_yards_param INT,
	quarterback_passing_touchdowns_param	INT,
	quarterback_rushing_yards_param			INT,
	quarterback_rushing_touchdowns_param	INT,
	quarterback_interception_param			INT,
	quarterback_fumbles_param				INT
)
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
	
	START TRANSACTION;
	
	UPDATE Quarterback
		SET quarterback_passing_yards = quarterback_passing_yards + quarterback_passing_yards_param,
		quarterback_passing_touchdowns = quarterback_passing_touchdowns + quarterback_passing_touchdowns_param,
		quarterback_rushing_yards = quarterback_rushing_yards + quarterback_rushing_yards_param,
		quarterback_rushing_touchdowns = quarterback_rushing_touchdowns + quarterback_rushing_touchdowns_param,
		quarterback_interception = quarterback_interception + quarterback_interception_param,
		quarterback_fumbles = quarterback_fumbles + quarterback_fumbles_param
		WHERE quarterback_id = quarterback_id_param;
		
	IF sql_error = FALSE THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END//
DELIMITER ;
CALL update_quarterback(2,230,1,12,0,1,0);


SELECT quarterback_id, 
quarterback_passing_yards AS 'Passing Yards', 
quarterback_passing_touchdowns AS 'Passing Touchdowns', 
quarterback_rushing_yards AS 'Rushing Yards', 
quarterback_rushing_touchdowns AS 'Rushing Touchdowns',
quarterback_interception AS Interceptions,
quarterback_fumbles AS Fumbles
FROM Quarterback
WHERE quarterback_id = 2;


DELIMITER //
DROP PROCEDURE IF EXISTS insert_quarterback;
CREATE PROCEDURE insert_quarterback
(
	quarterback_first_name_param 			VARCHAR(15),
	quarterback_last_name_param 			VARCHAR(20),
	quarterback_pro_team_param 				VARCHAR(40),
	quarterback_passing_yards_param 		INT,
	quarterback_passing_touchdowns_param 	INT,
	quarterback_rushing_yards_param 		INT,
	quarterback_rushing_touchdowns_param 	INT,
	quarterback_interception_param 			INT,
	quarterback_fumbles_param				INT,
	quarterback_games_played_param			INT,
	quarterback_injury_param 				BOOLEAN,
	participant_id_param					INT
)
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
	
	START TRANSACTION;
	INSERT INTO Quarterback
	(
		quarterback_first_name,
		quarterback_last_name,
		quarterback_pro_team,
		quarterback_passing_yards,
		quarterback_passing_touchdowns,
		quarterback_rushing_yards,
		quarterback_rushing_touchdowns,
		quarterback_interception,
		quarterback_fumbles,
		quarterback_games_played,
		quarterback_injury,
		participant_id
	)
	VALUES
	(
	quarterback_first_name_param,
	quarterback_last_name_param,
	quarterback_pro_team_param,
	quarterback_passing_yards_param,
	quarterback_passing_touchdowns_param,
	quarterback_rushing_yards_param,
	quarterback_rushing_touchdowns_param,
	quarterback_interception_param,
	quarterback_fumbles_param,
	quarterback_games_played_param,
	quarterback_injury_param,
	participant_id_param
	);
	IF sql_error = FALSE THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END//
DELIMITER ;
CALL insert_quarterback('Josh','Rosen','Arizona Cardinals',260,1,42,0,3,1,2,0,3);
CALL insert_quarterback('Cam','Newton','Carolina Panthers',530,3,76,1,1,0,2,0,2);

SELECT quarterback_first_name, quarterback_last_name FROM Quarterback;

DELIMITER //
DROP TRIGGER IF EXISTS quarterbacks_after_delete;
CREATE TRIGGER quarterbacks_after_delete
	AFTER DELETE ON Quarterback
	FOR EACH ROW
BEGIN
	INSERT INTO quarterbacks_audit 
	VALUES
		(OLD.quarterback_id, 
		OLD.quarterback_first_name,
		OLD.quarterback_last_name,
		OLD.quarterback_pro_team,
		OLD.quarterback_passing_yards,
		OLD.quarterback_passing_touchdowns,
		OLD.quarterback_rushing_yards,
		OLD.quarterback_rushing_touchdowns,
		OLD.quarterback_interception,
		OLD.quarterback_fumbles,
		OLD.quarterback_total_points,
		OLD.quarterback_average_points,
		OLD.quarterback_games_played,
		OLD.quarterback_injury,
		OLD.participant_id,
		'DELETED', NOW());
END//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS delete_quarterback;
CREATE PROCEDURE delete_quarterback
(
	quarterback_first_name_param VARCHAR(15),
	quarterback_last_name_param VARCHAR(20)
)
BEGIN
	START TRANSACTION;
	DELETE FROM Quarterback
	WHERE quarterback_first_name = quarterback_first_name_param
	AND quarterback_last_name = quarterback_last_name_param;
END//
DELIMITER ;

CALL delete_quarterback('Josh','Rosen');
CALL delete_quarterback('Cam','Newton');
SELECT quarterback_first_name AS 'First Name', quarterback_last_name AS 'Last Name' FROM Quarterback;


DELIMITER //
DROP PROCEDURE IF EXISTS search_quarterbacks;
CREATE PROCEDURE search_quarterbacks
(
	quarterback_points_param INT
)
BEGIN
	SELECT 
	CONCAT_WS(', ',quarterback_last_name,quarterback_first_name) AS Quarterback,
	((quarterback_passing_yards * points_per_passing_yards) + 
		(quarterback_passing_touchdowns * points_per_passing_touchdown) +
		(quarterback_rushing_yards * points_per_rushing_yards) +
		(quarterback_rushing_touchdowns * points_per_rushing_touchdown) -
		(quarterback_interception * points_per_offensive_interception) - 
		(quarterback_fumbles * points_per_offensive_fumble)) AS 'Total Points'
	FROM Quarterback q
	JOIN Participant p
		ON q.participant_id = p.participant_id
	JOIN League l
		ON p.league_id = l.league_id
	JOIN PointsPer pp
		ON l.points_id = pp.points_id
	WHERE ((quarterback_passing_yards * points_per_passing_yards) + 
		(quarterback_passing_touchdowns * points_per_passing_touchdown) +
		(quarterback_rushing_yards * points_per_rushing_yards) +
		(quarterback_rushing_touchdowns * points_per_rushing_touchdown) -
		(quarterback_interception * points_per_offensive_interception) - 
		(quarterback_fumbles * points_per_offensive_fumble)) > quarterback_points_param;


END//
DELIMITER ;

CALL search_quarterbacks(50);

SELECT CONCAT_WS(', ',quarterback_last_name,quarterback_first_name) AS Quarterback,
	((quarterback_passing_yards * points_per_passing_yards) + 
		(quarterback_passing_touchdowns * points_per_passing_touchdown) +
		(quarterback_rushing_yards * points_per_rushing_yards) +
		(quarterback_rushing_touchdowns * points_per_rushing_touchdown) -
		(quarterback_interception * points_per_offensive_interception) - 
		(quarterback_fumbles * points_per_offensive_fumble)) AS 'Total Points'
FROM Quarterback q
	JOIN Participant p
		ON q.participant_id = p.participant_id
	JOIN League l
		ON p.league_id = l.league_id
	JOIN PointsPer pp
		ON l.points_id = pp.points_id;


SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
DROP FUNCTION IF EXISTS get_runningback_total_points;
CREATE FUNCTION get_runningback_total_points
(
	runningback_id_param INT
)
RETURNS DECIMAL(9,2)		
BEGIN
	DECLARE runningback_total_points_var DECIMAL(9,2);
	
	SELECT ((runningback_receiving_yards * points_per_receiving_yard) + 
		(runningback_receiving_touchdowns * points_per_receiving_touchdown) +
		(runningback_rushing_yards * points_per_rushing_yards) +
		(runningback_rushing_touchdowns * points_per_rushing_touchdown) -
		(runningback_fumbles * points_per_offensive_fumble))
	INTO runningback_total_points_var
	FROM Runningback r
	JOIN Participant p
		ON r.participant_id = p.participant_id
	JOIN League l
		ON p.league_id = l.league_id
	JOIN PointsPer pp
		ON l.points_id = pp.points_id
	WHERE r.runningback_id = runningback_id_param;
	
	RETURN runningback_total_points_var;
	
END//
DELIMITER ;
	
DELIMITER //
DROP PROCEDURE IF EXISTS check_runningback_points;
CREATE PROCEDURE check_runningback_points
(
	runningback_id_param INT
)
BEGIN

	SELECT 
	CONCAT_WS(', ',runningback_last_name,runningback_first_name) AS Runningback,
	get_runningback_total_points(runningback_id_param) AS 'Total Points'
	FROM Runningback r
	JOIN Participant p
		ON r.participant_id = p.participant_id
	JOIN League l
		ON p.league_id = l.league_id
	JOIN PointsPer pp
		ON l.points_id = pp.points_id
	WHERE runningback_id = runningback_id_param;

END//
DELIMITER ;

CALL check_runningback_points(1);
CALL check_runningback_points(4);


SELECT quarterback_first_name, quarterback_last_name, action_type, action_date
FROM quarterbacks_audit;