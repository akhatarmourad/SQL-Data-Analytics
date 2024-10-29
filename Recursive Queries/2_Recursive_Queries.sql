-- SELECT all employees details
SELECT * FROM emp_details;

-- Global Syntax in PostgreSQL
WITH [RECURSIVE] CTE_name AS 
	(
		Base Query or Initial Query
		UNION [ALL]
		Recursive Query that references the CTE + termination condition
	)

SELECT * FROM CTE_name;

-- Question 1 : loop through numbers from 0 to 10 using recursion
WITH RECURSIVE numbers_loop AS 
	(
		SELECT 1 AS n
		UNION ALL
		SELECT n + 1 FROM numbers_loop WHERE n < 10
	)

SELECT * FROM numbers_loop;

-- Question 2 : Find employees supervised by a given manager
WITH RECURSIVE manager_employees AS
	(
		SELECT id, name, manager_id, 1 AS level FROM emp_details WHERE name = 'Asha'
		UNION ALL
		SELECT ED.id, ED.name, ED.manager_id, (level + 1) AS level FROM manager_employees ME JOIN emp_details ED ON ME.id = ED.manager_id
	)

SELECT * FROM manager_employees;