-- Step 1: Create raw staging table
-- Mirrors the CSV structure for initial ingestion.
CREATE TABLE readmissions (
    facility_name TEXT,
    facility_id TEXT,
    state TEXT,
    measure_name TEXT,
    num_discharges TEXT,
    footnote TEXT,
    excess_readmission_ratio TEXT,
    predicted_readmission_rate TEXT,
    expected_readmission_rate TEXT,
    num_readmissions TEXT,
    start_date TEXT,
    end_date TEXT
);


-- Step 2: Examine raw data for non-numeric or irregular values
-- Identifies invalid entries like "N/A" or "Too Few to Report" before casting.
SELECT DISTINCT num_discharges
FROM readmissions
WHERE num_discharges !~ '^[0-9]+$'
ORDER BY num_discharges;

SELECT DISTINCT excess_readmission_ratio
FROM readmissions
WHERE excess_readmission_ratio !~ '^[0-9.]+$'
ORDER BY excess_readmission_ratio;

SELECT DISTINCT num_readmissions
FROM readmissions
WHERE num_readmissions !~ '^[0-9]+$'
ORDER BY num_readmissions;


-- Step 3: Create cleaned and typed table
-- Replaces invalid text values with NULL and casts columns to numeric and date types.
CREATE TABLE readmissions_clean AS
SELECT
    facility_name,
    facility_id,
    state,
    measure_name,
    NULLIF(NULLIF(num_discharges, 'N/A'), 'Too Few to Report')::INT AS num_discharges,
    footnote,
    NULLIF(NULLIF(excess_readmission_ratio, 'N/A'), 'Too Few to Report')::NUMERIC AS excess_readmission_ratio,
    NULLIF(NULLIF(predicted_readmission_rate, 'N/A'), 'Too Few to Report')::NUMERIC AS predicted_readmission_rate,
    NULLIF(NULLIF(expected_readmission_rate, 'N/A'), 'Too Few to Report')::NUMERIC AS expected_readmission_rate,
    NULLIF(NULLIF(num_readmissions, 'N/A'), 'Too Few to Report')::INT AS num_readmissions,
    TO_DATE(NULLIF(start_date, 'N/A'), 'MM/DD/YYYY') AS start_date,
    TO_DATE(NULLIF(end_date, 'N/A'), 'MM/DD/YYYY') AS end_date
FROM readmissions;


-- Step 4: Verify cleaned table schema
-- Confirms column data types are correctly assigned.
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'readmissions_clean'
ORDER BY ordinal_position;
