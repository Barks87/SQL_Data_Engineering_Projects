SELECT
    jpf.job_title_short,
    sd.skill_id,
    sd.skills,
    COUNT(jpf.job_id) AS job_count
FROM
    job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id 
FULL JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id 
WHERE 
    job_title_short LIKE '%Data%'
GROUP BY 
    sd.skill_id,
    sd.skills,
    jpf.job_title_short
ORDER BY 
    COUNT(jpf.job_id) DESC;