DROP DATABASE IF EXISTS final;
CREATE DATABASE final;

USE final;
CREATE TABLE PointsPer
(
points_id 							INT  PRIMARY KEY AUTO_INCREMENT,
points_per_passing_yards			FLOAT(2,2) NOT NULL,
points_per_passing_touchdown		INT  NOT NULL,
points_per_rushing_yards			FLOAT(2,2) NOT NULL,
points_per_rushing_touchdown		INT NOT NULL,
points_per_receiving_yard			FLOAT(2,2) NOT NULL,
points_per_receiving_touchdown		INT NOT NULL,
points_per_offensive_interception	INT NOT NULL,
points_per_offensive_fumble			INT NOT NULL,
points_per_field_goal_50			INT NOT NULL,
points_per_field_goal_40_49			INT NOT NULL,
points_per_field_goal_30_39			INT NOT NULL,
points_per_field_goal_30			INT NOT NULL,
points_per_missed_field_goal		INT NOT NULL,
points_per_made_extra_point			INT NOT NULL,
points_per_missed_extra_point		INT NOT NULL,
points_per_defense_touchdown		INT NOT NULL,
points_per_defense_interception		INT NOT NULL,
points_per_defense_sack				INT NOT NULL,
points_per_defense_fumbles			INT NOT NULL
);
CREATE TABLE League
(
league_id						INT PRIMARY KEY AUTO_INCREMENT,
league_name						VARCHAR(40) NOT NULL,
league_commissioner_first_name	VARCHAR(20) NOT NULL,
league_commissioner_last_name	VARCHAR(40) NOT NULL,
points_id						INT	NOT NULL,
CONSTRAINT points_id_fk 
	FOREIGN KEY (points_id) 
	REFERENCES PointsPer (points_id)
);
CREATE TABLE Participant
(
participant_id			INT PRIMARY KEY AUTO_INCREMENT,
participant_first_name	VARCHAR(20) NOT NULL,
participant_last_name	VARCHAR(30) NOT NULL,
participant_team_name	VARCHAR(40) NOT NULL,
participant_wins		INT NOT NULL,
participant_loses		INT NOT NULL,
league_id				INT NOT NULL,
CONSTRAINT league_id_fk
	FOREIGN KEY(league_id)
	REFERENCES League (league_id)
);
CREATE TABLE Quarterback
(
quarterback_id					INT PRIMARY KEY AUTO_INCREMENT,
quarterback_first_name			VARCHAR(15) NOT NULL,
quarterback_last_name			VARCHAR(20) NOT NULL,
quarterback_pro_team			VARCHAR(40) NOT NULL,
quarterback_passing_yards		INT NOT NULL,
quarterback_passing_touchdowns	INT NOT NULL,
quarterback_rushing_yards		INT NOT NULL,
quarterback_rushing_touchdowns	INT NOT NULL,
quarterback_interception		INT NOT NULL,
quarterback_fumbles				INT NOT NULL,
quarterback_total_points		FLOAT(5,2) NOT NULL DEFAULT 0,
quarterback_average_points		FLOAT(4,2) NOT NULL DEFAULT 0,
quarterback_games_played		INT NOT NULL,
quarterback_injury				BOOLEAN NOT NULL,
participant_id					INT,
CONSTRAINT participant_id_qb_fk
	FOREIGN KEY(participant_id)
	REFERENCES Participant (participant_id)
);
CREATE TABLE TightEnd
(
tight_end_id 					INT PRIMARY KEY AUTO_INCREMENT,
tight_end_first_name 			VARCHAR(15) NOT NULL,
tight_end_last_name 			VARCHAR(20) NOT NULL,
tight_end_pro_team 				VARCHAR(40) NOT NULL,
tight_end_receiving_yards 		INT NOT NULL,
tight_end_receiving_touchdowns 	INT NOT NULL,
tight_end_fumbles				INT NOT NULL,
tight_end_total_points			FLOAT(5,2) NOT NULL DEFAULT 0,
tight_end_average_points		FLOAT(4,2) NOT NULL DEFAULT 0,
tight_end_games_played			INT NOT NULL,
tight_end_injury 				BOOLEAN NOT NULL,
participant_id 					INT,
CONSTRAINT participant_id_te_fk
	FOREIGN KEY(participant_id)
	REFERENCES Participant (participant_id)
);
CREATE TABLE WideReceiver
(
wide_receiver_id 					INT PRIMARY KEY AUTO_INCREMENT,
wide_receiver_first_name 			VARCHAR(15) NOT NULL,
wide_receiver_last_name 			VARCHAR(20) NOT NULL,
wide_receiver_pro_team 				VARCHAR(40) NOT NULL,
wide_receiver_receiving_yards 		INT NOT NULL,
wide_receiver_receiving_touchdowns 	INT NOT NULL,
wide_receiver_rushing_yards			INT NOT NULL,
wide_receiver_rushing_touchdowns	INT NOT NULL,
wide_receiver_fumbles				INT NOT NULL,
wide_receiver_total_points			FLOAT(5,2) NOT NULL DEFAULT 0,
wide_receiver_average_points		FLOAT(4,2) NOT NULL DEFAULT 0,
wide_receiver_games_played			INT NOT NULL,
wide_receiver_injury 				BOOLEAN NOT NULL,
participant_id 						INT,
CONSTRAINT participant_id_wr_fk
	FOREIGN KEY(participant_id)
	REFERENCES Participant (participant_id)
);
CREATE TABLE Kicker
(
kicker_id 							INT PRIMARY KEY AUTO_INCREMENT,
kicker_first_name 					VARCHAR(15) NOT NULL,
kicker_last_name 					VARCHAR(20) NOT NULL,
kicker_pro_team 					VARCHAR(40) NOT NULL,
kicker_missed_extra_points			INT NOT NULL,
kicker_made_extra_points			INT NOT NULL,
kicker_field_goals_50_yards			INT NOT NULL,
kicker_field_goals_40_49_yards		INT NOT NULL,
kicker_field_goals_30_39_yards 		INT NOT NULL,
kicker_field_goals_less_30_yards	INT NOT NULL,
kicker_missed_field_goals			INT NOT NULL,
kicker_total_points					FLOAT(5,2) NOT NULL DEFAULT 0,
kicker_average_points				FLOAT(4,2) NOT NULL DEFAULT 0,
kicker_games_played					INT NOT NULL,
kicker_injury						BOOLEAN NOT NULL,
participant_id						INT,
CONSTRAINT participant_id_k_fk
	FOREIGN KEY(participant_id)
	REFERENCES Participant (participant_id)
);
CREATE TABLE Runningback
(
runningback_id 						INT PRIMARY KEY AUTO_INCREMENT,
runningback_first_name 				VARCHAR(15) NOT NULL,
runningback_last_name 				VARCHAR(20) NOT NULL,
runningback_pro_team 				VARCHAR(40) NOT NULL,
runningback_receiving_yards 		INT NOT NULL,
runningback_receiving_touchdowns 	INT NOT NULL,
runningback_rushing_yards			INT NOT NULL,
runningback_rushing_touchdowns		INT NOT NULL,
runningback_fumbles					INT NOT NULL,
runningback_total_points			FLOAT(5,2) NOT NULL DEFAULT 0,
runningback_average_points			FLOAT(4,2) NOT NULL DEFAULT 0,
runningback_games_played			INT NOT NULL,
runningback_injury 					BOOLEAN NOT NULL,
participant_id 						INT,
CONSTRAINT participant_id_rb_fk
	FOREIGN KEY(participant_id)
	REFERENCES Participant (participant_id)
);
CREATE TABLE Defense
(
defense_id 					INT PRIMARY KEY AUTO_INCREMENT,
defense_pro_team 			VARCHAR(40) NOT NULL,
defense_interceptions 		INT NOT NULL,
defense_touchdowns 			INT NOT NULL,
defense_fumbles_forced		INT NOT NULL,
defense_sacks				INT NOT NULL,
defense_total_points		FLOAT(5,2) NOT NULL DEFAULT 0,
defense_average_points		FLOAT(4,2) NOT NULL DEFAULT 0,
defense_games_played		INT NOT NULL,
participant_id 				INT,
CONSTRAINT participant_id_d_fk
	FOREIGN KEY(participant_id)
	REFERENCES Participant (participant_id)
);
CREATE TABLE Weekly
(
weekly_id	INT PRIMARY KEY AUTO_INCREMENT,
weekly_total_points	FLOAT(5,2) NOT NULL DEFAULT 0,
week_number		INT NOT NULL,
quarterback_id	INT NOT NULL,
runningback_id	INT NOT NULL,
wide_receiver_id	INT NOT NULL,
defense_id	INT NOT NULL,
tight_end_id	INT NOT NULL,
kicker_id	INT NOT NULL,
participant_id	INT NOT NULL,
CONSTRAINT participant_id_w_fk
	FOREIGN KEY(participant_id)
	REFERENCES Participant (participant_id),
CONSTRAINT quarterback_id_fk
	FOREIGN KEY(quarterback_id)
	REFERENCES Quarterback (quarterback_id),
CONSTRAINT runningback_id_fk
	FOREIGN KEY(runningback_id)
	REFERENCES Runningback (runningback_id),
CONSTRAINT wide_receiver_id_fk
	FOREIGN KEY(wide_receiver_id)
	REFERENCES WideReceiver (wide_receiver_id),
CONSTRAINT defense_id_fk
	FOREIGN KEY(defense_id)
	REFERENCES Defense (defense_id),
CONSTRAINT tight_end_id_fk
	FOREIGN KEY(tight_end_id)
	REFERENCES TightEnd (tight_end_id),
CONSTRAINT kicker_id_fk
	FOREIGN KEY(kicker_id)
	REFERENCES Kicker (kicker_id)
);

