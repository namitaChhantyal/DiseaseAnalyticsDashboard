
-- 1. Disease Type
INSERT INTO disease_type (disease_type_code, disease_type_description, exclusions_other_note_text) VALUES
('INF', 'Infectious Disease', 'None'),
('CHR', 'Chronic Disease', 'Exclude mental disorders'),
('GEN', 'Genetic Disorder', 'Inherited conditions'),
('NUR', 'Neurological Disorder', 'Exclude trauma-induced'),
('CAN', 'Cancer', 'Malignant only'),
('MNT', 'Mental Health Disorder', 'Psychological conditions'),
('IMM', 'Immune System Disorder', 'Autoimmune types'),
('CAR', 'Cardiovascular Disease', 'Heart-related conditions'),
('RES', 'Respiratory Disease', 'Exclude allergy only'),
('END', 'Endocrine Disorder', 'Hormonal issues');

-- 2. Disease
INSERT INTO disease (disease_name, intensity_level_qty, disease_type_cd, source_disease_cd) VALUES
('COVID-19', 8, 'INF', NULL),
('Diabetes', 5, 'CHR', NULL),
('Tuberculosis', 7, 'INF', NULL),
('Breast Cancer', 9, 'CAN', NULL),
('Depression', 6, 'MNT', NULL),
('Asthma', 5, 'RES', NULL),
('Lupus', 7, 'IMM', NULL),
('Heart Attack', 9, 'CAR', NULL),
('Parkinson''s', 6, 'NUR', NULL),
('Thyroid Disorder', 4, 'END', NULL);

-- 3. Race
INSERT INTO race (race_code, race_description) VALUES
('ASN', 'Asian'),
('BLK', 'Black or African American'),
('WHT', 'White'),
('LAT', 'Latino/Hispanic'),
('NAT', 'Native American'),
('PAC', 'Pacific Islander'),
('MID', 'Middle Eastern'),
('MUL', 'Multiracial'),
('OTH', 'Other'),
('UND', 'Undisclosed');

-- 4. Location
INSERT INTO location(city_name, state_province_name, country_name, developing_flag, wealth_rank_number) VALUES
('New York', 'NY', 'USA', 'N', 9),
('Lalitpur', 'Bagmati', 'Nepal', 'Y', 5),
('London', 'England', 'UK', 'N', 10),
('Delhi', 'Delhi', 'India', 'Y', 6),
('Tokyo', 'Tokyo', 'Japan', 'N', 10),
('Lagos', 'Lagos', 'Nigeria', 'Y', 3),
('Berlin', 'Berlin', 'Germany', 'N', 9),
('Rio', 'RJ', 'Brazil', 'Y', 6),
('Toronto', 'ON', 'Canada', 'N', 9),
('Sydney', 'NSW', 'Australia', 'N', 10);


-- 5. Insurance
INSERT INTO insurance (provider_name, plan_name, coverage_percent) VALUES
('Aetna', 'Silver Plan', 80),
('Blue Cross', 'Gold Plan', 90),
('United Health', 'Bronze Plan', 70),
('Cigna', 'Platinum Plan', 95),
('Humana', 'Basic Care', 75),
('Kaiser', 'Family Health', 85),
('Anthem', 'Essential Health', 88),
('WellCare', 'WellBasic', 73),
('Oscar', 'Core Plan', 78),
('Molina', 'Complete Care', 92);

-- 6. Healthcare Provider
INSERT INTO healthcare_provider (name, specialization, location_id) VALUES
('Dr. Smith', 'Internal Medicine', 1),
('Dr. Sharma', 'Pulmonologist', 2),
('Dr. Ahmed', 'Cardiologist', 3),
('Dr. Lee', 'Neurologist', 4),
('Dr. Mehta', 'Oncologist', 5),
('Dr. Chen', 'Endocrinologist', 6),
('Dr. Patel', 'General Practitioner', 7),
('Dr. Gomez', 'Psychiatrist', 8),
('Dr. Kim', 'Immunologist', 9),
('Dr. Singh', 'Family Medicine', 10);

-- 7. Person
INSERT INTO person (last_name, first_name, gender, primary_location_id, race_cd, insurance_id, provider_id) VALUES
('Lee', 'Min', 'F', 1, 'ASN', 1, 1),
('Jackson', 'Tina', 'F', 1, 'BLK', 2, 1),
('Bhandari', 'Raj', 'M', 2, 'ASN', 3, 2),
('Smith', 'John', 'M', 3, 'WHT', 4, 3),
('Khan', 'Sara', 'F', 4, 'MID', 5, 4),
('Perez', 'Luis', 'M', 5, 'LAT', 6, 5),
('Whitecloud', 'Maya', 'F', 6, 'NAT', 7, 6),
('Park', 'Jin', 'M', 7, 'PAC', 8, 7),
('Nguyen', 'Linh', 'F', 8, 'ASN', 9, 8),
('Brown', 'Alicia', 'F', 9, 'BLK', 10, 9);

