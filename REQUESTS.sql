CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    hire_date DATE,
    salary INTEGER,
    email VARCHAR(100),
    manager_id INTEGER REFERENCES employees(id),
    department_id INTEGER REFERENCES departments(id)
);

CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    location_id INTEGER REFERENCES locations(id),
    manager_id INTEGER REFERENCES employees(id)
);

CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    region_id INTEGER REFERENCES regions(id)
);

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);




SELECT * FROM employees
WHERE email IS NULL OR email NOT LIKE '%@dualbootpartners.com';

SELECT * FROM employees
WHERE hire_date >= CURRENT_DATE - INTERVAL '30 days';


SELECT department_id, MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM employees
GROUP BY department_id;



SELECT r.name AS region, COUNT(e.id) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.id
JOIN locations l ON d.location_id = l.id
JOIN regions r ON l.region_id = r.id
GROUP BY   
 r.name;




SELECT * FROM employees
WHERE LENGTH(last_name) > 10;



SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
