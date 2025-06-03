/*
 Q: What are the most in-demand skills for Business/Data Analyst roles?
 - Join job postings to inner join table similar to query 2
 - Identify the top 5 in-demand skills for Business/Data Analysts
 - Focus on all job postings
 - Why? Finds the top skills with the highest demand which provides insights into 
 the most valuable skills for job seekers
 */
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

/*
 Results for Most In-Demand Skills for Business/Data Analysts(Local/Remote):
 
 [
 {
 "skills": "sql",
 "demand_count": "10325"
 },
 {
 "skills": "excel",
 "demand_count": "6886"
 },
 {
 "skills": "python",
 "demand_count": "5787"
 },
 {
 "skills": "tableau",
 "demand_count": "5484"
 },
 {
 "skills": "power bi",
 "demand_count": "3808"
 }
 ]
 */