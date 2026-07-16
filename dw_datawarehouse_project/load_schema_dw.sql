-- Load company_dim (only columns that exist in CSV)
INSERT INTO company_dim (company_id, name)
SELECT company_id, name
FROM read_csv('https://storage.googleapis.com/sql_de/company_dim.csv', AUTO_DETECT=true);

-- Load skills_dim (use EXACT column name from CSV)
INSERT INTO skills_dim (skill_id, skills, type)  -- or 'skill' if that's the column name
SELECT skill_id, skills, type  -- or 'skill' if that's the column name
FROM read_csv('https://storage.googleapis.com/sql_de/skills_dim.csv', AUTO_DETECT=true)
WHERE skills IS NOT NULL;  -- or 'skill' if that's the column name

-- Load job_postings_fact
INSERT INTO job_postings_fact (
    job_id, company_id, job_title_short, job_title, job_location, 
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance, 
    job_country, salary_rate, salary_year_avg, salary_hour_avg
)
SELECT 
    job_id, company_id, job_title_short, job_title, job_location, 
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance, 
    job_country, salary_rate, salary_year_avg, salary_hour_avg
FROM read_csv('https://storage.googleapis.com/sql_de/job_postings_fact.csv', AUTO_DETECT=true);

-- Load skills_job_dim
INSERT INTO skills_job_dim (skill_id, job_id)
SELECT skill_id, job_id
FROM read_csv('https://storage.googleapis.com/sql_de/skills_job_dim.csv', AUTO_DETECT=true);

SELECT 'Company Dim' AS table_name, COUNT(*) AS record_count FROM company_dim
UNION ALL
SELECT 'Skills Dim', COUNT(*) FROM skills_dim
UNION ALL
SELECT 'Job Postings Fact', COUNT(*) FROM job_postings_fact
UNION ALL
SELECT 'Skills Job Dim', COUNT(*) FROM skills_job_dim;