-- 8. Medicine
INSERT INTO medicine (standard_industry_number, name, company, active_ingredient_name) VALUES
('SIN123', 'Remdesivir', 'Gilead', 'GS-5734'),
('SIN456', 'Metformin', 'Sun Pharma', 'Metformin Hydrochloride'),
('SIN789', 'Aspirin', 'Bayer', 'Acetylsalicylic Acid'),
('SIN101', 'Lipitor', 'Pfizer', 'Atorvastatin'),
('SIN202', 'Prozac', 'Eli Lilly', 'Fluoxetine'),
('SIN303', 'Prednisone', 'Teva', 'Prednisone'),
('SIN404', 'Lisinopril', 'Novartis', 'Lisinopril'),
('SIN505', 'Tamoxifen', 'AstraZeneca', 'Tamoxifen Citrate'),
('SIN606', 'Levothyroxine', 'AbbVie', 'Levothyroxine'),
('SIN707', 'Insulin', 'Novo Nordisk', 'Insulin Human');

-- 9. Indication
INSERT INTO indication (medicine_id, disease_id, indication_date, effectiveness_percent) VALUES
(1, 1, '2020-06-01', 65.0),
(2, 2, '2018-01-15', 78.5),
(3, 8, '2021-02-01', 84.2),
(4, 8, '2020-03-21', 89.0),
(5, 5, '2022-05-10', 60.0),
(6, 7, '2021-07-14', 74.6),
(7, 8, '2019-09-30', 77.5),
(8, 4, '2021-11-01', 81.1),
(9, 10, '2022-03-10', 68.0),
(10, 2, '2017-10-05', 88.9);


-- 10. Diseased Patient
INSERT INTO diseased_patient (person_id, disease_id, severity_value, start_date, end_date) VALUES
(1, 1, 7, '2020-05-15', '2020-06-30'),
(2, 2, 6, '2019-03-10', NULL),
(3, 3, 8, '2021-11-05', NULL),
(4, 4, 9, '2022-02-01', NULL),
(5, 5, 5, '2021-01-20', NULL),
(6, 6, 6, '2020-12-10', NULL),
(7, 7, 7, '2021-03-15', NULL),
(8, 8, 8, '2022-07-07', NULL),
(9, 9, 6, '2023-05-01', NULL),
(10, 10, 5, '2021-09-25', NULL);

-- 11. Race Disease Propensity
INSERT INTO race_disease_propensity (race_code, disease_id, propensity_value) VALUES
('ASN', 2, 7),
('BLK', 2, 8),
('WHT', 1, 5),
('LAT', 5, 6),
('NAT', 4, 7),
('PAC', 3, 6),
('MID', 8, 8),
('MUL', 6, 7),
('OTH', 7, 5),
('UND', 9, 6);

-- 12. Test
INSERT INTO test (person_id, disease_id, test_date, result, result_value) VALUES
(1, 1, '2020-05-10', 'Positive', 1.0),
(2, 2, '2021-03-05', 'Negative', 0.0),
(3, 3, '2021-11-04', 'Positive', 1.0),
(4, 4, '2022-02-10', 'Positive', 1.0),
(5, 5, '2021-01-25', 'Negative', 0.0),
(6, 6, '2020-12-15', 'Positive', 1.0),
(7, 7, '2021-03-20', 'Negative', 0.0),
(8, 8, '2022-07-10', 'Positive', 1.0),
(9, 9, '2023-05-03', 'Negative', 0.0),
(10, 10, '2021-09-27', 'Positive', 1.0);


---Added more data in tables to show data fluctuate and trend in the dashboard.
-- Add multiple historical and current disease events
INSERT INTO diseased_patient (person_id, disease_id, severity_value, start_date, end_date) VALUES
(1, 2, 6, '2020-03-01', NULL),   -- Min Lee gets Diabetes in 2020
(1, 5, 4, '2022-08-10', NULL),   -- Min Lee also has Depression in 2022
(2, 1, 7, '2019-05-05', '2019-06-10'), -- Tina Jackson had COVID in 2019
(2, 3, 8, '2023-01-15', NULL),   -- Tina gets Tuberculosis in 2023
(3, 4, 9, '2024-03-20', NULL),   -- Raj Bhandari gets Breast Cancer
(4, 2, 5, '2021-07-22', NULL),   -- John Smith diagnosed with Diabetes
(5, 8, 9, '2022-12-01', NULL),   -- Sara Khan has Heart Attack
(6, 7, 7, '2023-11-30', NULL),   -- Luis Perez has Lupus
(7, 6, 5, '2020-06-06', NULL),   -- Maya gets Asthma
(10, 9, 6, '2021-04-19', NULL);  -- Alicia Brown develops Parkinson's

