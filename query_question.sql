-- 1 What is the gender breakdown of all the employees in the country?

-- describe human_resources;
-- select gender FROM human_resources;

SET sql_mode = 'ALLOW_INVALID_DATES';

SELECT gender, count(*) AS Count 
FROM human_resources
WHERE age > 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- 2 What is the race/ethnicity breakdown of employees in the company?
describe human_resources;
SELECT race FROM human_resources;

SELECT race, count(*) AS Count 
FROM  human_resources
WHERE age > 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;

-- 3 What is the age distribution of employees in the company?

SELECT 
	min(age) AS Youngest,
    max(age) AS Oldest 
FROM human_resources
WHERE age > 18 AND termdate = '0000-00-00';

SELECT
	CASE 
		WHEN age>= 18 AND age <= 24 THEN '18-24'
        WHEN age>= 25 AND age <= 34 THEN '25-34'
        WHEN age>= 35 AND age <= 44 THEN '35-44'
        WHEN age>= 45 AND age <= 54 THEN '45-54'
        WHEN age>= 55 AND age <= 65 THEN '55-65'
        ELSE '65+'
	END AS age_group,gender,
    count(*) AS Count
From human_resources
WHERE age > 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender 
ORDER BY age_group, gender;

-- 4 How many employees work at thehead headquarters versus remote locations?

 SELECT location, count(*) AS count 
 FROM human_resources
 WHERE age >= 18 AND termdate = '0000-00-00'
 GROUP BY location;
 
 -- 5 What is the average length of employment for employees who have been terminated?
 
SELECT 
	round(avg(datediff(termdate,hire_date))/365) AS avg_length_employment
FROM human_resources
WHERE termdate <= curdate() AND termdate <> '0000-00-00'AND age>= 18;

-- 6 How does the gender distribution vary across departments?

describe human_resources;

SELECT department,gender,count(*) AS Count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department,gender
ORDER BY department;

SELECT department,jobtitle
FROM human_resources
GROUP BY department,jobtitle
ORDER BY department;

-- 7 What is the distribution of job titles across the company?

SELECT jobtitle, count(*) AS Count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;


-- 8 Which department has the highest turnover rate?
-- turnover means how long the employee work in a company before they leave or quit or fired

SELECT department, count(*) AS Count
FROM human_resources
WHERE age >= 18 
GROUP BY department;

-- Creating a table for Terminted Count Column
-- FROM This table we can get what we are asked 
SELECT department, 
count(*) AS Total_count,
SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS Terminated_count
FROM human_resources
GROUP BY department;

SELECT department,
	Total_count,
    Terminated_count,
    Total_count/Terminated_count AS Termintation_rate
FROM(
	SELECT department, 
	count(*) AS Total_count,
	SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS Terminated_count
	FROM human_resources
    WHERE age> 18
	GROUP BY department
    )AS subquery
ORDER BY Termintation_rate DESC;

-- 9 What is the distribution of employees across locations by city and state??

SELECT location_state, count(*) AS Count
FROM human_resources
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY Count DESC;
	
-- 10 HOW has the company's employee count changes over time based on hire and term dates??

-- First making the table which will hwlp us in getting the desired result
-- From this table we will get desired result

SELECT 
	YEAR(hire_date) AS Year,
    count(*) AS Hires,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS Terminations
FROM human_resources
WHERE age > 18
GROUP BY YEAR(hire_date);

SELECT 
	Year,
    Hires,
    Terminations,
    Hires - Terminations Net_change,
    round((Hires - Terminations)/Hires * 100,2) AS Net_change_percent
FROM(
	SELECT 
	YEAR(hire_date) AS Year,
    count(*) AS Hires,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS Terminations
	FROM human_resources
	WHERE age > 18
	GROUP BY YEAR(hire_date)
    ) AS subquery
ORDER BY Year ASC;

-- 11 What is the tenure distribution of each department??

SELECT
	department,round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM human_resources
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age > 18
GROUP BY department;









































	

    

-- 11 What is the tenure distribution for each department??




	
