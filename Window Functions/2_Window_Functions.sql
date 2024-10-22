SELECT * FROM employee

-- Get Max Salary by Department
SELECT employee.dept_name, max(salary) as Max_Salary FROM employee GROUP BY dept_name