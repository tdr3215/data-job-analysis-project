/*
Q: What are the top skills based on salary?
- Look at average salary associated with each skill for Business/Data Analyst positions
- Focus on roles with specific salaries, regardless of location
- Why? Shows how different skills impact salary and helps identify the most financially 
rewarding skills to hone
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
    JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short in ('Business Analyst', 'Data Analyst') 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT
    25;
/*
Results for Top Paying Skills for Remote Business/Data Analyst Jobs
[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "chef",
    "avg_salary": "152500"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salary": "139006"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "127500"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills": "scala",
    "avg_salary": "124903"
  },
  {
    "skills": "crystal",
    "avg_salary": "120100"
  },
  {
    "skills": "linux",
    "avg_salary": "119338"
  },
  {
    "skills": "gcp",
    "avg_salary": "119167"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "116667"
  },
  {
    "skills": "db2",
    "avg_salary": "114158"
  }
]
*/