/*
 Q: What are the most optimal skills to learn (high-paying AND in-demand)
 - Identify skills in high demand with high average salaries for Business/Data Analyst Roles
 - Concentrate on remote jobs with specified salaries
 - Why? Target jobs that offer job security(high demand) and financial benefits(high pay) offering 
 strategic insights into the job market for Business/Data Analysts
 */
WITH in_demand_skills AS (
    SELECT
        skills_dim.skills,
        skills_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
        JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short in ('Business Analyst', 'Data Analyst')
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
),
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
        JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short in ('Business Analyst', 'Data Analyst')
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_job_dim.skill_id
)
SELECT
    in_demand_skills.skill_id,
    in_demand_skills.skills,
    demand_count,
    avg_salary
FROM
    in_demand_skills
    JOIN average_salary ON in_demand_skills.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT
    25;

/*
 Results for Top 25 Optimal Job Skills for Business/Data Analysts(Remote - 2023)
 [
 {
 "skill_id": 0,
 "skills": "sql",
 "demand_count": "440",
 "avg_salary": "97417"
 },
 {
 "skill_id": 181,
 "skills": "excel",
 "demand_count": "287",
 "avg_salary": "88027"
 },
 {
 "skill_id": 182,
 "skills": "tableau",
 "demand_count": "257",
 "avg_salary": "99807"
 },
 {
 "skill_id": 1,
 "skills": "python",
 "demand_count": "256",
 "avg_salary": "102578"
 },
 {
 "skill_id": 5,
 "skills": "r",
 "demand_count": "156",
 "avg_salary": "101223"
 },
 {
 "skill_id": 183,
 "skills": "power bi",
 "demand_count": "122",
 "avg_salary": "96744"
 },
 {
 "skill_id": 186,
 "skills": "sas",
 "demand_count": "70",
 "avg_salary": "98908"
 },
 {
 "skill_id": 7,
 "skills": "sas",
 "demand_count": "70",
 "avg_salary": "98908"
 },
 {
 "skill_id": 196,
 "skills": "powerpoint",
 "demand_count": "63",
 "avg_salary": "89661"
 },
 {
 "skill_id": 185,
 "skills": "looker",
 "demand_count": "54",
 "avg_salary": "106259"
 },
 {
 "skill_id": 188,
 "skills": "word",
 "demand_count": "52",
 "avg_salary": "84012"
 },
 {
 "skill_id": 79,
 "skills": "oracle",
 "demand_count": "43",
 "avg_salary": "103877"
 },
 {
 "skill_id": 80,
 "skills": "snowflake",
 "demand_count": "38",
 "avg_salary": "112989"
 },
 {
 "skill_id": 61,
 "skills": "sql server",
 "demand_count": "37",
 "avg_salary": "97405"
 },
 {
 "skill_id": 192,
 "skills": "sheets",
 "demand_count": "37",
 "avg_salary": "85873"
 },
 {
 "skill_id": 74,
 "skills": "azure",
 "demand_count": "35",
 "avg_salary": "110804"
 },
 {
 "skill_id": 215,
 "skills": "flow",
 "demand_count": "35",
 "avg_salary": "93568"
 },
 {
 "skill_id": 76,
 "skills": "aws",
 "demand_count": "32",
 "avg_salary": "108317"
 },
 {
 "skill_id": 8,
 "skills": "go",
 "demand_count": "30",
 "avg_salary": "111121"
 },
 {
 "skill_id": 9,
 "skills": "javascript",
 "demand_count": "27",
 "avg_salary": "90881"
 },
 {
 "skill_id": 199,
 "skills": "spss",
 "demand_count": "26",
 "avg_salary": "90235"
 },
 {
 "skill_id": 97,
 "skills": "hadoop",
 "demand_count": "25",
 "avg_salary": "111849"
 },
 {
 "skill_id": 22,
 "skills": "vba",
 "demand_count": "24",
 "avg_salary": "88783"
 },
 {
 "skill_id": 233,
 "skills": "jira",
 "demand_count": "22",
 "avg_salary": "103403"
 },
 {
 "skill_id": 4,
 "skills": "java",
 "demand_count": "21",
 "avg_salary": "102258"
 }
 ]
 */