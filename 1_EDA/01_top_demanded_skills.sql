/*
Question: What are the most in-demand skills for data engineers?
- Identify the top 10 in-demand skills for data engineers
- Focus on job listings in Scandinavia
- Why? Retrieves the top 10 skills with the highest demand in the Scandinavian job market, providing insights into the most valuable skills for data engineers seeking work there.
*/

SELECT
    sd.skills,
    COUNT(jpf.*) AS total_demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN    
    skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country IN ('Denmark', 'Sweden', 'Norway', 'Finland')
GROUP BY
    sd.skills
ORDER BY
    COUNT(jpf.*) DESC
LIMIT 10;

/*
┌────────────┬────────────────────┐
│   skills   │ total_demand_count │
│  varchar   │       int64        │
├────────────┼────────────────────┤
│ python     │               4138 │
│ sql        │               4053 │
│ azure      │               3048 │
│ aws        │               2137 │
│ databricks │               1414 │
│ spark      │               1223 │
│ snowflake  │               1155 │
│ gcp        │               1011 │
│ power bi   │                944 │
│ airflow    │                894 │
├────────────┴────────────────────┤
│ 10 rows               2 columns │
└─────────────────────────────────┘

KEY TAKEAWAYS
- Comparing global remote demand with Scandinavian job postings, SQL and Python
  consistently rank as the two most in-demand skills in both markets
- Cloud infrastructure follows closely in both datasets, though the Scandinavian market shows a stronger
  lean toward Microsoft tools — Azure ranks third regionally versus fourth globally, and Power BI appears in the Scandinavian top ten while absent from the global list entirely. 
- AWS maintains relevance in both markets but carries relatively less weigh in Scandinavia. 
- Java, a globally significant skill, does not appear in the regional top ten, suggesting the Scandinavian data job market skews toward analytics and data
  engineering over general software development. 
- For roles targeting the Nordic market, the Microsoft ecosystem appears particularly relevant alongside the universally
  in-demand Python and SQL foundation.
*/