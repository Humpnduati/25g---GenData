USE school;
SHOW TABLES;    

CREATE TABLE students(
student_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25),
age INT(2),
sex VARCHAR(6),
course VARCHAR(25)
 
);

SHOW TABLES;
DESCRIBE students; 

INSERT INTO students VALUES (1, 'Humphrey', 'Nduati', 36, 'Male', 'Data Science');
INSERT INTO students (student_id, first_name, last_name, age, sex, course) VALUES (2, 'Mercy', 'Mwangi', 35, 'Female', 'Data Science');

-- Multiple rows 
INSERT INTO students (student_id, first_name, last_name, age, sex, course) VALUES
(3, 'Esther', 'Njeri', 31, 'Female', 'Data Analyst'),
(5, 'Mike', 'Jones', 32, 'Male', 'Software Engineering'),
(7, 'Thesh', 'Githu', 30, 'Female', 'Web Programming'),
(8, 'Beryl', 'Osika', 36, 'Female', 'Data Analyst'),
(6, 'Linda', 'Miles', 29, 'Female', 'Web Programming'),
(9, 'Robert', 'Kibe', 34, 'Male', 'Data Science'),
(10, 'Peter', 'Mutei', 32, 'Male', 'Software Engineering');

SELECT * FROM students;

SELECT first_name, last_name, sex FROM students WHERE student_id > 2; 

-- TRUE conditons with WHERE clauses  -- FILTERING.
SELECT * FROM students WHERE course = 'Data Science';
SELECT * FROM students WHERE sex = 'Female';

-- FALSE condition with WHERE / WHERE NOT clauses -- filterin out data that we don't need.
SELECT * FROM students WHERE NOT student_id = 4;
SELECT * FROM students WHERE student_id <> 3;

-- AND Operator / && -- filtering
SELECT * FROM students WHERE (age > 31 AND sex = 'male');
SELECT * FROM students WHERE age < 33 && sex = 'Female';
SELECT * FROM students WHERE (age > 30 AND NOT student_id = 4);

-- OR Operator / ||--filtering
SELECT * FROM students WHERE (student_id = 2 OR student_id = 7);
SELECT * FROM students WHERE student_id = 2 || student_id = 7;
SELECT * FROM students WHERE course = 'Data Science' || course = 'web Programming';
SELECT * FROM students WHERE sex = 'Female' || course = 'web Programming';

-- IN Operator -- filtering
SELECT * FROM students WHERE age IN(30, 33);
SELECT * FROM students WHERE age IN (30, 32, 34);
SELECT * FROM students WHERE student_id IN (1, 4, 9, 6);

-- EXISTS condition
USE store;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

SELECT * FROM customers WHERE EXISTS (SELECT * FROM orders WHERE orders.customer_id = customers.customer_id); 

-- NOT IN/ NOT EXISTS Conditions
USE school;
SELECT * FROM students WHERE age NOT IN ( 37,35,33);
USE store;
SELECT * FROM customers WHERE NOT EXISTS (SELECT * FROM orders WHERE orders.customer_id = customers.customer_id); 

-- LIKE Operators '%'
SELECT * FROM students WHERE first_name LIKE 'e%';
SELECT * FROM students WHERE first_name LIKE '%e';  
SELECT * FROM students WHERE last_name LIKE '%i';
SELECT * FROM students WHERE first_name LIKE '%s%';
SELECT * FROM students WHERE last_name NOT LIKE '%u%';
SELECT * FROM students WHERE first_name LIKE 'N_';

-- BETWEEN Operators
SELECT * FROM students WHERE age BETWEEN 28 AND 33;

-- Numeric Operators +, -, *, /
SELECT 10 + 15;
SELECT first_name, age + 10 FROM students;

-- Concatenation Operators -- CONCAT function
SELECT first_name ||','|| last_name AS full_name FROM students; 
SELECT CONCAT (first_name, ' ' , last_name ) AS full_name FROM students;

-- Temporal Operator
SELECT CURRENT_DATE + INTERVAL 7 DAY AS week;
SELECT CURRENT_DATE - INTERVAL 7 DAY AS week; 

-- GROUP BY clause
SELECT course, COUNT(*) FROM students GROUP BY course;
SELECT course, COUNT(*) FROM students WHERE course = 'Data Science' GROUP BY course;
SELECT sex, COUNT(*) FROM students GROUP BY sex;

SELECT * FROM students LIMIT 5;
-- HAVING Clause
SELECT course, COUNT(*) FROM students GROUP BY course HAVING COUNT(*) < 3;

-- ORDER BY Clause
SELECT * FROM students ORDER BY first_name, last_name;
SELECT * FROM students ORDER BY age DESC;

-- SQL Aliases
SELECT s.first_name, s.last_name FROM students AS s;
SELECT COUNT(*) AS 'Total Students' From students;

-- SQL DATES
SELECT NOW();
SELECT * FROM orders WHERE orderdate = '2016-01-12 11:48:15';
SELECT CURDATE();
SELECT CURTIME();

-- INSERT INTO SELECT Statement
CREATE TABLE students_old(
student_id INT NOT NULL,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25),
age INT(2),
sex VARCHAR(6),
course VARCHAR(25)
);
INSERT INTO students_old SELECT* FROM students;
SELECT * FROM students_old;

CREATE TABLE students_new(
student_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25),
age INT(2),
sex VARCHAR(6),
course VARCHAR(25)
);

INSERT INTO students_new (student_id, first_name, last_name) SELECT student_id, first_name, last_name FROM students;
SELECT * FROM students;

-- UPDATE Statement
UPDATE students SET course = 'Data Analyst' WHERE student_id = 9;
SELECT * FROM students;

-- DELETE Statement
SELECT * FROM students_old;
DELETE FROM students_old WHERE student_id = 2;
DELETE FROM students_new;
SHOW TABLES;

-- JOINS --
CREATE DATABASE joins;
USE joins;

CREATE TABLE table1 (column1 INT);
CREATE TABLE table2 (column2 INT);

SHOW TABLES;

INSERT INTO table1 VALUES (11), (12), (13), (14), (15);
INSERT INTO table2 VALUES (12), (15), (53);



SELECT * FROM  table1;
SELECT * FROM table2;

-- INNER JOIN
SELECT * FROM table1 INNER JOIN table2 on table1.column1 = table2.column2;

USE store;
SELECT * FROM customers;
SELECT * FROM orders;

SELECT first_name, last_name, city FROM customers INNER JOIN orders ON customers.customer_id = orders.customer_id;
SELECT first_name, last_name, phone, address, city, state FROM customers INNER JOIN orders ON customers.customer_id = orders.customer_id; 

-- OUTER  JOIN -- LEFT OUTER JOIN
USE joins;
SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.column1 = table2.column2;

-- OUTER JOIN -- RIGHT OUTER JOIN
SELECT * FROM table1 RIGHT OUTER JOIN table2 ON table1.column1 = table2.column2;

-- CROSS JOIN
SELECT * FROM table1 CROSS JOIN table2 ;

-- UNION Operator
SELECT * FROM table1 UNION SELECT * FROM table2;

USE store;
CREATE VIEW active_proj AS SELECT customers.first_name, customers.phone, customers.city, orders.status FROM customers INNER JOIN orders ON customers.customer_id = orders.customer_id;
SELECT * FROM active_proj;