
-- ETL Script: Populate Dimension Tables

-- 1. dim_patient
INSERT INTO disease_dwh.dim_patient (person_id, full_name, gender, birth_year, race_code, location_id)
SELECT 
    person_id,
    CONCAT(first_name, ' ', last_name),
    gender,
    EXTRACT(YEAR FROM CURRENT_DATE) - 30,  -- Assume everyone is 30 years old for mock data
    race_cd,
    primary_location_id
FROM person;



UPDATE disease_dwh.dim_patient
SET effective_end_date = CURRENT_DATE - INTERVAL '1 day',
    is_current = FALSE
WHERE person_id = 3
  AND is_current IS DISTINCT FROM FALSE;

INSERT INTO disease_dwh.dim_patient (
    person_id, full_name, gender, birth_year, race_code, location_id,
    insurance_id, effective_start_date, effective_end_date, is_current
)
VALUES (
    3, 'Raj Bhandari', 'M', 1995, 'ASN', 5, 5,
    CURRENT_DATE, NULL, TRUE
);

Select * from disease_dwh.dim_patient;

-- 2. dim_disease
INSERT INTO disease_dwh.dim_disease (disease_id, disease_name, intensity_level, disease_type)
SELECT 
    d.disease_id,
    d.disease_name,
    d.intensity_level_qty,
    dt.disease_type_description
FROM disease d
JOIN disease_type dt ON d.disease_type_cd = dt.disease_type_code;

-- 3. dim_medicine
INSERT INTO disease_dwh.dim_medicine (medicine_id, name, company, active_ingredient_name)
SELECT medicine_id, name, company, active_ingredient_name
FROM medicine;

-- 4. dim_location
INSERT INTO disease_dwh.dim_location (location_id, city_name, state_province_name, country_name, wealth_rank_number, developing_flag)
SELECT location_id, city_name, state_province_name, country_name, wealth_rank_number, developing_flag
FROM location;

-- 5. dim_race
INSERT INTO disease_dwh.dim_race (race_code, race_description)
SELECT race_code, race_description
FROM race;

-- 6. dim_insurance
INSERT INTO disease_dwh.dim_insurance (insurance_id, provider_name, plan_name, coverage_percent)
SELECT insurance_id, provider_name, plan_name, coverage_percent
FROM insurance;

-- 7. dim_provider
INSERT INTO disease_dwh.dim_provider (provider_id, name, specialization, location_id)
SELECT provider_id, name, specialization, location_id
FROM healthcare_provider;

-- Generate full date range in dim_date (2020-01-01 to 2025-12-31)
-- Extend dim_date to start from 2015
INSERT INTO disease_dwh.dim_date (date_id, day, month, year, quarter, week, is_weekend)
SELECT
    d::DATE,
    EXTRACT(DAY FROM d),
    EXTRACT(MONTH FROM d),
    EXTRACT(YEAR FROM d),
    EXTRACT(QUARTER FROM d),
    EXTRACT(WEEK FROM d),
    CASE WHEN EXTRACT(DOW FROM d) IN (0, 6) THEN TRUE ELSE FALSE END
FROM generate_series('2015-01-01'::DATE, '2019-12-31'::DATE, '1 day'::INTERVAL) d;


SELECT COUNT(*) FROM disease_dwh.dim_date;

-- 8. fact_disease_event
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

