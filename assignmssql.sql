create database testdb;
use testdb;


CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,    
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no     CHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE  KEY (dept_name)
);

CREATE TABLE dept_manager (
   emp_no       INT             NOT NULL,
   dept_no      CHAR(4)         NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)    ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
); 

CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
) 
; 

CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
) 
; 

/*Inserted data from cmd "C:\Program Files\MySQL\MySQL Server 8.0"*/

/*Q1*/
SELECT * FROM employees;
SELECT gender, COUNT(*) AS count_number FROM employees GROUP BY gender ORDER BY count_number DESC;
/*Q2*/
/*Find the average salary by employee title, round to 2 decimal places and order by descending order*/
SELECT t.title, AVG(salary) AS avg_salary
FROM titles t
INNER JOIN salaries s ON t.emp_no = s.emp_no
GROUP BY title
ORDER BY avg_salary DESC;

/*Q3*/
/*
Find all the employees that have worked in at least 2 departments. Show their first name, last_name and the number of departments they work in. Display all results in ascending order.*/
SELECT e.first_name, e.last_name, COUNT(de.dept_no) AS dept_count
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
GROUP BY e.emp_no
HAVING dept_count >= 2
ORDER BY dept_count ASC;

/*Q4*/
/*Display the first name, last name, and salary of the highest payed employee.*/

SELECT e.first_name,e.last_name,s.salary FROM employees e INNER JOIN salaries s ON e.emp_no = s.emp_no ORDER BY s.salary DESC LIMIT 1;

/*Q5*/
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY s.salary DESC
LIMIT 1 OFFSET 1;

/*Q6*/
SELECT MONTH(hire_date) AS hire_month, COUNT(*) AS total_hires
FROM employees
GROUP BY hire_month
ORDER BY total_hires DESC
LIMIT 1;

/*Q7*/
SELECT d.dept_name, MIN(YEAR(hire_date) - YEAR(birth_date)) AS age_at_hire
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name;

/*Q8*/
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE e.first_name NOT REGEXP '[AEIOUaeiou]';

