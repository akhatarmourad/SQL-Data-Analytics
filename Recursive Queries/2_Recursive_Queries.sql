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
		SELECT ED.id, ED.name, ED.manager_id, (ME.level + 1) AS level FROM manager_employees ME JOIN emp_details ED ON ME.id = ED.manager_id
	)

SELECT ME.id, ME.name, ME.manager_id, ME.level, ED.name FROM manager_employees ME JOIN emp_details ED ON ME.manager_id = ED.id;

-- Question 3 : Find managers hierarchy for a given employee
WITH RECURSIVE employee_managers AS
	(
		SELECT E2.id AS id, E2.name AS manager_name, E2.designation, E2.manager_id
			FROM emp_details E1 RIGHT JOIN emp_details E2 ON E1.manager_id = E2.id WHERE E1.name = 'David'
		UNION 
		SELECT ED.id, ED.name AS manager_name, ED.designation, ED.manager_id
			FROM employee_managers EM
				JOIN emp_details ED ON EM.manager_id = ED.id
	)

SELECT * FROM employee_managers;