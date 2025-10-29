# Phase 2: Data Exploration and Validation

This document summarizes findings from exploratory SQL analysis of the CMS Hospital Readmissions Reduction Program (HRRP) dataset. The goal of this phase was to verify data quality, identify anomalies, and prepare for transformation and modeling in the next phase.

---

## 1. General Structure

**Findings**  
- Total rows: 18,510  
- Unique facility IDs: 3,085  
- Unique facility names: 3,021  

**Interpretation**  
The difference between facility IDs and names indicates that some hospital systems have multiple sites or reporting units sharing the same name (for example, “Memorial Hospital”). This is normal in CMS data. The **facility_id** field will be used as the unique identifier for all further analysis.

---

## 2. Data Integrity

**Findings**  
- No exact duplicate rows found.  
- No duplicate hospital–measure pairs.  
- Date range: 2020-07-01 to 2023-06-30.  

**Interpretation**  
The dataset is structurally clean and free of duplicate records. All dates fall within a valid range consistent with CMS fiscal reporting cycles (FY2025 datasets usually cover the preceding three years).

---

## 3. Missing Data

**Findings**

| Column | Null Count | Approx. % |
| ------- | ----------- | ---------- |
| num_discharges | 10,170 | ~55% |
| excess_readmission_ratio | 6,583 | ~36% |
| predicted_readmission_rate | 6,583 | ~36% |
| expected_readmission_rate | 6,583 | ~36% |
| num_readmissions | 10,389 | ~56% |

**Interpretation**  
High null counts reflect suppressed or redacted data for small hospitals or low-volume measures (“Too Few to Report”). These are not data errors but CMS privacy protections. Nulls should be retained but excluded from averages and aggregations.

---

## 4. Metric Distributions

**Findings**  
- States with the highest average excess readmission ratios: Massachusetts (1.041), New Jersey (1.028), Illinois (1.020).  
- States with the lowest: Kansas (0.961), Maine (0.959), Utah (0.956).  
- Outliers include several specialty hospitals with ratios > 1.4 or < 0.7.

**Interpretation**  
Most facilities cluster around 1.0, which represents the national average. High or low outliers likely represent surgical or orthopedic centers with selective patient populations, or facilities penalized for high readmissions.

---

## 5. Hospital Naming

**Findings**  
Common duplicate names include “Memorial Hospital” and “St. Mary’s Medical Center.”  

**Interpretation**  
Hospital names are not unique identifiers. **facility_id** will serve as the primary key. When aggregating by name, pair it with `state` to avoid merging unrelated hospitals.

---

## 6. Date Range Sanity Check

**Findings**  
- Earliest start: 2020-07-01  
- Latest end: 2023-06-30  

**Interpretation**  
Date coverage matches CMS’s three-year measurement period and aligns with FY2025 reporting standards. No missing or invalid dates were observed.

---

## 7. Overall Impression

**Summary**  
- The dataset is structurally clean and well-formed.  
- Missing data is significant but explainable.  
- Numeric columns are valid and ready for aggregation.  
- Hospital identifiers behave as expected.  

**Next Steps**  
1. Normalize column naming conventions for use in dbt or Python scripts.  
2. Create summary tables for:  
   - Average readmission ratios by state.  
   - Aggregated facility-level metrics.  
   - Outlier detection for high/low performers.  
3. Prepare transformation scripts (`03_transformations.sql` or Python ETL).  
4. Document business logic for metric calculations.
