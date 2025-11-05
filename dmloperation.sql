-- Insert a new test for an existing patient
INSERT INTO test (person_id, disease_id, test_date, result, result_value)
VALUES (1, 2, '2024-01-01', 'Negative', 0.0);

-- Update severity of a disease case
UPDATE diseased_patient
SET severity_value = 9
WHERE person_id = 2 AND disease_id = 2;

-- Try deleting a medicine (will fail if it is referenced in indication table)
DELETE FROM medicine
WHERE medicine_id = 1;

-- Delete test data for a patient (if allowed)
DELETE FROM test
WHERE person_id = 3;