-- Corresponding test results for above events
INSERT INTO test (person_id, disease_id, test_date, result, result_value) VALUES
(1, 2, '2020-02-28', 'Positive', 1.0),
(1, 5, '2022-08-08', 'Positive', 1.0),
(2, 1, '2019-05-01', 'Positive', 1.0),
(2, 3, '2023-01-12', 'Positive', 1.0),
(3, 4, '2024-03-18', 'Positive', 1.0),
(4, 2, '2021-07-20', 'Positive', 1.0),
(5, 8, '2022-11-29', 'Positive', 1.0),
(6, 7, '2023-11-28', 'Positive', 1.0),
(7, 6, '2020-06-04', 'Positive', 1.0),
(10, 9, '2021-04-18', 'Positive', 1.0);


INSERT INTO diseased_patient (person_id, disease_id, severity_value, start_date, end_date) VALUES
(1, 7, 6, '2025-01-10', NULL),   -- Min Lee develops Lupus in 2025
(2, 10, 5, '2024-05-15', NULL),  -- Tina Jackson has Thyroid Disorder in 2024
(3, 1, 7, '2023-06-12', '2023-07-20'),  -- Raj Bhandari gets COVID again
(4, 6, 5, '2020-04-05', NULL),   -- John Smith has Asthma
(5, 9, 8, '2023-10-18', NULL),   -- Sara Khan develops Parkinson’s
(6, 4, 9, '2021-09-30', NULL),   -- Luis Perez gets Breast Cancer
(7, 10, 4, '2019-12-10', NULL),  -- Maya has Thyroid Disorder
(8, 2, 6, '2022-05-01', NULL),   -- Jin Park develops Diabetes
(9, 3, 7, '2021-01-20', NULL),   -- Linh Nguyen gets Tuberculosis
(10, 5, 5, '2018-11-01', NULL);  -- Alicia Brown has Depression

INSERT INTO test (person_id, disease_id, test_date, result, result_value) VALUES
(1, 7, '2025-01-09', 'Positive', 1.0),
(2, 10, '2024-05-13', 'Positive', 1.0),
(3, 1, '2023-06-10', 'Positive', 1.0),
(4, 6, '2020-04-04', 'Positive', 1.0),
(5, 9, '2023-10-17', 'Positive', 1.0),
(6, 4, '2021-09-28', 'Positive', 1.0),
(7, 10, '2019-12-08', 'Positive', 1.0),
(8, 2, '2022-04-29', 'Positive', 1.0),
(9, 3, '2021-01-18', 'Positive', 1.0),
(10, 5, '2018-10-29', 'Positive', 1.0);

INSERT INTO person (last_name, first_name, gender, primary_location_id, race_cd, insurance_id, provider_id) VALUES
('Omar', 'Leila', 'F', 3, 'MID', 2, 4),
('Chen', 'Xia', 'F', 4, 'ASN', 6, 5),
('Garcia', 'Carlos', 'M', 5, 'LAT', 3, 6),
('Hassan', 'Amina', 'F', 6, 'OTH', 4, 7),  -- AFR → OTH
('Jones', 'David', 'M', 7, 'WHT', 1, 8),
('Singh', 'Pooja', 'F', 8, 'ASN', 5, 9),
('Ahmed', 'Zaid', 'M', 9, 'MID', 6, 10),
('Nguyen', 'Bao', 'M', 10, 'ASN', 7, 1),
('Lopez', 'Maria', 'F', 1, 'LAT', 8, 2),
('Williams', 'James', 'M', 2, 'BLK', 9, 3),
('Gupta', 'Sneha', 'F', 2, 'ASN', 5, 3),      
('Rahman', 'Fatima', 'F', 3, 'MID', 5, 2),   
('Karki', 'Alisha', 'F', 4, 'ASN', 9, 1),     
('Lo', 'Angela', 'F', 5, 'PAC', 9, 6),        
('Rodriguez', 'Sofia', 'F', 6, 'LAT', 5, 7),  
('Taylor', 'Maya', 'F', 7, 'BLK', 9, 8),      
('Yadav', 'Rita', 'F', 8, 'ASN', 5, 9),       
('Ali', 'Zoya', 'F', 9, 'MID', 9, 10),        
('Singh', 'Neha', 'F', 10, 'WHT', 5, 4),      
('Kim', 'Jisoo', 'F', 1, 'ASN', 9, 5);


