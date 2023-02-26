 #table creation example
 CREATE TABLE visit_record 
    (record_id int PRIMARY KEY,
    disease text NULL,
	treatment_description text NULL,
	recommendations text NULL);


#tables linking example
ALTER TABLE visit_record ADD COLUMN parientId INT;
ALTER TABLE visit_record ADD FOREIGN KEY (patientId) REFERENCES users(patientId);

ALTER TABLE visit_record ADD COLUMN visit_id INT;
ALTER TABLE visit_record ADD FOREIGN KEY (visit_id) REFERENCES visits(visit_id);


#tables data manipulation
UPDATE visit_record SET recommendations="continuation of treatment after 2 weeks" WHERE record_id="3";
UPDATE visits SET visitDate="2022-12-6" WHERE visit_id="9";

INSERT INTO visits VALUES (10, "2022-12-10", "caries treatment", 70, 4, 60);
INSERT INTO visit_record VALUES (10, "medium caries", "tooth №46, anesthesia Ultracain, Filtek material A3", "medical examination after 6 months", 4, 10);


#SELECT queries examples

SELECT DISTINCT disease FROM visit_record;
SELECT DISTINCT manipulation FROM visits;

SELECT fname, lname, age FROM users WHERE age > 25;
SELECT * FROM users WHERE fname LIKE "c%";
SELECT patientId, fname, lname FROM users WHERE fname LIKE "%ar%";
SELECT visitDate FROM visits WHERE visit_cost > 100 AND duration_min = 60; 
SELECT visitDate, patientId FROM visits WHERE visit_cost = 100 OR duration_min = 90; 
SELECT * FROM visits WHERE visit_cost BETWEEN 50 AND 100; 
SELECT * FROM visits WHERE (visit_cost > 80 OR visit_cost < 100) AND duration_min = 60 ORDER BY patientId; 
SELECT * FROM visit_record WHERE (patientId = 10 OR patientId = 2) AND disease ="medium caries" ORDER BY visit_id DESC;
SELECT AVG(duration_min) AS average_duration_of_treatment FROM visits;
SELECT SUM(visit_cost) FROM visits WHERE patientId = 10;
SELECT disease FROM visit_record UNION SELECT visitDate FROM visits;
SELECT disease FROM visit_record WHERE patientId IN (1, 5, 9);
SELECT recommendations, IF(disease ="medium caries", "medium caries", "other") FROM visit_record;
SELECT DISTINCT visitDate, datediff(now(), visitDate) AS days_since_visit FROM visits;
SELECT max(visit_cost) AS max_visit_cost FROM visits;
SELECT visitDate, manipulation, AVG(duration_min) FROM visits GROUP BY manipulation ORDER BY visitDate;


#JOIN queries examples
SELECT users.fname, users.lname, visits.visitDate 
FROM users 
JOIN visits ON users.patientId = visits.patientId ORDER BY visitDate;

SELECT users.fname, users.lname, visits.visitDate, visit_record.disease 
FROM users JOIN visits ON users.patientId = visits.patientId 
JOIN visit_record ON visit_record.visit_id = visits.visit_id 
ORDER BY visitDate;

SELECT concat(users.fname, ' ', users.lname) AS Full_name, count(visits.visitDate) AS Visits_quantity  
FROM users 
JOIN visits ON users.patientId = visits.patientId 
GROUP BY visits.patientId; 

SELECT CONCAT(users.fname, ' ', users.lname) AS Full_name, COUNT(visits.visitDate) AS Visits_quantity 
FROM users 
JOIN visits ON users.patientId = visits.patientId 
GROUP BY users.patientId, Full_name 
HAVING COUNT(visits.visitDate) > 1; 
 
 