CREATE TABLE quarterbacks_audit
(
	quarterback_id					INT PRIMARY KEY AUTO_INCREMENT,
	quarterback_first_name			VARCHAR(15) NOT NULL,
	quarterback_last_name			VARCHAR(20) NOT NULL,
	quarterback_pro_team			VARCHAR(40) NOT NULL,
	quarterback_passing_yards		INT NOT NULL,
	quarterback_passing_touchdowns	INT NOT NULL,
	quarterback_rushing_yards		INT NOT NULL,
	quarterback_rushing_touchdowns	INT NOT NULL,
	quarterback_interception		INT NOT NULL,
	quarterback_fumbles				INT NOT NULL,
	quarterback_total_points		FLOAT(5,2) NOT NULL DEFAULT 0,
	quarterback_average_points		FLOAT(4,2) NOT NULL DEFAULT 0,
	quarterback_games_played		INT NOT NULL,
	quarterback_injury				BOOLEAN NOT NULL,
	participant_id					INT,
	action_type 					VARCHAR(50) NOT NULL,
	action_date						DATETIME NOT NULL
);

INSERT INTO PointsPer 
(
points_per_passing_yards, points_per_passing_touchdown,	
points_per_rushing_yards,			
points_per_rushing_touchdown,		
points_per_receiving_yard,			
points_per_receiving_touchdown,		
points_per_offensive_interception,	
points_per_offensive_fumble,		
points_per_field_goal_50,			
points_per_field_goal_40_49,			
points_per_field_goal_30_39,		
points_per_field_goal_30,			
points_per_missed_field_goal,		
points_per_made_extra_point,		
points_per_missed_extra_point,		
points_per_defense_touchdown,		
points_per_defense_interception,		
points_per_defense_sack,			
points_per_defense_fumbles	
)
VALUES
(0.05,4,0.15,6,0.15,6,3,3,6,5,4,3,2,1,1,6,3,1,3);

