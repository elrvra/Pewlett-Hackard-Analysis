# Pewlett-Hackard-Analysis

## Overview of Project

Now that Bobby has proven his SQL chops, his manager has given both of you two more assignments: determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program. Then, you’ll write a report that summarizes your analysis and helps prepare Bobby’s manager for the “silver tsunami” as many current employees reach retirement age.

## Results

Deliverable 1: The Number of Retiring Employees by Title
**Note: Please refer to "Employee_Database_challenge.sql" file enclosed, although its copy/pasted as follows
-- Create retirement_titles.csv

Query: 
SELECT employees.emp_no, 
employees.first_name,
employees.last_name,
titles.title,
titles.from_date,
titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

Output:
![alt tag](https://github.com/elrvra/Pewlett-Hackard-Analysis/blob/main/Data/retirement_titles.png)

-- Use Dictinct with Orderby to remove duplicate rows & Create unique_titles.csv

Query:
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title

INTO unique_titles
FROM retirement_titles
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;

Output:
![alt tag](https://github.com/elrvra/Pewlett-Hackard-Analysis/blob/main/Data/unique_titles.png)

--Create retiring_titles.csv

Query:
SELECT COUNT(unique_titles.emp_no),
unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY COUNT(title) DESC;

Output:

![alt tag](https://github.com/elrvra/Pewlett-Hackard-Analysis/blob/main/Data/retiring_titles.png)

Deliverable 2: The Employees Eligible for the Mentorship Program
-- Create mentorship_eligibility.csv
Query:
SELECT DISTINCT ON (employees.emp_no)
employees.emp_no,
employees.first_name,
employees.last_name,
employees.birth_date,
dept_emp.from_date,
dept_emp.to_date,
titles.title
INTO mentorship_eligibility
FROM employees
LEFT JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no) 
LEFT JOIN titles
ON (employees.emp_no = dept_emp.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')

Output:
![alt tag](https://github.com/elrvra/Pewlett-Hackard-Analysis/blob/main/Data/mentorship_eligibility.png)

## Summary

Deliverable 3: A written report on the employee database analysis (README.md)

1. How many roles will need to be filled as the "silver tsunami" begins to make an impact?
-- Of the 300,024 employees, 90,398 roles will need to be filled.

2. Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett-Hackard employees?
-- Yes, there are more than enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett-Hackard employees: (a) 29414 Senior Engineer retirees vs 213 Senior Engineer mentees (b) 28254 Senior Staff retirees vs 633 Senior Staff mentees (c) 14222 Engineer retirees vs 623 Engineer mentees (d) 12243 Staff retirees vs 271 Staff mentees (e) 4502 Technique Leader retirees vs 99 Technique Leader mentees (f) 1761 Assistant Engineer retirees vs 101 Assistant Engineer mentees (g) 2 Manager retirees vs 0 Manager mentees.
