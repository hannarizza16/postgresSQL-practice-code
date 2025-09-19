-- There are 2 types of constraints
-- 1. Column-level constraints
-- 2. Table-level constraints

-- column-level constraints are defined right after the column datatype
-- table-level constraints are defined at the end of the table definition

-- column level contstraints
CREATE TABLE students (
    id serial PRIMARY KEY, -- column-level constraint
    first_name varchar NOT NULL, -- column-level constraint
    last_name varchar NOT NULL, -- column-level constraint
    email varchar UNIQUE, -- column-level constraint
    created_at timestamp DEFAULT CURRENT_TIMESTAMP -- column-level constraint
)

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,         -- column-level primary key
    first_name VARCHAR NOT NULL,   -- column-level not null
    email VARCHAR UNIQUE           -- column-level unique
);

-- table-level constraints
CREATE TABLE courses (
    id serial,
    name varchar NOT NULL, -- column-level constraint
    description text,  -- column-level constraint
    created_at timestamp DEFAULT CURRENT_TIMESTAMP, -- column-level constraint
    PRIMARY KEY (id), -- table-level constraint
    UNIQUE (name) -- table-level constraint
);

CREATE TABLE employee_positions (
    employee_id INT,
    position_id INT,
    PRIMARY KEY (employee_id, position_id),  -- table-level PK
    FOREIGN KEY (employee_id) REFERENCES employees(id), -- table-level FK
    UNIQUE (employee_id, position_id)        -- table-level unique
);
