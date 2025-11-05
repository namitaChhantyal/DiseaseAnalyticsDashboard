
--updated the dims after the new data are inserted in OLTP tables.
-- Expire old rows where changes have occurred
UPDATE disease_dwh.dim_patient dp
SET effective_end_date = CURRENT_DATE - INTERVAL '1 day',
    is_current = FALSE
FROM person p
WHERE dp.person_id = p.person_id
  AND dp.is_current = TRUE
  AND (
    dp.gender IS DISTINCT FROM p.gender OR
    dp.race_code IS DISTINCT FROM p.race_cd OR
    dp.location_id IS DISTINCT FROM p.primary_location_id OR
    dp.insurance_id IS DISTINCT FROM p.insurance_id
  );

-- Insert new version for changed or new person records
INSERT INTO disease_dwh.dim_patient (
    person_id, full_name, gender, birth_year, race_code,
    location_id, insurance_id, effective_start_date,
    effective_end_date, is_current
)
SELECT 
    p.person_id,
    CONCAT(p.first_name, ' ', p.last_name),
    p.gender,
    EXTRACT(YEAR FROM CURRENT_DATE) - 30,
    p.race_cd,
    p.primary_location_id,
    p.insurance_id,
    CURRENT_DATE, NULL, TRUE
FROM person p
LEFT JOIN disease_dwh.dim_patient dp
    ON p.person_id = dp.person_id AND dp.is_current = TRUE
WHERE dp.person_id IS NULL
   OR dp.gender IS DISTINCT FROM p.gender
   OR dp.race_code IS DISTINCT FROM p.race_cd
   OR dp.location_id IS DISTINCT FROM p.primary_location_id
   OR dp.insurance_id IS DISTINCT FROM p.insurance_id;


-- Optionally clear old fact table if reloading fully
-- TRUNCATE TABLE disease_dwh.fact_disease_event;

INSERT INTO disease_dwh.fact_disease_event (
    person_id, disease_id, medicine_id, location_id, race_code,
    insurance_id, provider_id, test_result, test_value, severity,
    start_date, end_date, date_id
)
SELECT 
    p.person_id,
    dp.disease_id,
    i.medicine_id,
    p.primary_location_id,
    p.race_cd,
    p.insurance_id,
    p.provider_id,
    t.result,
    t.result_value,
    dp.severity_value,
    dp.start_date,
    dp.end_date,
    dp.start_date
FROM diseased_patient dp
JOIN person p ON dp.person_id = p.person_id
LEFT JOIN test t ON t.person_id = dp.person_id AND t.disease_id = dp.disease_id
LEFT JOIN indication i ON i.disease_id = dp.disease_id;

Select * from disease_dwh.dim_patient;
select * from disease_dwh.fact_disease_event;

UPDATE disease_dwh.dim_patient
SET effective_end_date = CURRENT_DATE - INTERVAL '1 day',
    is_current = FALSE
WHERE person_id IN (
    SELECT person_id
    FROM person
    WHERE person_id > 30  -- or filter based on new records
)
AND is_current IS DISTINCT FROM FALSE;

INSERT INTO disease_dwh.dim_patient (
    person_id, full_name, gender, birth_year, race_code, location_id,
    insurance_id, effective_start_date, effective_end_date, is_current
)
SELECT 
    person_id,
    CONCAT(first_name, ' ', last_name),
    gender,
    EXTRACT(YEAR FROM CURRENT_DATE) - 30,
    race_cd,
    primary_location_id,
    insurance_id,
    CURRENT_DATE, NULL, TRUE
FROM person
WHERE person_id > 30;

INSERT INTO disease_dwh.dim_disease (disease_id, disease_name, intensity_level, disease_type)
SELECT 
    d.disease_id,
    d.disease_name,
    d.intensity_level_qty,
    dt.disease_type_description
FROM disease d
JOIN disease_type dt ON d.disease_type_cd = dt.disease_type_code
WHERE d.disease_id NOT IN (SELECT disease_id FROM disease_dwh.dim_disease);

INSERT INTO disease_dwh.dim_medicine (medicine_id, name, company, active_ingredient_name)
SELECT medicine_id, name, company, active_ingredient_name
FROM medicine
WHERE medicine_id NOT IN (SELECT medicine_id FROM disease_dwh.dim_medicine);

-- Example: dim_provider
INSERT INTO disease_dwh.dim_provider (provider_id, name, specialization, location_id)
SELECT provider_id, name, specialization, location_id
FROM healthcare_provider
WHERE provider_id NOT IN (SELECT provider_id FROM disease_dwh.dim_provider);

INSERT INTO disease_dwh.dim_location (
    location_id, city_name, state_province_name, country_name,
    wealth_rank_number, developing_flag
)
SELECT 
    location_id, city_name, state_province_name, country_name,
    wealth_rank_number, developing_flag
FROM location
WHERE location_id NOT IN (
    SELECT location_id FROM disease_dwh.dim_location
);

INSERT INTO disease_dwh.dim_race (
    race_code, race_description
)
SELECT 
    race_code, race_description
FROM race
WHERE race_code NOT IN (
    SELECT race_code FROM disease_dwh.dim_race
);

INSERT INTO disease_dwh.dim_insurance (
    insurance_id, provider_name, plan_name, coverage_percent
)
SELECT 
    insurance_id, provider_name, plan_name, coverage_percent
FROM insurance
WHERE insurance_id NOT IN (
    SELECT insurance_id FROM disease_dwh.dim_insurance
);

DELETE FROM disease_dwh.fact_disease_event;

INSERT INTO disease_dwh.fact_disease_event (
    person_id, disease_id, medicine_id, location_id, race_code,
    insurance_id, provider_id, test_result, test_value, severity,
    start_date, end_date, date_id
)
SELECT 
    p.person_id,
    dp.disease_id,
    i.medicine_id,
    p.primary_location_id,
    p.race_cd,
    p.insurance_id,
    p.provider_id,
    t.result,
    t.result_value,
    dp.severity_value,
    dp.start_date,
    dp.end_date,
    dp.start_date
FROM diseased_patient dp
JOIN person p ON dp.person_id = p.person_id
LEFT JOIN test t ON t.person_id = dp.person_id AND t.disease_id = dp.disease_id
LEFT JOIN indication i ON i.disease_id = dp.disease_id;

Select * from  disease_dwh.fact_disease_event;

ALTER TABLE disease_dwh.fact_disease_event
ADD COLUMN patient_sk INT;

UPDATE disease_dwh.fact_disease_event f
SET patient_sk = d.patient_sk
FROM disease_dwh.dim_patient d
WHERE f.person_id = d.person_id
  AND d.is_current = TRUE;


