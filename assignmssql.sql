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
