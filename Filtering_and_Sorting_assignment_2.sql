create database assignment2_db;
use assignment2_db;

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Department VARCHAR(50),
    City VARCHAR(50),
    Salary INT,
    HireDate DATE
);

INSERT INTO Employees (EmpID, EmpName, Department, City, Salary, HireDate)
VALUES
(101, 'Rahul Mehta', 'Sales', 'Delhi', 55000, '2020-04-12'),
(102, 'Priya Sharma', 'HR', 'Mumbai', 62000, '2019-09-25'),
(103, 'Aman Singh', 'IT', 'Bengaluru', 72000, '2021-03-10'),
(104, 'Neha Patel', 'Sales', 'Delhi', 48000, '2022-01-14'),
(105, 'Karan Joshi', 'Marketing', 'Pune', 45000, '2018-07-22'),
(106, 'Divya Nair', 'IT', 'Chennai', 81000, '2019-12-11'),
(107, 'Raj Kumar', 'HR', 'Delhi', 60000, '2020-05-28'),
(108, 'Simran Kaur', 'Finance', 'Mumbai', 58000, '2021-08-03'),
(109, 'Arjun Reddy', 'IT', 'Hyderabad', 70000, '2022-02-18'),
(110, 'Anjali Das', 'Sales', 'Kolkata', 51000, '2023-01-15');

select * from employees
where department IN ('IT', 'HR');

select * from employees
where department IN ('Sales', 'IT', 'Finance');

select * from employees
where salary between 50000 and 70000;

select * from employees
where empname like('A%');

select * from employees
where empname like('%an%');

select * from employees
where city in ('Delhi', 'Mumbai')
and salary > 55000;

select * from employees
where department <> 'HR';

select * from employees
where HireDate between '2019-01-01' and '2022-12-31'
order by HireDate;