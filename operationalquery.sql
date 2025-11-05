-- 1. List all patients and the diseases they have
SELECT p.first_name, p.last_name, d.disease_name, dp.severity_value
FROM diseased_patient dp
JOIN person p ON dp.person_id = p.person_id
JOIN disease d ON dp.disease_id = d.disease_id;

-- 2. Find the most common diseases by race
SELECT r.race_description, d.disease_name, COUNT(*) AS case_count
FROM diseased_patient dp
JOIN person p ON dp.person_id = p.person_id
JOIN disease d ON dp.disease_id = d.disease_id
JOIN race r ON p.race_cd = r.race_code
GROUP BY r.race_description, d.disease_name
ORDER BY case_count DESC;

-- 3. Get medicine effectiveness for each disease
SELECT d.disease_name, m.name AS medicine_name, i.effectiveness_percent
FROM indication i
JOIN disease d ON i.disease_id = d.disease_id
JOIN medicine m ON i.medicine_id = m.medicine_id;

-- 4. Find patients who tested positive for any disease
SELECT p.first_name, p.last_name, d.disease_name, t.test_date
FROM test t
JOIN person p ON t.person_id = p.person_id
JOIN disease d ON t.disease_id = d.disease_id
WHERE t.result = 'Positive';

-- 5. Count of active disease cases by location
SELECT l.city_name, l.country_name, COUNT(*) AS active_cases
FROM diseased_patient dp
JOIN person p ON dp.person_id = p.person_id
JOIN location l ON p.primary_location_id = l.location_id
WHERE dp.end_date IS NULL
GROUP BY l.city_name, l.country_name
ORDER BY active_cases DESC;
