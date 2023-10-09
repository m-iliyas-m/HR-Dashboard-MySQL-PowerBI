-- QUESTIONS
use projects;
SELECT * FROM hr;
-- 1. What is the gender breakdown of employees in the company?
SELECT GENDER ,COUNT(*) AS COUNT 
FROM hr 
WHERE AGE >=18 AND termdate = ''
group by GENDER;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT RACE ,COUNT(*) AS COUNT 
FROM hr 
WHERE AGE >=18 AND TERMDATE = ''
group by RACE
order by count(*)desc;

-- 3. What is the age distribution of employees in the company?
select min(age) as youngest,max(age) as oldest
from hr
WHERE AGE >=18 AND TERMDATE = '';

select 
case 
	when age >= 18 and age <= 24 then '18-24'
    when age >= 25 and age <= 34 then '25-34'
	when age >= 35 and age <= 44 then '35-44'
    when age >= 45 and age <= 54 then '45-54'
    when age >= 55 and age <= 64 then '55-64'
    else '65+'
end as age_group,
count(*) as count 
from hr
WHERE AGE >=18 AND TERMDATE = ''
group by age_group
order by age_group;
-- 4. How many employees work at headquarters versus remote locations?
select location, count(*) as count
from hr
WHERE AGE >=18 AND TERMDATE = ''
group by location;
-- 5. What is the average length of employment for employees who have been terminated?
select 
	avg(datediff(termdate,hire_date))/365 as avg_length_employment
from hr
WHERE AGE >=18 AND TERMDATE = '' and termdate <= curdate();

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department,gender,count(*) as count
from hr
WHERE AGE >=18 AND TERMDATE = '' 
group by department , gender
order by department;
-- 7. What is the distribution of job titles across the company?
select jobtitle,count(*) as count
from hr
WHERE AGE >=18 AND TERMDATE = ''
group by jobtitle
order by jobtitle desc;


-- 8. Which department has the highest turnover rate?
select department,total_count,terminated_count,terminated_count/total_count as terminate_rate
from (select department,count(*) as total_count,
		sum(case when  TERMDATE = '' and  TERMDATE = curdate() then 1 else 0 end) as terminated_count
        from hr
        where age >= 18
        group by department
        )as subquery 
order by terminate_rate desc;
-- 9. What is the distribution of employees across locations by city and state?
select location_state,count(*) as count 
from hr
where AGE >=18 AND TERMDATE = '' 
group by location_state
order by count desc;

-- 10. How has the company's employee count changed over time based on hire and term dates?

-- 11. What is the tenure distribution for each department?
select department , datediff(termdate,hire_date)/365 as avg_tenure
from hr
where AGE >=18 AND TERMDATE = '' and termdate = curdate()
group by department;
