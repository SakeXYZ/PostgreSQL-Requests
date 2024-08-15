# Структура базы данных компании

## Описание

Данная база данных предназначена для хранения информации о сотрудниках, отделах, локациях и регионах компании. Структура базы данных включает следующие таблицы:

- **employees**: Содержит информацию о сотрудниках, включая имя, фамилию, дату найма, зарплату, электронную почту, ID менеджера и ID отдела.
- **departments**: Содержит информацию об отделах, включая название, ID локации и ID менеджера.
- **locations**: Содержит информацию о локациях, включая название, адрес и ID региона.
- **regions**: Содержит информацию о регионах, включая их названия.

## Схема базы данных

_[Здесь можно добавить диаграмму базы данных, визуализирующую связи между таблицами]_

## Создание таблиц

Для создания таблиц используйте следующий SQL-код:

```sql
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

## Примеры запросов

```sql
-- Работники без почты или с некорректной почтой
SELECT * FROM employees 
WHERE email IS NULL OR email NOT LIKE '%@dualbootpartners.com';

-- Работники, нанятые за последние 30 дней
SELECT * FROM employees 
WHERE hire_date >= CURRENT_DATE - INTERVAL '30 days';

-- Максимальная и минимальная зарплата по департаментам
SELECT department_id, MAX(salary) AS max_salary, MIN(salary) AS min_salary 
FROM employees 
GROUP BY department_id;

-- Количество работников в каждом регионе
SELECT r.name AS region, COUNT(e.id) AS employee_count 
FROM employees e 
JOIN departments d ON e.department_id = d.id 
JOIN locations l ON d.location_id = l.id 
JOIN regions r ON l.region_id = r.id 
GROUP BY r.name;

-- Сотрудники с фамилией длиннее 10 символов
SELECT * FROM employees 
WHERE LENGTH(last_name) > 10;

-- Сотрудники с зарплатой выше средней
SELECT * FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);



