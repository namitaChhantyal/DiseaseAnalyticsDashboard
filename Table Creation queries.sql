-- 1. Disease Type
CREATE TABLE disease_type (
    disease_type_code CHAR(5) PRIMARY KEY,
    disease_type_description VARCHAR(1000) NOT NULL,
    exclusions_other_note_text VARCHAR(2000)
);

-- 2. Disease
CREATE TABLE disease (
    disease_id SERIAL PRIMARY KEY,
    disease_name VARCHAR(100) NOT NULL,
    intensity_level_qty INT DEFAULT 1 CHECK (intensity_level_qty BETWEEN 1 AND 10),
    disease_type_cd CHAR(5) NOT NULL REFERENCES disease_type(disease_type_code),
    source_disease_cd INT REFERENCES disease(disease_id)
);

-- 3. Race
CREATE TABLE race (
    race_code CHAR(5) PRIMARY KEY,
    race_description VARCHAR(100) NOT NULL
);

-- 4. Location
CREATE TABLE location (
    location_id SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    state_province_name VARCHAR(100),
    country_name VARCHAR(100) NOT NULL,
    developing_flag CHAR(1) NOT NULL CHECK (developing_flag IN ('Y', 'N')),
    wealth_rank_number INT CHECK (wealth_rank_number BETWEEN 1 AND 10)
);

-- 5. Insurance
CREATE TABLE insurance (
    insurance_id SERIAL PRIMARY KEY,
    provider_name VARCHAR(150),
    plan_name VARCHAR(150),
    coverage_percent FLOAT CHECK (coverage_percent BETWEEN 0 AND 100)
);

-- 6. Healthcare Provider
CREATE TABLE healthcare_provider (
    provider_id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    specialization VARCHAR(100),
    location_id INT REFERENCES location(location_id)
);

-- 7. Person
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50),
    gender CHAR(1) NOT NULL CHECK (gender IN ('M', 'F', 'U')),
    primary_location_id INT REFERENCES location(location_id),
    race_cd CHAR(5) REFERENCES race(race_code),
    insurance_id INT REFERENCES insurance(insurance_id),
    provider_id INT REFERENCES healthcare_provider(provider_id)
);

-- 8. Diseased Patient
CREATE TABLE diseased_patient (
    person_id INT NOT NULL REFERENCES person(person_id),
    disease_id INT NOT NULL REFERENCES disease(disease_id),
    severity_value INT DEFAULT 1 CHECK (severity_value BETWEEN 1 AND 10),
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (person_id, disease_id)
);

-- 9. Medicine
CREATE TABLE medicine (
    medicine_id SERIAL PRIMARY KEY,
    standard_industry_number VARCHAR(25),
    name VARCHAR(250) NOT NULL,
    company VARCHAR(150),
    active_ingredient_name VARCHAR(150)
);

-- 10. Indication
CREATE TABLE indication (
    medicine_id INT NOT NULL REFERENCES medicine(medicine_id),
    disease_id INT NOT NULL REFERENCES disease(disease_id),
    indication_date DATE,
    effectiveness_percent FLOAT CHECK (effectiveness_percent BETWEEN 0 AND 100),
    PRIMARY KEY (medicine_id, disease_id)
);

-- 11. Race Disease Propensity
CREATE TABLE race_disease_propensity (
    race_code CHAR(5) NOT NULL REFERENCES race(race_code),
    disease_id INT NOT NULL REFERENCES disease(disease_id),
    propensity_value INT CHECK (propensity_value BETWEEN 1 AND 10),
    PRIMARY KEY (race_code, disease_id)
);

-- 12. Test
CREATE TABLE test (
    test_id SERIAL PRIMARY KEY,
    person_id INT REFERENCES person(person_id),
    disease_id INT REFERENCES disease(disease_id),
    test_date DATE NOT NULL,
    result VARCHAR(50),
    result_value FLOAT
);
