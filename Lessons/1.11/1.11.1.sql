SELECT 
    jpf.job_id,
    jpf.job_title,
    jpf.job_location,
    jpf.job_posted_date,
    cd.name AS company_name
FROM
    job_postings_fact as jpf
INNER JOIN 
    company_dim as cd
ON jpf.company_id = cd.company_id
WHERE job_title_short = 'Data Engineer'
ORDER BY job_posted_date DESC;