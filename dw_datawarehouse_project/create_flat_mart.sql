-- .read create_flat_mart.sql
drop schema if exists flat_mart cascade;

create schema flat_mart;

select '=== loading flat mart ===' as info;
create or replace table flat_mart.job_postings as
SELECT 
    jpf.job_id,
    jpf.company_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name,
    ARRAY_AGG(
        STRUCT_PACK(
            type := sd.type,
            name := sd.skills
        )
    ) AS skills_and_type
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LEFT JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd  -- Added this missing JOIN
    ON sjd.skill_id = sd.skill_id
GROUP BY ALL;

select 'flat mart job postings' as table_name, count(*) from flat_mart.job_postings;

select '=== Flat Mart Sample' as info;
select * from flat_mart.job_postings limit 10;