INSERT INTO League
(						
league_name,					
league_commissioner_first_name,
league_commissioner_last_name,
points_id
)
VALUES
('BASP','Sean','Geraets',1);

INSERT INTO Participant
(
participant_first_name,
participant_last_name,
participant_team_name,
participant_wins,
participant_loses,
league_id
)VALUES
('Sean','Geraets','Team Geraets',2,0,1),
('Ben','Ranard','Team Ranard',1,1,1),
('Travis','Brimeyer','Team Brimeyer',0,2,1),
('Alex','Proehl','Team Proehl',1,1,1);

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
('Tom','Brady','New England Patriots',623,4,12,0,1,0,2,0,1),
('Phillip','Rivers','Los Angeles Chargers',649,5,6,0,0,1,2,0,2),
('Russell','Wilson','Seattle Seahawks',550,3,46,0,1,1,2,0,3),
('Marcus','Mariota','Tennessee Titan',430,1,37,0,2,1,2,0,4),
('Aaron','Rodgers','Green Bay Packers',579,3,8,0,1,0,2,0,1),
('Drew','Brees','New Orlean Saints',650,5,17,0,0,0,2,0,2),
('Ben','Roethlisberger','Pittsburgh Steelers',571,2,24,0,1,0,2,0,3),
('Kirk','Cousins','Minnesota Vikings',514,2,35,0,2,1,2,0,4);

