SELECT
jpf.job_id,
jpf.job_title,
sd.skills,
jpf.job_country,
jpf.job_health_insurance
FROM
job_postings_fact as jpf
LEFT JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'United States'
    AND jpf.job_health_insurance = TRUE
ORDER BY jpf.job_id DESC;