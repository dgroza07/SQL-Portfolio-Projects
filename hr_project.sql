Create Database hr_project;

Use hr_project;

Select *
From hr;

-- date cleaning and preprocessing 

ALTER TABLE hr 
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

-- change the data format and data type of birthdate, hire_date, AND termdate column


UPDATE hr
SET birthdate = CASE
		WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
        WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
        ELSE NULL
        END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
		WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
        WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
        ELSE NULL
        END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';

UPDATE hr
SET termdate = NULL
WHERE termdate = '';

-- completed the data format and data type of birthdate, hire_date, AND termdate column

-- create age colum

SELECT *
FROM hr;


ALTER TABLE hr
ADD column age INT; 

UPDATE hr
SET age = timestampdiff(YEAR,birthdate,curdate());

SELECT min(age), max(age), COUNT(age) AS age_count
FROM hr
GROUP BY age
ORDER BY age;

-- 1. What is the gender breakdown of employees in the company,
CREATE VIEW v_gender_distribution AS
Select gender, COUNT(*) AS count
FROM hr
GROUP BY gender; 

-- 2. What is the gender breakdown of employees by age/gender
CREATE VIEW v_age_gender_distribution AS
SELECT age, gender, COUNT(DISTINCT emp_id) AS age_gender_count
FROM hr
WHERE termdate IS NULL
GROUP BY age, gender
ORDER BY age, gender;

-- 3. What is the race breakdown of employees in the company
CREATE VIEW v_race_distribution AS
SELECT race, COUNT(*) AS race_count
FROM hr
WHERE termdate IS NULL
GROUP BY race;

-- 4. What is the age distribution of employees in the company
CREATE VIEW v_age_group_distribution AS
SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
		WHEN age >= 35 AND age <= 44 THEN '34-44'
		WHEN age >= 45 AND age <= 54 THEN '45-54'
		WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
END AS age_group,
COUNT(*) AS count
FROM hr
WHERE termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

-- 5. How many employees work at HQ vs remote
CREATE VIEW v_work_location_distribution AS
SELECT location, COUNT(location) AS Work_Location
From hr
Where termdate is NULL
GROUP BY location;

-- 6. What is the average length of employment who have been terminated.
CREATE VIEW v_avg_tenure_terminated AS
SELECT ROUND(AVG(year(termdate) - year(hire_date)),0) AS length_of_emp
FROM hr
WHERE termdate is NOT NULL AND termdate <= curdate()
;

-- 7. How does the gender distribution vary across dept. and job titles
CREATE VIEW v_gender_by_dept_jobtitle AS
SELECT department, jobtitle, gender, COUNT(*) AS gen_dept_count
FROM hr
WHERE termdate is NULL
GROUP BY department, jobtitle, gender
ORDER BY department, jobtitle, gender;

-- gender distribution across dept only 
CREATE VIEW v_gender_by_department AS
SELECT department, gender, COUNT(*) AS gen_dept_count
FROM hr
WHERE termdate is NULL
GROUP BY department, gender
ORDER BY department, gender;

-- 8. What is the distribution of jobtitles AND department across the company
CREATE VIEW v_job_title_distribution AS
SELECT jobtitle, COUNT(*) as jt_count
FROM hr
WHERE termdate IS NULL
GROUP BY jobtitle
ORDER BY jt_count DESC;

CREATE VIEW v_department_distribution AS
SELECT department, COUNT(*) as dept_count
FROM hr
WHERE termdate IS NULL
GROUP BY department
ORDER BY dept_count DESC;

-- 9. Which dept has the higher turnover/termination rate

CREATE VIEW v_termination_rate_by_dept AS
SELECT department,
		COUNT(*) AS total_count,
        COUNT(CASE
					WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
                    END) AS terminated_count,
		ROUND((COUNT(CASE
					WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 
                    END)/COUNT(*))*100,2) AS termination_rate
FROM hr
GROUP BY department
ORDER BY termination_rate DESC;

-- 10. WHhat is the distribution of employees across location_state AND location_city
CREATE VIEW v_employee_state_distribution AS
SELECT location_state, COUNT(*) AS State_Count
FROM hr
WHERE termdate IS NULL
GROUP BY location_state;

CREATE VIEW v_employee_city_distribution AS
SELECT location_city, COUNT(*) AS City_Count
FROM hr
WHERE termdate IS NULL
GROUP BY location_city;

-- 11. How has the company's employee count changed over time based on hire and termination date
CREATE VIEW v_headcount_trend AS
SELECT YEAR,
		hires,
        terminations,
        hires-terminations AS net_change,
        (terminations/hires) * 100 AS change_percent
	FROM(
			SELECT YEAR(hire_date) AS YEAR,
            COUNT(*) AS hires,
            SUM(CASE
					WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
				END) AS terminations
			FROM hr
            GROUP BY YEAR(hire_date)) AS subquery
