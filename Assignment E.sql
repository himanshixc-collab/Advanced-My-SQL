CREATE DATABASE assignmentE;
USE assignmentE;


CREATE TABLE Sales (
    id INT,
    employee VARCHAR(50),
    department VARCHAR(10),
    sales_amount INT,
    sale_date DATE
);

INSERT INTO Sales VALUES
(1, 'Alice', 'A', 1000, '2024-01-01'),
(2, 'Bob',   'B', 1500, '2024-01-02'),
(3, 'Alice', 'A', 2000, '2024-01-03'),
(4, 'Bob',   'B', 1800, '2024-01-04'),
(5, 'Alice', 'A', 1200, '2024-01-05'),
(6, 'Bob',   'B', 1600, '2024-01-06');

#Total sales per employee (Running Total)
SELECT id, employee, sales_amount, sale_date,
SUM(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS running_total
FROM Sales;

#Row number per employee
SELECT id, employee, sales_amount, sale_date,
ROW_NUMBER() OVER (PARTITION BY employee ORDER BY sale_date) AS row_num
FROM Sales;

#Rank of sales per department.
SELECT id, employee, department, sales_amount,
RANK() OVER (PARTITION BY department ORDER BY sales_amount DESC) AS sales_rank
FROM Sales;

#Lead (next sale) per employee.
SELECT id, employee, sales_amount, sale_date,
LEAD(sales_amount,1) OVER (PARTITION BY employee ORDER BY sale_date) AS next_sale
FROM Sales;

#Lag (previous sale) per employee.
SELECT id, employee, sales_amount, sale_date,
LAG(sales_amount,1) OVER (PARTITION BY employee ORDER BY sale_date) AS prev_sale
FROM Sales;

#Average sales per employee.
SELECT id, employee, sales_amount,
AVG(sales_amount) OVER (PARTITION BY employee) AS avg_sales
FROM Sales;

#First and last sales per employee.
SELECT id, employee, sales_amount, sale_date,
FIRST_VALUE(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS first_sale,
LAST_VALUE(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale
FROM Sales;

#Dense rank (no gaps).
SELECT id, employee, department, sales_amount,
DENSE_RANK() OVER (PARTITION BY department ORDER BY sales_amount DESC) AS dense_rnk
FROM Sales;

#Cumulative average per employee.
SELECT id, employee, sales_amount, sale_date,
AVG(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_avg
FROM Sales;

#Find highest sale per employee.
SELECT id, employee, sales_amount,
MAX(sales_amount) OVER (PARTITION BY employee) AS highest_sale
FROM Sales;

#Sales difference from previous record.
SELECT id, employee, sales_amount, sale_date,
sales_amount - LAG(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS sales_diff
FROM Sales;

#Cumulative count of sales per employee.
SELECT id, employee, sales_amount, sale_date,
COUNT(*) OVER (PARTITION BY employee ORDER BY sale_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_count
FROM Sales;

#Show if sale is above average per employee.
SELECT id, employee, sales_amount,
AVG(sales_amount) OVER (PARTITION BY employee) AS avg_sales,
CASE 
WHEN sales_amount > AVG(sales_amount) OVER (PARTITION BY employee) 
THEN 'Yes' ELSE 'No' 
END AS above_avg
FROM Sales;

#Find second highest sale per employee
SELECT DISTINCT employee, sales_amount AS second_highest
FROM (
SELECT employee, sales_amount,
DENSE_RANK() OVER (PARTITION BY employee ORDER BY sales_amount DESC) AS rnk
FROM Sales
) ranked
WHERE rnk = 2;