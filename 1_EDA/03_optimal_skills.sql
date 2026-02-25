/*
Question: What are the most optimal skills for data engineers in Scandinavia —balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    -- COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/1000000, 2) AS optimal_score
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
    COUNT(sjd.job_id) >= 250
ORDER BY
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/1000000, 2) DESC
LIMIT 25;

/*
┌────────────┬───────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ ln_demand_count │ optimal_score │
│  varchar   │    double     │     double      │    double     │
├────────────┼───────────────┼─────────────────┼───────────────┤
│ spark      │      139540.0 │             7.1 │          0.99 │
│ airflow    │      140871.0 │             6.8 │          0.96 │
│ java       │      135000.0 │             6.8 │          0.92 │
│ hadoop     │      150500.0 │             6.1 │          0.92 │
│ scala      │      135000.0 │             6.4 │          0.87 │
│ mongodb    │      147500.0 │             5.7 │          0.84 │
│ bigquery   │      133500.0 │             6.2 │          0.83 │
│ git        │      125000.0 │             6.5 │          0.82 │
│ sql        │       98302.0 │             8.3 │          0.82 │
│ aws        │      107538.0 │             7.7 │          0.82 │
│ python     │       97528.0 │             8.3 │          0.81 │
│ azure      │       98292.0 │             8.0 │          0.79 │
│ tableau    │      128371.0 │             6.1 │          0.78 │
│ gcp        │      111300.0 │             6.9 │          0.77 │
│ databricks │       97528.0 │             7.3 │          0.71 │
│ postgresql │      122500.0 │             5.6 │          0.69 │
│ c#         │      122892.0 │             5.6 │          0.69 │
│ go         │      109637.0 │             6.1 │          0.67 │
│ power bi   │       96773.0 │             6.9 │          0.66 │
│ snowflake  │       92500.0 │             7.1 │          0.65 │
│ redshift   │      109637.0 │             6.0 │          0.65 │
│ kubernetes │       96773.0 │             6.6 │          0.64 │
│ kafka      │       89100.0 │             6.7 │           0.6 │
│ flow       │       96773.0 │             5.8 │          0.56 │
│ terraform  │       86400.0 │             6.5 │          0.56 │
├────────────┴───────────────┴─────────────────┴───────────────┤
│ 25 rows                                            4 columns │
└──────────────────────────────────────────────────────────────┘

Key Takeaways — Optimal Skill Score for Scandinavian Data Engineer Roles
(min. 250 postings, ordered by optimal score combining salary and demand)

- The minimum posting threshold was raised to 250 to exclude small-sample
  outliers — notably Bash, which appeared at #1 in earlier iterations with
  only 134 postings and an unrepresentative $249K median salary

- Spark and Airflow lead the ranking with optimal scores of 0.99 and 0.96,
  combining high median salaries ($139–140K) with substantial demand — the
  strongest signal in the dataset for pipeline and orchestration skills

- Hadoop and MongoDB score equally (0.92 and 0.84) despite lower demand,
  carried by high medians of $150K and $147K respectively — specialist skills
  with a clear salary premium in the Nordic market

- Java and Scala both sit at $135K with scores of 0.92 and 0.87, reinforcing
  that JVM-based engineering remains well-compensated in Scandinavia

- SQL, AWS, and Python cluster tightly at 0.81–0.82 despite very different
  demand and salary profiles — the LN compression surfaces them as equally
  practical investments, with high demand compensating for more modest salaries

- The bottom tier — Kafka, Terraform, Snowflake, and Flow — scores below 0.60,
  reflecting a combination of lower salaries and insufficient demand to offset
  through volume
/*