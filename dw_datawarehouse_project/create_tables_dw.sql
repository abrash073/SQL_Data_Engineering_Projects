-- Drop child tables first (tables that have foreign keys)
DROP TABLE IF EXISTS skills_job_dim;      -- References both skills_dim and job_postings_fact
DROP TABLE IF EXISTS job_postings_fact;   -- References company_dim
DROP TABLE IF EXISTS skills_dim;          -- No foreign key dependencies
DROP TABLE IF EXISTS company_dim;         -- No foreign key dependencies (parent table)

-- Recreate company_dim (parent table)
CREATE TABLE company_dim (
    company_id INTEGER,
    name VARCHAR
    -- Add any other columns you need
);

-- Recreate skills_dim
CREATE TABLE skills_dim (
    skill_id INTEGER,
    skills VARCHAR,
    type VARCHAR
);

-- Recreate job_postings_fact (references company_dim)
CREATE TABLE job_postings_fact (
    job_id INTEGER,
    company_id INTEGER,
    job_title_short VARCHAR,
    job_title VARCHAR,
    job_location VARCHAR,
    job_via VARCHAR,
    job_schedule_type VARCHAR,
    job_work_from_home BOOLEAN,
    search_location VARCHAR,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country VARCHAR,
    salary_rate VARCHAR,
    salary_year_avg DOUBLE,
    salary_hour_avg DOUBLE
);

-- Recreate skills_job_dim (references both skills_dim and job_postings_fact)
CREATE TABLE skills_job_dim (
    skill_id INTEGER,
    job_id INTEGER
);