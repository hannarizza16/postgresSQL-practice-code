CREATE TABLE contractors (
id serial,
contractor_name varchar
);

INSERT INTO contractors (contractor_name)
VALUES
('RAMISES CONSTRUCTION'),
('ME 3 CONSTRUCTION'),
('ORANI CONSTRUCTION AND SUPPLY CORPORATION (FORMERLY:ORANI BUILDERS & SUPPLY)'),
('MAER SUMMIT KONSTRUKT CO.'),
('XLA CONSTRUCTION'),
('CEFF TRADING & ENGINEERING SERVICES'),
('VEN RAY CONSTRUCTION CORPORATION'),
('CELSO C. FERRER CONSTRUCTION CORP.'),
('BIG BERTHA CONSTRUCTION & DEVELOPMENT'),
('BOOMETRIX DEVELOPMENT CORP.');

-- select * from contractors;

CREATE TABLE projects (
id serial,
-- contractor_id integer references contractors(id),
contractor_id integer,
project_name varchar,
project_location varchar,
project_cost numeric(15,2)
);

INSERT INTO projects (contractor_id, project_name, project_location, project_cost)
VALUES
(1, 'Construction of Bank Protection', 'Agusan Del Norte', 96158174.50),
(2, 'Construction of Flood Mitigation Structure', 'Agusan Del Norte', 137272357.59),
(3, 'Construction of Flood Mitigation Structure', 'Bataan', 48999998.54),
(4, 'Construction of Flood Control Dike along Kabacan Rive', 'North Cotobato', 96017492.67),
(5, 'Construction of Drainage', 'Cebu', 4939190.15),
(6, 'Construction of River Control Structure', 'Oriental Mindoro', 4939190.15),
(6, 'Construction of Drainage', 'Oriental Mindoro', 14699999.28),
(7, 'Construction of Flood Mitigation Structure', 'Bukidnon', 96500000.00),
(8, 'Construction of Flood Mitigation Structure', 'Nueve Ecija', 95052371.10),
(9, 'Construction of Slope Protection Structure', 'Tarlac', 14229719.67),
(10, 'Construction of Flood Mitigation Structure', 'Surigao Del Norte', 72274865.65),
(10, 'Construction of Flood Mitigation Structure', 'Surigao Del Norte', 72274740.23),
(1, 'Construction of Flood Mitigation Structure', 'Bukidnon', 49000000.00),
(1, 'Construction of Flood Mitigation Structures', 'Agusan Del Norte', 144749857.09),
(8, 'Construction of Flood Mitigation Structure', 'Nueva Ecija', 86849907.06),
(7, 'Construction of Flood Mitigation', 'Bukidnon', 49000000.00),
(9, 'Construction of Slope Protection', 'Tarlac', 89400000.00),
(4, 'Construction of Flood Mitigation Structure', 'Davao Oriental', 24132496.94),
(7, 'Construction of Flood Mitigation Structure', 'Bukidnon', 30380000.00),
(7, 'Construction of Flood Mitigation Structure', 'Bukidnon', 49000000.00);

-- count the list/number of projects --20
SELECT COUNT(*) FROM projects;

-- count the contractors --10
SELECT COUNT(*) FROM contractors

-- get the sum of project per contructor
SELECT 
contractors.contractor_name,
TO_CHAR(SUM(projects.project_cost), 'FM999,999,990.00')
FROM contractors
JOIN projects ON projects.contractor_id = contractors.id
GROUP BY contractors.contractor_name
-- ORDER BY SUM(projects.project_cost) DESC
HAVING SUM(projects.project_cost) = (
	SELECT MAX(total_cost_per_contractor)
	FROM (
		SELECT SUM(projects.project_cost) AS total_cost_per_contractor
		FROM projects
		GROUP BY projects.contractor_id
	) AS highest_budget --"RAMISES CONSTRUCTION"	"289,908,031.59"
) ;
-- LIMIT(5); -- shows only 5

-- group the results by province
-- get the top spending province and province amount
SELECT
projects.project_location,
TO_CHAR(SUM(projects.project_cost), 'FM999,999,990.00')
FROM projects
GROUP BY projects.project_location
-- ORDER BY SUM(projects.project_cost) ASC
HAVING SUM(projects.project_cost) = (
	SELECT MAX(total_cost_per_province)
	FROM (
		SELECT SUM(projects.project_cost) as Total_cost_per_province
		FROM projects
		GROUP BY projects.project_location
	) AS highest_budget --AGUSAN 378,180,389.18
);



-- count the provinces 
SELECT COUNT(*) FROM projects WHERE project_location = 'Bukidnon';

-- count the projects of the contructor 
SELECT COUNT(*)
FROM projects
JOIN contractors ON contractors.id = projects.contractor_id
WHERE contractors.contractor_name = UPPER('Ramises Construction');


