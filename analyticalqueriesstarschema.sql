-- Sample Analytical Queries (Star Schema)
--- 1.  Top 5 most common diseases by Case Count
SELECT d.disease_name, COUNT(*) AS case_count
FROM disease_dwh.fact_disease_event f
JOIN disease_dwh.dim_disease d ON f.disease_id = d.disease_id
GROUP BY d.disease_name
ORDER BY case_count DESC
LIMIT 5;

--- 2. Average Severity of Diseases by Year
SELECT dd.year, d.disease_name, ROUND(AVG(f.severity), 2) AS avg_severity
FROM disease_dwh.fact_disease_event f
JOIN disease_dwh.dim_date dd ON f.date_id = dd.date_id
JOIN disease_dwh.dim_disease d ON f.disease_id = d.disease_id
GROUP BY dd.year, d.disease_name
ORDER BY dd.year, avg_severity DESC;

---3. Positive Test Rates by Race
SELECT r.race_description, COUNT(*) FILTER (WHERE f.test_result = 'Positive')::float / COUNT(*) AS positive_rate
FROM disease_dwh.fact_disease_event f
JOIN disease_dwh.dim_race r ON f.race_code = r.race_code
GROUP BY r.race_description
ORDER BY positive_rate DESC;

---4. Disease Count by Insurance plan
SELECT i.plan_name, COUNT(*) AS total_cases
FROM disease_dwh.fact_disease_event f
JOIN disease_dwh.dim_insurance i ON f.insurance_id = i.insurance_id
GROUP BY i.plan_name
ORDER BY total_cases DESC;

---5. Monthly Case Trends
SELECT dd.year, dd.month, COUNT(*) AS monthly_cases
FROM disease_dwh.fact_disease_event f
JOIN disease_dwh.dim_date dd ON f.date_id = dd.date_id
GROUP BY dd.year, dd.month
ORDER BY dd.year, dd.month;



