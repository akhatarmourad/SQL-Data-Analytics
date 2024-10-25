ROLLBACK;

SELECT * FROM employee;

-- Get Max Salary by Department
SELECT employee.dept_name, max(salary) as Max_Salary FROM employee GROUP BY dept_name;

-- Get Max Salary by Department + All Employees Infos
SELECT e.*, MAX(salary) OVER(PARTITION BY e.dept_name) as Max_Salary FROM employee e;

-- Assing a number to each row for each department
SELECT e.*, ROW_NUMBER() OVER(PARTITION BY e.dept_name ORDER BY e.emp_id) FROM employee e;

-- Fecth the 2 First employees from each department
SELECT emp.* FROM (
	SELECT e.*, ROW_NUMBER() OVER(PARTITION BY e.dept_name) FROM employee e
) emp WHERE emp.row_number < 3;

-- RANK : Fetch top 3 employees by salary in from department
SELECT emp.* FROM (
	SELECT e.*, RANK() OVER(PARTITION BY e.dept_name ORDER BY salary DESC) as employee_rank FROM employee e
) emp WHERE emp.employee_rank < 3;

-- DENSE RANK
SELECT e.*, DENSE_RANK() OVER(PARTITION BY e.dept_name ORDER BY e.salary DESC) as employee_rank FROM employee e;

-- LAG & LEAD : Next & Previous values of a column
SELECT e.*,
	LAG(salary, 2, 0) OVER(PARTITION BY dept_name ORDER BY emp_id) AS previous_salary,
	LEAD(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) AS next_salary
FROM employee e;

-- Check difference between Current & Previous Salary
SELECT e.*,
	LAG(e.salary) OVER(PARTITION BY e.dept_name ORDER BY e.emp_id) AS previous_salary,
	CASE
		WHEN e.salary > LAG(e.salary) OVER(PARTITION BY e.dept_name ORDER BY e.emp_id) THEN 'Current Salary is Higher than Previous One'
		WHEN e.salary < LAG(e.salary) OVER(PARTITION BY e.dept_name ORDER BY e.emp_id) THEN 'Current Salary is Lower then Previous One'
		WHEN e.salary = LAG(e.salary) OVER(PARTITION BY e.dept_name ORDER BY e.emp_id) THEN 'Salaries are equal'
	END Difference
FROM employee e;