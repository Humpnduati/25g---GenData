-- a. new_stud_details (JOIN to get student details):

SELECT p.stud_name, p.stud_ID, s.stud_email, p.phone_number
FROM personal_details p
JOIN school_details s ON p.stud_ID = s.stud_ID;

-- b. full_stud_details (Combine all tables):

CREATE TABLE full_stud_details AS
SELECT 
    p.*, 
    s.current_home_county, 
    s.secondary_school_county, 
    s.residence, 
    s.stud_email,
    c.next_of_kin_name, 
    c.next_of_kin_relation, 
    c.next_of_kin_contacts,
    f.sem_fee, 
    f.fee_paid
FROM personal_details p
JOIN school_details s ON p.stud_ID = s.stud_ID
JOIN contact_details c ON s.stud_email = c.stud_email
JOIN financial_details f ON p.stud_ID = f.stud_ID;
 
 SELECT * FROM full_stud_details;

-- c. Update missing names in financial_details:

UPDATE financial_details f
JOIN personal_details p ON f.stud_ID = p.stud_ID
SET f.stud_name = p.stud_name
WHERE f.stud_name IS NULL OR f.stud_name = '';

-- d. Add fee_cleared column (using a view):

ALTER TABLE financial_details
ADD COLUMN fee_cleared BOOLEAN;

UPDATE financial_details
SET fee_cleared = (fee_paid >= sem_fee);


-- e. fee_cleared (Students with cleared fees):

SELECT national_ID, stud_name
FROM personal_details
WHERE stud_ID IN (
    SELECT stud_ID 
    FROM financial_details 
    WHERE fee_paid >= sem_fee
);

-- f. total_fee_balance:
SELECT 
    SUM(fee_paid) AS total_paid,
    SUM(GREATEST(sem_fee - fee_paid, 0)) AS total_deficit
FROM financial_details;

-- g. home_county_count:

SELECT current_home_county, COUNT(*) AS student_count
FROM school_details
GROUP BY current_home_county;

-- h. secondary_school_count (Gender count per county):

SELECT 
    s.secondary_school_county,
    SUM(CASE WHEN p.gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN p.gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM school_details s
JOIN personal_details p ON s.stud_ID = p.stud_ID
GROUP BY s.secondary_school_county;

-- i. kin_percentage:

SELECT 
    ROUND(
        (SUM(CASE WHEN next_of_kin_relation = 'Mother' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS mother_percentage,
    ROUND(
        (SUM(CASE WHEN next_of_kin_relation = 'Father' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS father_percentage
FROM contact_details;


