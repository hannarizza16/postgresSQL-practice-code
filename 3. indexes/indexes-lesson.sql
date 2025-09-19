QUERY PLAN
Gather  (cost=1000.00..14934.43 rows=1 width=37) (actual time=57.111..58.573 rows=1 loops=1)
  Workers Planned: 2
  Workers Launched: 2
  Buffers: shared hit=8726
  ->  Parallel Seq Scan on employees  (cost=0.00..13934.33 rows=1 width=37) (actual time=36.495..41.071 rows=0 loops=3)
        Filter: ((name)::text = 'Employee500000'::text)
        Rows Removed by Filter: 333333
        Buffers: shared hit=8726
Planning Time: 0.121 ms
Execution Time: 58.615 ms

drop table employees;

create table employees (
    id serial primary key,
    name varchar(100),
    is_active bool,
    department varchar(100),
    salary decimal(10, 2),
    hired_at date
);

select COUNT(*) from employees;

select generate_series(1, 100);
select random()

insert into employees(name, is_active, department, salary, hired_at)
select
    'Employee' || generate_series(1, 1000000),
    CASE (random() * 1)::INT
        WHEN 0 THEN false
        ELSE true
    END,
    CASE (random() * 4)::INT
        WHEN 0 THEN 'Sales'
        WHEN 1 THEN 'Engineering'
        WHEN 2 THEN 'Finance'
        WHEN 3 THEN 'IT'
        ELSE 'Operations'
    END,
    30000 + (random() * 10000),
    DATE '2020-01-01' + (random() * 1460)::INT;

explain (analyze, buffers)
select
    *
from employees
where name = 'Employee500000';

-- QUERY PLAN
-- Gather  (cost=1000.00..14934.43 rows=1 width=37) (actual time=57.111..58.573 rows=1 loops=1)
--   Workers Planned: 2
--   Workers Launched: 2
--   Buffers: shared hit=8726
--   ->  Parallel Seq Scan on employees  (cost=0.00..13934.33 rows=1 width=37) (actual time=36.495..41.071 rows=0 loops=3)
--         Filter: ((name)::text = 'Employee500000'::text)
--         Rows Removed by Filter: 333333
--         Buffers: shared hit=8726
-- Planning Time: 0.121 ms
-- Execution Time: 58.615 ms

-- run #2
-- QUERY PLAN
-- Index Scan using idx_employee_name on employees  (cost=0.42..8.44 rows=1 width=37) (actual time=0.239..0.242 rows=1 loops=1)
--   Index Cond: ((name)::text = 'Employee500000'::text)
--   Buffers: shared hit=4
-- Planning Time: 1.896 ms
-- Execution Time: 0.294 ms

create index idx_employee_name ON employees(name); -- btree
create index idx_department_hash ON employees USING HASH (department); -- specific equality check

explain (analyse, buffers)
select
    *
from employees
where department = 'IT';


explain (analyze, buffers)
select
    *
from employees
where name = 'Employee500000';

explain (analyze, buffers)
select
    *
from employees
where name like 'Employee5%';

--GIN
create table products
(
    id serial primary key,
    name varchar(100),
    plate_number varchar(100),
    serial_number varchar(100),
    kit_number varchar(100),
    port varchar(100),
    tags text[]
);

insert into products(name, tags) VALUES
    ('Starlink Enterprise Flat-High Performance', ARRAY['starlink', 'flat-high', 'satellite']) ,
    ('Mouse', ARRAY['accessories', 'computer', 'electronics']),
    ('Shampoo', ARRAY['hair-care', 'soap'])
    ('Hilux', ARRAY['hair-care', 'soap']);

insert into products(name, tags) VALUES
    ('Keyboard', ARRAY['accessories', 'computer', 'electronics']);

explain (analyze, buffers)
select * from products WHERE tags @> ARRAY['electronics'];

CREATE INDEX idx_gin_tags ON products USING GIN(tags);

-- QUERY PLAN
-- Seq Scan on products  (cost=0.00..13.50 rows=1 width=254) (actual time=0.039..0.041 rows=2 loops=1)
--   Filter: (tags @> '{electronics}'::text[])
--   Rows Removed by Filter: 2
--   Buffers: shared hit=1
-- Planning Time: 0.073 ms
-- Execution Time: 0.053 ms

-- QUERY PLAN
-- Seq Scan on products  (cost=0.00..1.05 rows=1 width=254) (actual time=0.010..0.012 rows=2 loops=1)
--   Filter: (tags @> '{electronics}'::text[])
--   Rows Removed by Filter: 2
--   Buffers: shared hit=1
-- Planning:
--   Buffers: shared hit=1
-- Planning Time: 0.099 ms
-- Execution Time: 0.023 ms
--

select
    *
from employees;

CREATE INDEX idx_active_employees ON employees(name)
WHERE is_active = true;

create index idx_name_lower ON employees(LOWER(name));

explain (analyse, buffers)
select
    *
from employees
WHERE name = 'Employee5000'
AND is_active = false;

explain (analyse, buffers)
select
    *
from employees
WHERE lower(name) = 'employee5000'