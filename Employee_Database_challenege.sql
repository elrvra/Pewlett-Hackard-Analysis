-- Deliverable 1
-- Create retirement_titles.csv
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

-- Use Dictinct with Orderby to remove duplicate rows & Create unique_titles.csv
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title

INTO unique_titles
FROM retirement_titles
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;

--Create retiring_titles.csv
SELECT COUNT(unique_titles.emp_no),
unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY COUNT(title) DESC;

-- Deliverable 2
-- Mentorship Eligibility
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
