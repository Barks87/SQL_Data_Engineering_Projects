SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    sjd.skill_id
FROM
    job_postings_fact AS jpf
FULL JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id 
WHERE
    job_country = 'United States'
ORDER BY 
    jpf.job_id,
    sjd.skill_id;