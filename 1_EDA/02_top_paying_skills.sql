/*
Question: What are the highest-paying skills for data engineers in Scandinavia?
- Calculate the median salary for each skill required in data engineer positions
- Focus on Scandinavian positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
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
HAVING
    COUNT(sd.skills) >= 100
ORDER BY
    ROUND(MEDIAN(jpf.salary_year_avg), 0) DESC
LIMIT 25;


/*
┌────────────┬───────────────┬────────────────────┐
│   skills   │ median_salary │ total_demand_count │
│  varchar   │    double     │       int64        │
├────────────┼───────────────┼────────────────────┤
│ bash       │      249000.0 │                134 │
│ hadoop     │      150500.0 │                443 │
│ mongodb    │      147500.0 │                296 │
│ airflow    │      140871.0 │                894 │
│ spark      │      139540.0 │               1223 │
│ scala      │      135000.0 │                613 │
│ java       │      135000.0 │                884 │
│ bigquery   │      133500.0 │                508 │
│ jenkins    │      131580.0 │                138 │
│ oracle     │      131580.0 │                188 │
│ tableau    │      128371.0 │                443 │
│ sap        │      128290.0 │                178 │
│ git        │      125000.0 │                685 │
│ c#         │      122892.0 │                284 │
│ postgresql │      122500.0 │                270 │
│ looker     │      122500.0 │                187 │
│ mysql      │      122500.0 │                134 │
│ gdpr       │      122500.0 │                190 │
│ gcp        │      111300.0 │               1011 │
│ go         │      109637.0 │                466 │
│ redshift   │      109637.0 │                390 │
│ aws        │      107538.0 │               2137 │
│ sql        │       98302.0 │               4053 │
│ azure      │       98292.0 │               3048 │
│ python     │       97528.0 │               4138 │
├────────────┴───────────────┴────────────────────┤
│ 25 rows                               3 columns │
└─────────────────────────────────────────────────┘

KEY TAKEAWAYS
Scandinavian Data Engineer Salary by Skill (min. 100 postings)

- Bash tops the salary ranking at $249K median, but with only 134 postings it
  likely reflects a small set of highly specialised or senior roles rather than
  broad market demand

- Hadoop, MongoDB, Airflow, and Spark form a high-salary cluster ($139–150K)
  with meaningful demand (400–1200 postings), making them the strongest
  candidates for a salary premium at scale

- Java and Scala both sit at $135K with 600–900 postings, confirming the
  earlier finding that JVM-based skills carry real weight in the Nordic market

- The $120–133K band includes a diverse mix — BigQuery, Git, Tableau, SAP,
  PostgreSQL, GDPR — suggesting that specialisation in any direction tends to
  outpay generalist tools

- GDPR appearing with a $122.5K median is notable and regionally specific —
  compliance knowledge commands a salary premium in Scandinavia that would
  likely not appear in a global dataset

- AWS, SQL, Azure, and Python anchor the bottom of this list at $97–107K
  despite being the highest-demand skills, reinforcing that ubiquity suppresses
  salary regardless of volume
*/