INSERT INTO Runningback
(
runningback_first_name,
runningback_last_name,
runningback_pro_team,
runningback_receiving_yards,
runningback_receiving_touchdowns,
runningback_rushing_yards,
runningback_rushing_touchdowns,
runningback_fumbles,
runningback_games_played,
runningback_injury,
participant_id
)
VALUES
('Saquan','Barkley','New York Giants',39,0,123,2,0,2,0,1),
('Tarik','Cohen','Chicago Bears',57,1,89,1,0,2,0,2),
('Adrian','Peterson','Washington Redskins',24,0,139,1,1,2,0,3),
('Todd','Gurley','Los Angeles Rams',50,1,156,2,0,2,0,4),
('Ezekiel','Elliot','Dallas Cowboys',63,0,149,3,1,2,0,2),
('Christian','McCaffrey','Carolina Panthers',112,1,143,2,0,2,0,4),
('Alvin','Kamara','New Orlean Saints',76,0,158,2,0,2,0,1),
('Melvin','Gordon','Los Angeles Chargers',37,0,134,1,0,2,0,3);

INSERT INTO TightEnd
(
tight_end_first_name,
tight_end_last_name,
tight_end_pro_team,
tight_end_receiving_yards,
tight_end_receiving_touchdowns,
tight_end_fumbles,
tight_end_games_played,
tight_end_injury,
participant_id
)
VALUES
('Travis','Kelce','Kansas City Chiefs',53,1,0,2,0,1),
('Antonio','Gates','Los Angeles Chargers',67,2,0,2,0,2),
('Rob','Gronkowski','New England Patriots',119,1,0,2,0,3),
('Zach','Ertz','Philadelphia Eagles',89,2,1,2,0,4);

INSERT INTO WideReceiver
(
wide_receiver_first_name, 
wide_receiver_last_name, 
wide_receiver_pro_team, 	
wide_receiver_receiving_yards, 
wide_receiver_receiving_touchdowns, 
wide_receiver_rushing_yards,		
wide_receiver_rushing_touchdowns,	
wide_receiver_fumbles,	
wide_receiver_games_played,	
wide_receiver_injury, 	
participant_id
)
VALUES
('Antonio','Brown','Oakland Raiders',127,0,0,0,0,2,0,1),
('Jarvis','Landry','Cleveland Browns',187,1,0,0,0,2,0,2),
('Julio','Jones','Atlanta Falcons',148,2,13,0,0,2,0,3),
('A.J.','Green','Cincinnati Bengals',131,0,5,0,0,2,0,4);

