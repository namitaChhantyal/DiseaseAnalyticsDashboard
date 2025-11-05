
-- Create schema for Data Warehouse
CREATE SCHEMA IF NOT EXISTS disease_dwh;
SET search_path TO disease_dwh;

-- 1. dim_patient
CREATE TABLE dim_patient (
    patient_id SERIAL PRIMARY KEY,
    person_id INT,
    full_name VARCHAR(100),
    gender CHAR(1),
    birth_year INT,
    race_code CHAR(5),
    location_id INT
);

-- 2. dim_disease
CREATE TABLE dim_disease (
    disease_id INT PRIMARY KEY,
    disease_name VARCHAR(100),
    intensity_level INT,
    disease_type VARCHAR(100)
);

-- 3. dim_medicine
CREATE TABLE dim_medicine (
    medicine_id INT PRIMARY KEY,
    name VARCHAR(250),
    company VARCHAR(150),
    active_ingredient_name VARCHAR(150)
);

-- 4. dim_location
CREATE TABLE dim_location (
    location_id INT PRIMARY KEY,
    city_name VARCHAR(100),
    state_province_name VARCHAR(100),
    country_name VARCHAR(100),
    wealth_rank_number INT,
    developing_flag CHAR(1)
);

-- 5. dim_race
CREATE TABLE dim_race (
    race_code CHAR(5) PRIMARY KEY,
    race_description VARCHAR(100)
);

-- 6. dim_insurance
CREATE TABLE dim_insurance (
    insurance_id INT PRIMARY KEY,
    provider_name VARCHAR(150),
    plan_name VARCHAR(150),
    coverage_percent FLOAT
);

-- 7. dim_provider
CREATE TABLE dim_provider (
    provider_id INT PRIMARY KEY,
    name VARCHAR(150),
    specialization VARCHAR(100),
    location_id INT
);

-- 8. fact_disease_event
CREATE TABLE fact_disease_event (
    fact_id SERIAL PRIMARY KEY,
    person_id INT,
    disease_id INT,
    medicine_id INT,
    location_id INT,
    race_code CHAR(5),
    insurance_id INT,
    provider_id INT,
    test_result VARCHAR(50),
    test_value FLOAT,
    severity INT,
    start_date DATE,
    end_date DATE
);

DROP TABLE IF EXISTS disease_dwh.dim_patient;

CREATE TABLE disease_dwh.dim_patient (
    patient_sk SERIAL PRIMARY KEY,                -- Surrogate key
    person_id INT,                                -- Business key
    full_name VARCHAR(100),
    gender CHAR(1),
    birth_year INT,
    race_code CHAR(5),
    location_id INT,
    insurance_id INT,
    effective_start_date DATE,                    -- SCD2 tracking
    effective_end_date DATE,
    is_current BOOLEAN
);

SELECT * FROM disease_dwh.dim_patient;

ALTER TABLE disease_dwh.fact_disease_event
ADD CONSTRAINT fk_disease FOREIGN KEY (disease_id)
REFERENCES disease_dwh.dim_disease(disease_id);

ALTER TABLE disease_dwh.fact_disease_event
ADD CONSTRAINT fk_medicine FOREIGN KEY (medicine_id)
REFERENCES disease_dwh.dim_medicine(medicine_id);

ALTER TABLE disease_dwh.fact_disease_event
ADD CONSTRAINT fk_location FOREIGN KEY (location_id)
REFERENCES disease_dwh.dim_location(location_id);

ALTER TABLE disease_dwh.fact_disease_event
ADD CONSTRAINT fk_race FOREIGN KEY (race_code)
REFERENCES disease_dwh.dim_race(race_code);

ALTER TABLE disease_dwh.fact_disease_event
ADD CONSTRAINT fk_insurance FOREIGN KEY (insurance_id)
REFERENCES disease_dwh.dim_insurance(insurance_id);

ALTER TABLE disease_dwh.fact_disease_event
ADD CONSTRAINT fk_provider FOREIGN KEY (provider_id)
REFERENCES disease_dwh.dim_provider(provider_id);

ALTER TABLE disease_dwh.fact_disease_event
ADD CONSTRAINT fk_date FOREIGN KEY (date_id)
REFERENCES disease_dwh.dim_date(date_id);

ALTER TABLE disease_dwh.fact_disease_event
ADD CONSTRAINT fk_patient FOREIGN KEY (patient_sk)
REFERENCES disease_dwh.dim_patient(patient_sk);
