-- Select all employees
SELECT * FROM emp;

-- Get employees earning more than average salary 
WITH average_salary (avg_sal) AS
	(SELECT CAST(AVG(salary) AS INT) FROM emp)
SELECT * FROM emp e, average_salary av WHERE e.salary > av.avg_sal;

-- Select all sales
SELECT * FROM sales;

-- Without WITH Clause : Fetch stores who's sales greater than average sales across all stores
-- 1- Get total sales for each store
SELECT SUM(s.cost) AS total_sales_per_store FROM sales s GROUP BY s.store_id;

-- 2- Get average sales across all stores
SELECT CAST(AVG(total_sales_per_store) AS INT) AS average_sales
	FROM (SELECT SUM(s.cost) AS total_sales_per_store FROM sales s GROUP BY s.store_id);

-- 3- Fetch stores that surpass the average sales
SELECT * FROM
	(SELECT SUM(s.cost) AS total_sales_per_store FROM sales s GROUP BY s.store_id)
	JOIN (
		SELECT CAST(AVG(total_sales_per_store) AS INT) AS average_sales
		FROM (SELECT SUM(s.cost) AS total_sales_per_store FROM sales s GROUP BY s.store_id)
	)
ON total_sales_per_store > average_sales;