INSERT INTO Defense
(
defense_pro_team,
defense_interceptions, 
defense_touchdowns, 	
defense_fumbles_forced,
defense_sacks,	
defense_games_played,
participant_id 
)
VALUES
('Pittsburgh Steelers',1,0,0,2,2,2),
('Chicago Bears',2,0,1,4,2,1),
('Los Angeles Rams',1,0,0,3,2,3),
('Baltimore Ravens',0,1,2,3,2,4);

INSERT INTO Kicker
(
kicker_first_name, 				
kicker_last_name, 				
kicker_pro_team, 				
kicker_missed_extra_points,	
kicker_made_extra_points,		
kicker_field_goals_50_yards,		
kicker_field_goals_40_49_yards,	
kicker_field_goals_30_39_yards, 	
kicker_field_goals_less_30_yards,	
kicker_missed_field_goals,			
kicker_games_played,				
kicker_injury,				
participant_id
)
VALUES
('Robbie','Gould','San Francisco 49ers',0,3,0,0,1,0,0,2,0,1),
('Adam','Vinatieri','Indianapolis Colts',0,2,0,1,1,0,0,1,0,2),
('Mason','Crosby','Green Bay Packers',0,3,1,0,2,0,0,2,0,3),
('Stephen','Gostkowski','New England Patriots',0,2,0,1,2,0,0,2,0,4);

INSERT INTO Weekly
(
week_number,	
quarterback_id,
runningback_id,	
wide_receiver_id,
defense_id,	
tight_end_id,	
kicker_id,	
participant_id	
)
VALUES
(1,1,1,2,2,1,1,1),
(2,1,1,2,2,1,1,1),
(1,2,2,1,1,2,2,2),
(2,2,2,1,1,2,2,2),
(1,3,3,3,3,3,3,3),
(2,3,3,3,3,3,3,3),
(1,4,4,4,4,4,4,4),
(2,4,4,4,4,4,4,4);

CREATE OR REPLACE VIEW week_view AS
SELECT 
	week_number AS Week,
	CONCAT_WS(', ',participant_last_name,participant_first_name) AS Participant,
	CONCAT_WS(', ',quarterback_last_name,quarterback_first_name) AS Quarterback,
	CONCAT_WS(', ',runningback_last_name,runningback_first_name) AS Runningback,
	CONCAT_WS(', ',wide_receiver_last_name,wide_receiver_first_name) AS 'Wide Receiver',
	CONCAT_WS(', ',tight_end_last_name,tight_end_first_name) AS 'Tight End',
	CONCAT_WS(', ',kicker_last_name,kicker_first_name) AS Kicker,
defense_pro_team AS Defense
FROM Weekly w
JOIN Quarterback q
	ON w.quarterback_id = q.quarterback_id
JOIN Runningback r
	ON w.runningback_id = r.runningback_id
JOIN WideReceiver wr
	ON w.wide_receiver_id = wr.wide_receiver_id
JOIN TightEnd te
	ON w.tight_end_id = te.tight_end_id
JOIN Defense d
	ON w.defense_id = d.defense_id
JOIN Kicker k
	ON w.kicker_id = k.kicker_id
JOIN Participant p 
	ON w.participant_id = p.participant_id
ORDER BY week_number, participant_last_name
;
/*
SELECT * FROM week_view;
*/
CREATE OR REPLACE VIEW top_quarterback AS
SELECT 
	CONCAT_WS(', ',quarterback_last_name,quarterback_first_name) AS Quarterback,
	quarterback_passing_yards AS 'Passing Yards',
	quarterback_passing_touchdowns AS 'Passing Touchdowns',
	quarterback_interception AS Interceptions,
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
ORDER BY ((quarterback_passing_yards * points_per_passing_yards) + 
		(quarterback_passing_touchdowns * points_per_passing_touchdown) +
		(quarterback_rushing_yards * points_per_rushing_yards) +
		(quarterback_rushing_touchdowns * points_per_rushing_touchdown) -
		(quarterback_interception * points_per_offensive_interception) - 
		(quarterback_fumbles * points_per_offensive_fumble)) DESC;
/*
SELECT * FROM top_quarterback;
*/