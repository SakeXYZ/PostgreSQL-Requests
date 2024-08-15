
## Создание таблиц

Для создания базы данных с информацией о сотрудниках, департаментах, местоположениях и регионах, используйте следующие SQL-команды:

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



SQL-запросы для выборок
Используйте следующие SQL-запросы для получения данных из базы:

1. Работники без почты или с некорректной почтой
Этот запрос выбирает всех сотрудников, у которых отсутствует почтовый адрес или он указан неправильно:

sql
Copy code
SELECT * FROM employees 
WHERE email IS NULL OR email NOT LIKE '%@dualbootpartners.com';
2. Работники, нанятые за последние 30 дней
Запрос выводит всех сотрудников, которые были наняты в течение последних 30 дней:

sql
Copy code
SELECT * FROM employees 
WHERE hire_date >= CURRENT_DATE - INTERVAL '30 days';
3. Максимальная и минимальная зарплата по департаментам
Запрос определяет максимальные и минимальные зарплаты в каждом департаменте:

sql
Copy code
SELECT department_id, MAX(salary) AS max_salary, MIN(salary) AS min_salary 
FROM employees 
GROUP BY department_id;
4. Количество работников в каждом регионе
Запрос выводит количество работников в каждом регионе:

sql
Copy code
SELECT r.name AS region, COUNT(e.id) AS employee_count 
FROM employees e 
JOIN departments d ON e.department_id = d.id 
JOIN locations l ON d.location_id = l.id 
JOIN regions r ON l.region_id = r.id 
GROUP BY r.name;
5. Сотрудники с фамилией длиннее 10 символов
Этот запрос выбирает всех сотрудников, чья фамилия длиннее 10 символов:

sql
Copy code
SELECT * FROM employees 
WHERE LENGTH(last_name) > 10;
6. Сотрудники с зарплатой выше средней
Запрос находит всех сотрудников, чья зарплата выше средней по компании:

sql
Copy code
SELECT * FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);
