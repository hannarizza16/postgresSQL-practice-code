CREATE TABLE employees (
id serial primary key,
-- siblings_id int references siblings(id),
-- emp_id_pos int references employee_positions(id),
-- citizenship_id int references citizenship(id),
-- vehicle_id int references vehicle_brands(id),
first_name varchar,
last_name varchar
);

ALTER TABLE employees
ADD COLUMN siblings_id int references siblings(id);

ALTER TABLE employees
ADD COLUMN emp_id_pos int references positions(id);

ALTER TABLE employees
ADD COLUMN citizenship_id int references citizenship(id);

ALTER TABLE employees
ADD COLUMN vehicle_id int references vehicle_brands(id);

CREATE TABLE siblings(
id serial primary key,
employee_id int references employees(id),
first_name varchar,
last_name varchar,
UNIQUE (employee_id, first_name, last_name)
);

-- multiple positions 
CREATE TABLE positions(
id serial primary key,
employee_id int references employees(id),
job_title varchar,
job_description varchar,
hired_at timestamp
);

CREATE TABLE employee_positions(
employee_id int references employees(id),
position_id int references positions(id),
-- composite PK
PRIMARY KEY (employee_id, position_id)
);
-- other way
-- CREATE TABLE employee_positions(
-- employee_id int,
-- position_id int,
-- PRIMARY KEY (employee_id, position_id),
-- FOREIGN KEY (employee_id) references emmployee(id),
-- FOREIGN KEY (position_id) references positions(id)
-- )

CREATE TABLE citizenship (
id serial primary key,
employee_id int references employees(id),
country_code varchar
);

ALTER TABLE citizenship 
ADD COLUMN country_name varchar;

CREATE TABLE vehicle_brands(
id serial primary key,
employee_id int references employees(id),
car_brand varchar,
plate_number int
);

--  create table 

INSERT INTO employees (first_name, last_name)
VALUES
('Hanna Rizza', 'Malana');

INSERT INTO citizenship (country_code, country_name)
VALUES
('63', 'Philippines');


SELECT * FROM employees;

SELECT 
employees.first_name,
employees.last_name
FROM employees;

-- joining / left / right --confused pa sa left and right
SELECT 
e.first_name,
e.last_name,
c.country_name
FROM employees e
right JOIN citizenship c on e.id = c.id;



DROP TABLE employees, siblings;