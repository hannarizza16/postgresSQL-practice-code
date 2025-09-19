create table employees (
    id serial primary key,
    first_name varchar,
    last_name varchar,
    country varchar references countries,
    created_at timestamp
);

create table vehicle_brands (
    id serial primary key,
    name varchar,
    created_at timestamp
);

create table siblings (
    id serial,
    employee_id int references employees(id),
    first_name varchar,
    last_name varchar,
    created_at timestamp
);

create table countries (
    iso_country_code varchar primary key,
    name varchar,
    currency varchar,
    country_code int,
    created_at timestamp
);

create table positions (
    id serial primary key,
    employee_id int references employees(id),
    name varchar,
    job_description text
    hired_at timestamp
);

create table employee_positions (
    employee_id int references employees(id),
    position_id int references positions(id),
    hired_at timestamp
);

-- best career ending move (SS)
drop table siblings;
drop table employees;
drop table positions;

-- edgar codd
select * from employees;
select * from siblings;
select * from vehicle_brands;
select * from countries;
select * from positions;
select * from employee_positions;

select
    s.id,
    s.first_name,
    s.last_name,
    c.name
from employees e
join siblings s ON s.employee_id = e.id
JOIN countries c ON c.iso_country_code = e.country;


select
    employees.first_name,
    employees.last_name,
    p.name as position,
    ep.hired_at
from employees
join employee_positions ep on employees.id = ep.employee_id
join positions p on ep.position_id = p.id
order by ep.hired_at
