create database milestone_project;
use milestone_project;
select * from milestone_project_dataset;
ALTER TABLE milestone_project_dataset
RENAME TO salary_survey;
select * from salary_survey;

/*1. Average Salary by Industry and Gender 
Compare the average salary within each industry, split by gender. This helps 
identify potential salary discrepancies based on gender within industries. */

select industry,Gender,round(avg(Salary_$_USD),2) AS Average_Salary from salary_survey
group by Industry,gender 
order by Industry,gender ;

/*2. Total Salary Compensation by Job Title 
Find the total monetary compensation (base salary + additional monetary 
compensation) for each job title. This can show which roles have the highest 
overall compensation. */

select Job_Title,round(sum(Salary_$_USD),2) as total_salary from salary_survey
group by Job_Title
order by Total_Salary desc;

/*3. Salary Distribution by Education Level 
Find the salary distribution (average salary, minimum, and maximum) for 
different education levels. This helps analyze the correlation between education 
and salary.*/

select 
Highest_Level_of_Education_Completed as Education_level,
round(avg(Salary_$_USD),2) as average_salary,
round(min(Salary_$_USD),2) as minimum_salary,
round(max(Salary_$_USD),2) as maximum_salary from salary_survey
group by Education_level;

/* 4. Number of Employees by Industry and Years of Experience 
Determine how many employees are in each industry, broken down by years of 
professional experience. This can show if certain industries employ more 
experienced professionals. */

select industry ,Years_of_Professional_Experience_in_Field as Experience, count(names) as no_of_employees from salary_survey
group by industry,experience
order by experience desc;

/* 5. Median Salary by Age Range and Gender 
Calculate the median salary within different age ranges and genders. This can 
provide insights into salary trends across different age groups and gender. */

select Gender,Age_Range,round(avg(Salary_$_USD),2) as median from salary_survey
group by Gender,Age_Range;

/*6. Job Titles with the Highest Salary in Each Country 
Find the highest-paying job titles in each country. This can help understand salary 
trends across different countries and highlight high-paying positions. */

select country, job_title, Salary_$_USD from (select country,job_title,Salary_$_USD,
row_number() over (partition by  country order by  Salary_$_USD desc) as rn from salary_survey) as ranked where rn=1
order by  Salary_$_USD desc;

/* 7. Average Salary by City and Industry 
Calculate the average salary for each combination of city and industry. This shows 
which cities offer higher salaries within each industry. */

select city,industry, round(avg(Salary_$_USD),2) as Average_salary from salary_survey 
group by city,industry;

/*8. Percentage of Employees with Additional Monetary Compensation by Gender 
Find the percentage of employees within each gender who receive additional 
monetary compensation, such as bonuses or stock options. */

select gender,round(count(Additional_Monetary_Compensation) *100/ (select count(*) from salary_survey),2) as percentage from salary_survey
group by gender
order by percentage;


/*9. Total Compensation by Job Title and Years of Experience 
o Determine the total compensation (salary + additional compensation) for each job 
title based on years of professional experience. This can help highlight 
compensation trends based on experience levels within specific job titles. */

select Job_Title, Years_of_Professional_Experience_in_Field as Experience, round(sum(Salary_$_USD),2) as total_salary from salary_survey
group by Job_Title,experience;

/*10. Average Salary by Industry, Gender, and Education Level 
o Understand how salary varies by industry, gender, and education level. This query 
can provide a comprehensive view of how multiple factors influence salary.*/

select industry, gender, Highest_Level_of_Education_Completed as Education_level, round(avg(Salary_$_USD),2) as Average_Salary from salary_survey
group by Industry,gender,education_level;




