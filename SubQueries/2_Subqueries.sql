-- Select all data from all tables
SELECT * FROM employees_table
SELECT * FROM departments_table
SELECT * FROM sales_table
SELECT * FROM employees_history

-- Q1 : Select employees who's salary is greater then the average salary
SELECT * FROM employees_table WHERE salary > (SELECT AVG(salary) FROM employees_table);

-- Type 1 Of Subqueries : Scalary Subquery
SELECT e.*, (avg_sal.average_salary || ' $') AS average_salary FROM employees_table e
	JOIN (SELECT ROUND(AVG(salary), 2) AS average_salary FROM employees_table) avg_sal
	ON e.salary > avg_sal.average_salary;

-- Type 2 Of Subqueries : Multiple Row Subquery
-- Multiple Rows & Multiple Columns : Fetch highest paid employees in each group
SELECT * FROM employees_table e
	WHERE (dept_name, salary)
	IN (SELECT dept_name, MAX(salary) AS max_salary FROM employees_table GROUP BY dept_name);

-- Single Cloumn & Multiple Rows : Fecth departments who don't have any employee
SELECT * FROM departments_table d WHERE d.dept_name NOT IN (SELECT DISTINCT dept_name FROM employees_table);

-- Type 3 Of Subqueries : Correlated Subquery
-- Question 1 : get employees that earn more than the average salary in each department
SELECT * FROM employees_table e1
	WHERE e1.salary > (
		SELECT ROUND(AVG(salary), 2) AS average_salary FROM employees_table e2 WHERE e2.dept_name = e1.dept_name
	);

-- Question 2 : Find departmenst that don't have any employye using correlated subquery
SELECT * FROM departments_table d
	WHERE NOT EXISTS (SELECT * FROM employees_table e WHERE d.dept_name = e.dept_name);

-- Type 4 Of Subqueries : Get store where total sales are above the average sales of all stores
SELECT * FROM sales_table
	WHERE SUM(price) > (SELECT ROUND(AVG(total_sales), 2) AS average_sales
							FROM (SELECT store_name, SUM(price) AS total_sales FROM sales_table GROUP BY store_name)
	)