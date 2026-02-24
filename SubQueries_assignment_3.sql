create database assignment_3;
use assignment_3;
CREATE TABLE Department (
    department_id VARCHAR(5) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);
INSERT INTO Department VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(5),
    salary INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);
INSERT INTO Employee VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);
INSERT INTO Sales VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');

# Retrieve the names of employees who earn more than the average salary of all employees
select name from employee
where salary > (select avg(salary) from employee);

#Find the employees who belong to the department with the highest average salary
select name from employee
where department_id = 
(select department_id  from employee
group by department_id
order by avg(salary) desc
limit 1);

#List all employees who have made at least one sale.
select name from employee
where emp_id in (select emp_id from sales);

#Find the employee with the highest sale amount.
select name from employee
where emp_id in 
(select emp_id from sales 
where sale_amount = (select max(sale_amount) from sales));

#Retrieve the names of employees whose salaries are higher than Shubham’s salary.
select name from employee
where salary > (select salary from employee where name = 'Shubham'); 

#Find employees who work in the same department as Abhishek.
select name from employee
where department_id = (select department_id from employee where name = 'Abhishek');

#List departments that have at least one employee earning more than ₹60,000.
select department_name from Department
where department_id IN(select department_id from employee where salary > 60000);

#Find the department name of the employee who made the highest sale.
select department_name from Department
where department_id = (select department_id from employee
where emp_id = (select emp_id from sales 
where sale_amount = (select max(sale_amount) from sales)));

#Retrieve employees who have made sales greater than the average sale amount
select name from employee
where emp_id in (select emp_id from sales
where sale_amount > (Select AVG(sale_amount) FROM Sales)
);

#Find the total sales made by employees who earn more than the average salary
select name from employee
where emp_id in (select emp_id from employee
where salary > (select Avg(salary) from employee));

#Find employees who have not made any sales
select name from employee
where emp_id not in (select emp_id from sales);

#List departments where the average salary is above ₹55,000
select department_name from department where department_id in (SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000);

#Retrieve department names where the total sales exceed ₹10,000
select department_name from department 
where department_id in (SELECT department_id FROM Employee
where emp_id in ( select emp_id from sales
group by emp_id
having sum(sale_amount) > 10000));

#Find the employee who has made the second-highest sale
select name from employee
where emp_id = (select emp_id from sales
order by sale_amount desc
limit 1 offset 1);

#Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
select name from employee
where salary > (select max(sale_amount) from sales);