INSERT INTO diseased_patient (person_id, disease_id, severity_value, start_date, end_date) VALUES
(31, 2, 6, '2021-04-11', NULL), -- Leila Omar - Diabetes
(32, 6, 7, '2022-06-20', NULL), -- Xia Chen - Asthma
(33, 5, 5, '2023-01-10', NULL), -- Carlos Garcia - Depression
(34, 7, 8, '2023-03-12', NULL), -- Amina Hassan - Lupus
(35, 9, 6, '2024-02-18', NULL), -- David Jones - Parkinson's
(36, 4, 9, '2022-12-01', NULL), -- Pooja Singh - Breast Cancer
(37, 3, 7, '2023-10-10', NULL), -- Zaid Ahmed - Tuberculosis
(38, 1, 8, '2021-01-05', '2021-03-10'), -- Bao Nguyen - COVID
(39, 8, 9, '2024-05-20', NULL), -- Maria Lopez - Heart Attack
(40, 10, 6, '2019-06-10', NULL), -- James Williams - Thyroid
(41, 5, 7, '2023-04-01', NULL), -- Sneha Gupta - Depression
(42, 6, 5, '2023-06-06', NULL), -- Fatima Rahman - Asthma
(43, 2, 6, '2020-02-01', NULL), -- Alisha Karki - Diabetes
(44, 7, 8, '2021-12-15', NULL), -- Angela Lo - Lupus
(45, 9, 7, '2022-09-10', NULL), -- Sofia Rodriguez - Parkinson's
(46, 8, 6, '2021-07-25', NULL), -- Maya Taylor - Heart Attack
(47, 3, 7, '2023-05-08', NULL), -- Rita Yadav - Tuberculosis
(48, 10, 6, '2022-11-01', NULL), -- Zoya Ali - Thyroid Disorder
(49, 1, 5, '2021-10-20', NULL), -- Neha Singh - COVID
(50, 4, 9, '2024-03-15', NULL); -- Jisoo Kim - Breast Cancer


INSERT INTO test (person_id, disease_id, test_date, result, result_value) VALUES
(31, 2, '2021-04-09', 'Positive', 1.0),   -- Leila Omar - Diabetes
(32, 6, '2022-06-18', 'Positive', 1.0),   -- Xia Chen - Asthma
(33, 5, '2023-01-08', 'Positive', 1.0),   -- Carlos Garcia - Depression
(34, 7, '2023-03-10', 'Positive', 1.0),   -- Amina Hassan - Lupus
(35, 9, '2024-02-16', 'Positive', 1.0),   -- David Jones - Parkinson's
(36, 4, '2022-11-29', 'Positive', 1.0),   -- Pooja Singh - Breast Cancer
(37, 3, '2023-10-08', 'Positive', 1.0),   -- Zaid Ahmed - Tuberculosis
(38, 1, '2021-01-02', 'Positive', 1.0),   -- Bao Nguyen - COVID
(39, 8, '2024-05-18', 'Positive', 1.0),   -- Maria Lopez - Heart Attack
(40, 10, '2019-06-08', 'Positive', 1.0),  -- James Williams - Thyroid Disorder
(41, 5, '2023-03-30', 'Positive', 1.0),   -- Sneha Gupta - Depression
(42, 6, '2023-06-04', 'Positive', 1.0),   -- Fatima Rahman - Asthma
(43, 2, '2020-01-29', 'Positive', 1.0),   -- Alisha Karki - Diabetes
(44, 7, '2021-12-13', 'Positive', 1.0),   -- Angela Lo - Lupus
(45, 9, '2022-09-08', 'Positive', 1.0),   -- Sofia Rodriguez - Parkinson's
(46, 8, '2021-07-23', 'Positive', 1.0),   -- Maya Taylor - Heart Attack
(47, 3, '2023-05-06', 'Positive', 1.0),   -- Rita Yadav - Tuberculosis
(48, 10, '2022-10-30', 'Positive', 1.0),  -- Zoya Ali - Thyroid Disorder
(49, 1, '2021-10-18', 'Positive', 1.0),   -- Neha Singh - COVID
(50, 4, '2024-03-13', 'Positive', 1.0);   -- Jisoo Kim - Breast Cancer

