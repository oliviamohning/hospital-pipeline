-- 02_data_exploration.sql
-- Phase 2: Exploration and Validation
-- Purpose: Profile the cleaned CMS Hospital Readmissions dataset to verify data quality,
-- detect anomalies, and document patterns before transformation and modeling.

-- Preview a sample of ten rows
SELECT * FROM readmissions_clean LIMIT 10;

-- Check basic row and column counts
SELECT COUNT(*) AS total_rows FROM readmissions_clean;
SELECT COUNT(DISTINCT facility_id) AS unique_facility_ids FROM readmissions_clean;

-- Check for exact duplicate rows
SELECT 
    facility_name,
    facility_id,
    state,
    measure_name,
    COUNT(*) AS dup_count
FROM readmissions_clean
GROUP BY 
    facility_name,
    facility_id,
    state,
    measure_name,
    num_discharges,
    footnote,
    excess_readmission_ratio,
    predicted_readmission_rate,
    expected_readmission_rate,
    num_readmissions,
    start_date,
    end_date
HAVING COUNT(*) > 1
ORDER BY dup_count DESC;

-- Check for duplicates by hospital + measure
SELECT 
    facility_id,
    measure_name,
    COUNT(*) AS dup_count
FROM readmissions_clean
GROUP BY facility_id, measure_name
HAVING COUNT(*) > 1
ORDER BY dup_count DESC;

-- Confirm total row count vs. unique combinations
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT facility_id || '-' || measure_name) AS unique_facility_measure_pairs
FROM readmissions_clean;

-- Check min and max date ranges
SELECT MIN(start_date) AS earliest_start, MAX(end_date) AS latest_end
FROM readmissions_clean;

-- Check for nulls or missing values
SELECT 
    COUNT(*) FILTER (WHERE num_discharges IS NULL) AS null_discharges,
    COUNT(*) FILTER (WHERE excess_readmission_ratio IS NULL) AS null_ratios,
    COUNT(*) FILTER (WHERE predicted_readmission_rate IS NULL) AS null_predicted,
    COUNT(*) FILTER (WHERE expected_readmission_rate IS NULL) AS null_expected,
    COUNT(*) FILTER (WHERE num_readmissions IS NULL) AS null_readmissions
FROM readmissions_clean;

-- Summarize key metrics by state (sanity check for data distribution)
SELECT 
    state,
    COUNT(DISTINCT facility_id) AS facilities,
    ROUND(AVG(excess_readmission_ratio), 3) AS avg_ratio,
    ROUND(AVG(predicted_readmission_rate), 3) AS avg_predicted,
    ROUND(AVG(expected_readmission_rate), 3) AS avg_expected
FROM readmissions_clean
GROUP BY state
ORDER BY avg_ratio DESC;

-- Identify potential outliers (facilities with extreme readmission ratios)
SELECT 
    facility_name,
    state,
    excess_readmission_ratio
FROM readmissions_clean
WHERE excess_readmission_ratio > 1.3 OR excess_readmission_ratio < 0.7
ORDER BY excess_readmission_ratio DESC;