GROUP BY YEAR
ORDER BY YEAR DESC;

-- 12. What is the tenure distribution for each department
CREATE VIEW v_avg_tenure_past AS
SELECT department, ROUND(AVG(datediff(termdate,hire_date)/365),0) AS Avg_Tenure
FROM hr
WHERE termdate IS NOT NULL AND termdate <= curdate()
GROUP BY department
;

CREATE VIEW v_avg_tenure_current AS
SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), hire_date)/365), 0) AS Avg_Tenure_Current
FROM hr
WHERE termdate IS NULL
GROUP BY department;

CREATE VIEW v_tenure_range_by_dept AS
SELECT department,
  ROUND(MIN(DATEDIFF(CURDATE(), hire_date)/365), 0) AS Min_Tenure_Years,
  ROUND(MAX(DATEDIFF(CURDATE(), hire_date)/365), 0) AS Max_Tenure_Years
FROM hr
WHERE termdate IS NULL
GROUP BY department;

CREATE VIEW v_tenure_brackets_by_dept AS
SELECT department,
  CASE 
    WHEN tenure_years BETWEEN 5 AND 9 THEN '5–9 years'
    WHEN tenure_years BETWEEN 10 AND 14 THEN '10–14 years'
    WHEN tenure_years BETWEEN 15 AND 19 THEN '15–19 years'
    WHEN tenure_years BETWEEN 20 AND 25 THEN '20–25 years'
    ELSE 'Other'
  END AS Tenure_Bracket,
  COUNT(*) AS Num_Employees
FROM (
  SELECT department, FLOOR(DATEDIFF(CURDATE(), hire_date)/365) AS tenure_years
  FROM hr
  WHERE termdate IS NULL
) AS tenure_data
GROUP BY department, Tenure_Bracket
ORDER BY department, Tenure_Bracket;


-- 13. Hire Cohort Analysis (by Year):
CREATE VIEW v_hire_cohort_by_year AS
SELECT YEAR(hire_date) AS cohort_year, COUNT(*) AS hires
FROM hr
GROUP BY cohort_year
ORDER BY cohort_year;


-- 14. Comparative Analysis: Time to Turnover by Job Title
CREATE VIEW v_time_to_turnover_by_jobtitle AS
SELECT jobtitle, COUNT(*) AS terminated_employees,
ROUND(AVG(DATEDIFF(termdate, hire_date)), 0) AS avg_days_to_termination,
ROUND(AVG(DATEDIFF(termdate, hire_date)/365), 1) AS avg_years_to_termination
FROM hr
WHERE termdate IS NOT NULL AND termdate <= CURDATE()
GROUP BY jobtitle
ORDER BY avg_days_to_termination ASC;

Select *
From v_time_to_turnover_by_jobtitle;

-- 15. 
CREATE VIEW v_high_risk_departments AS
SELECT
  department,
  ROUND(AVG(DATEDIFF(termdate, hire_date)/365), 1) AS avg_years_to_termination,
  CASE 
    WHEN ROUND(AVG(DATEDIFF(termdate, hire_date)/365), 1) < 2 THEN 'High Risk'
    ELSE 'Low/Moderate Risk'
  END AS risk_level
FROM hr
WHERE termdate IS NOT NULL AND termdate <= CURDATE()
GROUP BY department;

Select *
From v_high_risk_departments;

-- 16. Attrition by Gender per Year with Attrition by Race per Year
CREATE VIEW v_attrition_by_gender_year AS
SELECT
  gender,
  YEAR(hire_date) AS hire_year,
  COUNT(*) AS total_hired,
  COUNT(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 END) AS total_terminated,
  ROUND(
    COUNT(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 END) 
    / COUNT(*) * 100, 2
  ) AS termination_rate
FROM hr
GROUP BY gender, YEAR(hire_date)
ORDER BY hire_year, gender;

SELECT *
FROM v_attrition_by_gender_year;


CREATE VIEW v_attrition_by_race_year AS
SELECT
  race,
  YEAR(hire_date) AS hire_year,
  COUNT(*) AS total_hired,
  COUNT(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 END) AS total_terminated,
  ROUND(
    COUNT(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 END) 
    / COUNT(*) * 100, 2
  ) AS termination_rate
FROM hr
GROUP BY race, YEAR(hire_date)
ORDER BY hire_year, race;

SELECT *
FROM v_attrition_by_race_year;

-- 17. Job Title Count showing diversity by department 
CREATE VIEW v_job_title_diversity_by_dept AS
SELECT
  department,
  COUNT(DISTINCT jobtitle) AS unique_job_titles,
  COUNT(*) AS total_employees,
  ROUND(COUNT(*) / COUNT(DISTINCT jobtitle), 2) AS avg_employees_per_title
FROM hr
WHERE termdate IS NULL
GROUP BY department
ORDER BY unique_job_titles DESC;

Select *
From v_job_title_diversity_by_dept;






















