SELECT  *
FROM    information_schema.tables
WHERE   table_catalog = 'data_jobs';

PRAGMA  show_tables_expanded;

DESCRIBE job_postings_fact;