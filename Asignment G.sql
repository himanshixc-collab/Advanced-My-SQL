CREATE DATABASE asgnG;
USE asgnG;

#create table and insert values

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
department VARCHAR(50),
salary INT
);

INSERT INTO employees VALUES
(1, 'Alice', 'HR', 45000),
(2, 'Bob', 'IT', 72000),
(3, 'Charlie', 'Finance', 60000),
(4, 'Diana', 'IT', 85000),
(5, 'Eve', 'HR', 48000),
(6, 'Frank', 'Finance', 62000);

#create a procedure to show all employees details

DELIMITER //
CREATE PROCEDURE ShowAllEmployees()
BEGIN
SELECT * FROM employees;
END //
DELIMITER ;

CALL ShowAllEmployees();

#create a stored procedure to fetch all employees from a specific department

DELIMITER //
CREATE PROCEDURE Emp_by_dept(IN dept_name VARCHAR(50))
BEGIN
SELECT * FROM employees WHERE department = dept_name;
END //
DELIMITER ;

CALL Emp_by_dept('IT');

#create a stored procedure to increase salary by a given percentage for a department

DELIMITER //
CREATE PROCEDURE IncreaseSalaryByDept(IN dept_name VARCHAR(50), IN percent_increase INT)
BEGIN
UPDATE employees
SET salary = salary + (salary * percent_increase / 100)
WHERE department = dept_name;
END //
DELIMITER ;

CALL IncreaseSalaryByDept('IT', 10);

#create a procedure to return the total salary of all employees

DELIMITER //
CREATE PROCEDURE TotalSalary()
BEGIN
SELECT SUM(salary) AS Total_salary
FROM employees;
END //
DELIMITER ;

CALL TotalSalary();

#create a procedure to insert a new employee into an existing table

DELIMITER //
CREATE PROCEDURE AddEmp(
IN emp_name VARCHAR(50),
IN emp_dept VARCHAR(50),
IN emp_salary INT)
BEGIN
INSERT INTO employees (name, department, salary)
VALUES (emp_name, emp_dept, emp_salary);
END //
DELIMITER ;

CALL AddEmp('Frank', 'Finance', 62000);

#create a procedure to delete an existing employee from the table by id

DELIMITER //
CREATE PROCEDURE DeleteEmpByID(IN empID INT)
BEGIN
DELETE FROM employees WHERE id = empID;
END //
DELIMITER ;

CALL DeleteEmpByID(3);

#create a procedure to return average salary

DELIMITER //
CREATE PROCEDURE AvgSalary()
BEGIN
SELECT AVG(salary) AS avg_salary
FROM employees;
END //
DELIMITER ;

CALL AvgSalary();

#create a procedure to get employees above a salary

DELIMITER //
CREATE PROCEDURE Above_Sal(IN s_Salary INT)
BEGIN
SELECT * FROM employees
WHERE salary > s_Salary;
END //
DELIMITER ;

CALL Above_Sal(60000);

#create a procedure to get highest salary

DELIMITER //
CREATE PROCEDURE HighestSalary()
BEGIN
SELECT MAX(salary) AS highest_salary
FROM employees;
END //
DELIMITER ;

CALL HighestSalary();

#create a procedure to update employee name

DELIMITER //
CREATE PROCEDURE ChangeName(IN emp_name VARCHAR(50), IN emp_id INT)
BEGIN
UPDATE employees
SET name = emp_name
WHERE id = emp_id;
END //
DELIMITER ;

CALL ChangeName('Rhea', 2);