/*
 Q: What are the top-paying data analyst jobs from 2023?
 - Find the top 10 Data Analyst/Business Analyst roles that are available remotely and locally (Georgia)
 - Only look at jobs with specific salaries (remove Null values)
 - Why? To highlight the top-paying oppurtunities for Data Analysts, which offers insight
 into what skills are trending in the industry
 */
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