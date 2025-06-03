# Introduction

📈 Let's check out the data job market! Focusing on Business and Data Analyst roles, this project takes a deeper dive into job postings from 2023. We'll explore 💰 high-salary jobs, 🔥 in-demand skills, and 🌎 how to optimize the job search in this ever-changing world.

🔎 SQL Queries? Check them out here: [project_sql_folder](/project_sql/)

# Backgound

As I have a background in e-commerce, I wanted to explore more oppurtunities in the data world that would apply to my skill set. On my quest to better understand SQL, I came acrosss 📚[Luke Barousse's SQL Course](https://youtu.be/7mz73uXD9DA?si=HshQubg7HKKhw2fi) on Youtube where I aquired the dataset for this project.

The data consists of international information on job postings in the data world including:

- Job Location
- Job Titles
- Salaries
- Essential Skills
- and many more 😄

### Our goal was to use SQL queries to answer the following questions

1. What are the top-paying Data Analyst roles from 2023?
2. What skills are required for the top paying Business/Data Analyst roles?
3. What are the most in-demand skills for Business/Data Analyst roles?
4. What are the top skills based on salary?
5. What are the most optimal skills to learn (high-paying AND in-demand)?

# Tools I Used

- **SQL:** The backbone of my analysis, allowing me to query and glean insight from the data
- **PostgreSQL:** The chosen database management source, it's a common and powerful relational database system
- **Excel/Google Sheets:** My main source for visualizations and advanced querying
- **Visual Studio Code:** My essential IDE for most of my coding projects
- **Git & Github:** A perfect place to share my code with others as well as maintain version control

# The Analysis

Each query in the project investigated a different issue or aspect of the job market. Here's how I approached each question:

### Top Highest Paying Jobs for Data Analysts (Locally/Remote)

First, I filtered jobs by yearly salary, focusing on remote and local (Georgia in this case) locations.This query highlights the top-paying oppurtunities for Data Analysts, which offers insight into what skills are trending in the industry.

```sql
SELECT
  job_id,
  job_title,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS company_name
FROM
  job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
  job_title_short in ('Data Analyst', 'Business Analyst')
  AND salary_year_avg IS NOT NULL
  AND job_location in ('Anywhere', 'Atlanta, GA', 'Georgia')
ORDER BY
  salary_year_avg DESC
LIMIT
  10;
```

Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** The top 10 salaries of data/business analyst roles in 2023 ranged from $200,000 to $650,000. This offers not only a wide range but a high base salary potential to job seekers.
- **Diverse Employers:** There are a variety of different companies to choose from including some well-known names like Uber, Pinterest, and AT&T.
- **Job Title Variety:** There's also a high-variety in job titles as Marketing Analyst, Senior Data Analyst and Director of Analytics are part of the list.

![Top Paying Roles](assets/Job_Title_Avg_Year_Salary.png)

_This is a bar graph visualizing the results for the top 10 salaries for data analysts. I generated this graph using Google Sheets._

### Top Skills of High Paying Jobs for Data Analysts 

Using the results from my first query as a CTE, I determined which skills these top paying jobs required. I used an inner join to ensure that I only captured jobs that had associated skills and vice versa. 
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date::Date,
        name AS company_name
    FROM
        job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short in ('Data Analyst', 'Business Analyst')
        AND salary_year_avg IS NOT NULL
        AND job_location in ('Anywhere', 'Atlanta, GA', 'Georgia')
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg
;
```
The Breakdown:
- **Variety of Skill Range:** There were 39 different skills between the variety of jobs so data analysts aren't limited in technological oppurtinuties skill-wise
- **High Frequency of Specific Skills:** According to the graph below, **Python**, **SQL**, and **Tableau** are equally the most common skills amongst high-paying jobs with **Excel** as a close second.

![Top Skills for High Paying Data Analyst Jobs](assets/count_by_skill.png)

_This is a bar graph of the different skills associated with high-paying jobs as well as their frequency._

### Most In-Demand Skills for Data Analysts
While it's important to know the skills required to find a high-paying job, these roles tend to go to more senior job-seekers. 

By exploring the overall demand for certain skills, I'll get a more comprehensive view of skill requirements for data analysts. 

This can be done by joining the skills to their appropriate job postings and then finding the top 5 skills by count.

```sql
SELECT
  skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM
  job_postings_fact
  JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_title_short IN ('Business Analyst', 'Data Analyst')
  AND job_location IN ('Anywhere', 'Atlanta, GA', 'Georgia')
GROUP BY
  skills
ORDER BY
  demand_count DESC
LIMIT
  5;
```
Here's the breakdown of the top 5 skills for data analysts in 2023:

- **Importance of SQL:** SQL came up in over 10,000 job postings in 2023. We can safely say that learning the #1 skill through projects like these will help job-seekers
- **Top skills are robust to salary:** When comparing the top skills of high paying jobs against the rest of the sample, we can see many of the same values including: **Excel, Python, and Tableau**

### In-Demand Skills
|Skills   |Demand Count  |
|------:  |:------------:|
|sql      |10325         |
|excel    |6886          |
|python   |5787          |
|tableau  |5484          |
|power bi |3808          |

_A table of the top 5 most in-demand skills for data analysts in 2023._

# What I Learned

# Conclusions
