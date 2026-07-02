/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT 
    sd.skills,
    CAST(MEDIAN(jpf.salary_year_avg) AS INTEGER) as median_salary,
    COUNT(jpf.*) AS skill_frequency
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Engineer'
      AND jpf.job_work_from_home = True 
GROUP BY sd.skills
HAVING COUNT(sd.skills) >= 100
ORDER BY median_salary DESC
LIMIT 20;

/*  
Key Insights:
- Rust remains the top-paying skill at $210K median salary, though demand is still relatively limited (232 postings).
- Golang and Terraform both offer $184K median salaries, with strong demand (Terraform: 3,248 postings; Golang: 912 postings).
- Spring, Neo4j, and GDPR show premium compensation:
  - Spring: $175.5K (364 postings)
  - Neo4j: $170K (277 postings)
  - GDPR: $169.6K (582 postings)
- FastAPI and GraphQL are emerging as valuable skills:
  - GraphQL: $167.5K (445 postings)
  - FastAPI: $157.5K (204 postings)
- Kubernetes and Airflow dominate in demand while maintaining strong salaries:
  - Kubernetes: $150.5K (4,202 postings)
  - Airflow: $150K (9,996 postings)
- Other skills with solid pay and moderate demand include Django, Bitbucket, Typescript, and C.
- Most skills on the list show consistently strong demand, moving beyond extreme statistical outliers with just a handful of postings.

Takeaway: While Rust remains the highest-paying skill, it's still niche compared to mainstream tools. Terraform and Golang offer the best balance of high compensation and strong demand. For job security and marketability, core data engineering tools like Airflow and Kubernetes provide a solid foundation, while specialized skills like Rust, Neo4j, and GDPR can command premium pay for those looking to differentiate themselves in the market.

┌────────────┬───────────────┬─────────────────┐
│   skills   │ median_salary │ skill_frequency │
│  varchar   │     int32     │      int64      │
├────────────┼───────────────┼─────────────────┤
│ rust       │        210000 │             232 │
│ golang     │        184000 │             912 │
│ terraform  │        184000 │            3248 │
│ spring     │        175500 │             364 │
│ neo4j      │        170000 │             277 │
│ gdpr       │        169616 │             582 │
│ zoom       │        168438 │             127 │
│ graphql    │        167500 │             445 │
│ mongo      │        162250 │             265 │
│ fastapi    │        157500 │             204 │
│ django     │        155000 │             265 │
│ bitbucket  │        155000 │             478 │
│ crystal    │        154224 │             129 │
│ c          │        151500 │             444 │
│ atlassian  │        151500 │             249 │
│ typescript │        151000 │             388 │
│ kubernetes │        150500 │            4202 │
│ ruby       │        150000 │             736 │
│ airflow    │        150000 │            9996 │
│ css        │        150000 │             262 │
└────────────┴───────────────┴─────────────────┘

*/