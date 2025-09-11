-- AGGREGATE FUNCTION 

-- COUNT ( * ) -- Computes the number of input rows.

-- MAX() → “largest” → last alphabetically for strings, latest for dates, highest for numbers.
-- MIN() → “smallest” → first alphabetically, earliest date, lowest number.
-- AVG() - gets the average value of a num
CREATE TABLE contractors (
id serial,
contractor_name varchar,
classification varchar,
is_blacklisted bool,
contact_person varchar,
-- it's best to use varchar rather than integer or bigint in contact_number
contact_number varchar(11)
);

INSERT INTO contractors (contractor_name, classification, is_blacklisted, contact_person, contact_number )
VALUES
('RAMISES CONSTRUCTION', 'A', FALSE, 'Jamaica', '09456872564'),
('ME 3 CONSTRUCTION', 'AAA', FALSE, 'Jose', '09456872564'),
('ORANI CONSTRUCTION AND SUPPLY CORPORATION (FORMERLY:ORANI BUILDERS & SUPPLY)', 'AAA', TRUE, 'Berto','09457565215'),
('MAER SUMMIT KONSTRUKT CO.', 'AAA', TRUE, 'Robert', '09458751256'),
('XLA CONSTRUCTION', 'AA', FALSE, 'Michael', '09456872564'),
('CEFF TRADING & ENGINEERING SERVICES', 'AAA', FALSE, 'Juan', '09458765915'),
('VEN RAY CONSTRUCTION CORPORATION', 'AA', FALSE, 'Ghost', '09456872564'),
('CELSO C. FERRER CONSTRUCTION CORP.', 'A', TRUE, 'James', '09457682356' ),
('BIG BERTHA CONSTRUCTION & DEVELOPMENT', 'A', FALSE, 'Berta', '09456872564'),
('BOOMETRIX DEVELOPMENT CORP.', 'A', TRUE, 'Henry', '09458752157');


CREATE TABLE projects (
-- this automatically generates code PJ0001
-- column_name data_type GENERATED ALWAYS AS (expression) STORED
-- GENERATED AS ALWAYS () STORED -- users can't insert or update this column manually
-- 'PJ' string that appears at the beginning
-- || concatinate or combined or add 
-- LPAD - left padding 
--(id::text) -- id(integet) :: text - convert to text
-- type-cast operator :: converts a value from one data type to another data type 
-- 4 atleast 4 characters long
-- if it doesnt count pad to the left and add '0'
code varchar GENERATED ALWAYS AS ('PJ' || LPAD(id::text, 4, '0')) STORED,
id serial,
contractor_id integer,
project_name varchar,
province varchar,
city_municipality varchar,
-- numeric(15,2) --123456789111115.00
approved_budget numeric(15,2),
contract_amount numeric(15,2),
start_date date,
end_date date,
status varchar
);

