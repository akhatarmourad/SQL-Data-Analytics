-- Select all employees
SELECT * FROM emp;

-- Get employees earning more than average salary 
WITH average_salary (avg_sal) AS
	(SELECT CAST(AVG(salary) AS INT) FROM emp)
SELECT * FROM emp e, average_salary av WHERE e.salary > av.avg_sal;

-- Select all sales
SELECT * FROM sales;

-- Fetch stores who's sales greater than average sales across all stores
