/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT sd.skills,
count(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
where jpf.job_title_short = 'Data Engineer'
      AND jpf.job_Country = 'Pakistan'
group by sd.skills
order by demand_count desc
LIMIT 10;

/*
┌─────────┬──────────────┐
│ skills  │ demand_count │
│ varchar │    int64     │
├─────────┼──────────────┤
│ sql     │         1061 │
│ python  │          924 │
│ aws     │          657 │
│ azure   │          570 │
│ spark   │          451 │
│ airflow │          296 │
│ java    │          290 │
│ kafka   │          276 │
│ hadoop  │          271 │
│ mongodb │          252 │
└─────────┴──────────────┘
*/