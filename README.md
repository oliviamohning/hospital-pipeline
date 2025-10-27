# Hospital Readmissions Data Pipeline

End-to-end data pipeline analyzing CMS Hospital Readmissions Reduction Program (HRRP) data — from ingestion and cleaning to automated ETL and Power BI dashboards.

---

## Project Roadmap (Phases)

**Phase 1: Setup and Data Ingestion**  
• Configure PostgreSQL database and Python environment  
• Import FY2025 CMS Hospital Readmissions dataset (18,510 records)  
• Verify and clean raw data (handle 'N/A' entries, convert types)  
✓ Completed  

**Phase 2: Exploration and Validation**  
• Explore data structure and quality  
• Run SQL summary queries to identify patterns and anomalies  
• Document initial findings for later visualization  
In progress  

**Phase 3: Transformation and ETL**  
• Build Python ETL script for data cleaning and transformation  
• Create reproducible data pipeline output tables  

**Phase 4: Automation and Modeling**  
• Implement dbt and Airflow for automated transformations  
• Schedule ETL jobs and add data validation tests  

**Phase 5: Visualization and Reporting**  
• Connect Power BI to cleaned database  
• Build dashboards showing readmission trends by state, hospital, and condition  

**Phase 6: Documentation and Portfolio Polish**  
• Finalize README, repo structure, and project summary  
• Publish dashboard and insights  
• Prepare portfolio and résumé materials for job applications  

---

## Design Philosophy

This project isn’t just about using tools; it’s about understanding when and why to use them. Each component in the pipeline was chosen to reflect how data engineering operates in production environments. Following the principle that *strategy should drive tactics*, the technology choices were made through a structured decision process:

1. **What’s the nature of the data?**  
   Static, structured CSVs from CMS — suitable for a relational database (PostgreSQL) and cloud warehousing (Snowflake).  

2. **Where will it live?**  
   Local development for ingestion and cleaning; cloud warehouse for scalable storage and analytics.  

3. **How often does it change?**  
   Periodic government updates — modeled as batch ETL jobs orchestrated by Airflow.  

4. **What needs to happen to it?**  
   Cleaning, validation, and aggregation — handled through SQL transformations modularized in dbt.  

5. **Who’s the end user?**  
   Analysts and decision-makers — insights delivered through Power BI dashboards and documented lineage via dbt and GitHub.  

“Strategy without tactics is the slowest route to victory.  
Tactics without strategy is the noise before defeat.” — Sun Tzu  

---

## Tech Stack
PostgreSQL • Python (pandas) • dbt • Airflow • Snowflake • Power BI • Git/GitHub • Docker (planned)

---

## Ethical Considerations

This dataset originates from the CMS Hospital Readmissions Reduction Program (HRRP), a policy initiative intended to improve care quality by penalizing hospitals with high readmission rates.  
While the data offers valuable insight into healthcare performance, it also reflects systemic inequities — hospitals serving low-income, aging, or chronically ill populations are disproportionately affected.  
This project focuses on technical data engineering and analysis, not on endorsing policy outcomes.

---

## License
MIT License © 2025 Olivia Mohning