INSERT INTO projects (contractor_id, project_name, province, city_municipality, approved_budget, contract_amount, end_date, start_date, status)
VALUES
(1, 'Construction of Bank Protection', 'Agusan Del Norte', 'Butuan City', 90000000.00, 96158174.50, '2020-05-30', '2023-05-30', 'Completed'),
(2, 'Construction of Flood Mitigation Structure', 'Agusan Del Norte', 'Butuan City', 137272357.59, 137272357.59, '2019-06-01', '2022-06-01', 'Completed'),
(3, 'Construction of Flood Control Dike', 'Bataan', 'Balanga City', 48999998.54, 48999998.54, '2018-07-15', '2021-07-15', 'Completed'),
(4, 'Construction of Drainage System', 'Cebu', 'Consolacion', 4939190.15, 4939190.15, '2022-01-10', '2028-01-10', 'Ongoing'),
(5, 'Riverbank Reinforcement Project', 'Bukidnon', 'Malaybalay', 96500000.00, 96500000.00, '2025-10-11', '2028-09-11', 'Planning'),
(6, 'Slope Protection Structure', 'Tarlac', 'Tarlac City', 14229719.67, 14229719.67, '2017-03-05', '2020-03-05', 'Completed'),
(7, 'Flood Retention Basin', 'Iloilo', 'Iloilo City', 72274865.65, 72274865.65, '2021-08-01', '2028-08-01', 'Ongoing'),
(8, 'Bank Protection Project', 'Pampanga', 'San Fernando', 95052371.10, 95052371.10, '2025-10-11', '2028-09-11', 'Planning'),
(9, 'Construction of River Control Structure', 'Oriental Mindoro', 'Calapan City', 4939190.15, 4939190.15, '2020-04-10', '2028-04-10', 'Ongoing'),
(10, 'Drainage and Flood Mitigation', 'Agusan Del Norte', 'Butuan City', 14699999.28, 14699999.28, '2025-10-11', '2028-09-11', 'Planning'),
(1, 'Construction of Flood Dike', 'Surigao Del Norte', 'Surigao City', 72274740.23, 72274740.23, '2018-05-15', '2021-05-15', 'Completed'),
(2, 'Slope Protection Measures', 'Bukidnon', 'Valencia', 49000000.00, 49000000.00, '2021-09-01', '2028-09-01', 'Ongoing'),
(3, 'Drainage Improvement', 'Agusan Del Norte', 'Butuan City', 144749857.09, 144749857.09, '2025-10-11', '2028-09-11', 'Planning'),
(4, 'Flood Mitigation Project', 'Nueva Ecija', 'Cabanatuan', 86849907.06, 86849907.06, '2019-11-01', '2022-11-01', 'Completed'),
(5, 'Riverbank Reinforcement', 'Bukidnon', 'Malaybalay', 49000000.00, 49000000.00, '2021-02-01', '2028-02-01', 'Ongoing'),
(6, 'Construction of Flood Mitigation Structure', 'Tarlac', 'Tarlac City', 89400000.00, 89400000.00, '2025-10-11', '2028-09-11', 'Planning'),
(7, 'Drainage and River Control', 'Davao Oriental', 'Davao', 24132496.94, 24132496.94, '2017-07-01', '2020-07-01', 'Completed'),
(8, 'Flood Control Dike', 'Bukidnon', 'Valencia', 30380000.00, 30380000.00, '2025-10-11', '2028-09-11', 'Planning'),
(9, 'Slope Protection Project', 'Bukidnon', 'Malaybalay', 49000000.00, 49000000.00, '2018-08-01', '2021-08-01', 'Completed'),
(10, 'Riverbank Reinforcement and Drainage', 'Cebu', 'Consolacion', 96500000.00, 96500000.00, '2020-09-01', '2028-09-01', 'Ongoing');

-- count the list/number of projects --20
SELECT COUNT(*) FROM projects;

-- count the contractors --10
SELECT COUNT(*) FROM contractors

-- get the sum of project per contructor
SELECT 
	contractors.contractor_name,
	-- TO_CHAR
	TO_CHAR(SUM(projects.approved_budget), 'FM999,999,990.00')
FROM contractors
JOIN projects ON projects.contractor_id = contractors.id
GROUP BY contractors.contractor_name
ORDER BY SUM(projects.approved_budget) DESC
LIMIT(5);

-- group the results by province
-- get the top spending province and province amount
SELECT
	projects.province,
	-- TO_CHAR(value, format)
	TO_CHAR(SUM(projects.approved_budget), 'FM999,999,990.00')
FROM projects
GROUP BY projects.province
-- ORDER BY SUM(projects.project_cost) ASC
HAVING SUM(projects.approved_budget) = (
	SELECT MAX(total_cost_per_province)
	FROM (
		SELECT SUM(projects.approved_budget) as Total_cost_per_province
		FROM projects
		GROUP BY projects.province
	) AS highest_budget --AGUSAN 378,180,389.18
);


-- count the provinces 
SELECT COUNT(*) FROM projects WHERE province = 'Bukidnon';

-- count the projects of the contructor 
-- any column name that is not inside aggregate function eg. SUM(), AVG() must be included in GROUP BY
SELECT 
	province, 
	contractors.contractor_name, 
	TO_CHAR(approved_budget, 'FM999,999,990.00') 
FROM projects
JOIN contractors ON contractors.id = projects.contractor_id
WHERE contractors.contractor_name = UPPER('Ramises Construction')
GROUP BY province, contractors.contractor_name, approved_budget
ORDER BY province DESC



