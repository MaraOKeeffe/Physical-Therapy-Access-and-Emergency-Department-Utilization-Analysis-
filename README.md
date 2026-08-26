# Physical-Therapy-Access-and-Emergency-Department-Utilization-Analysis-
Analysis of how PT access might change ED utilization for MSK issues

## Project Overview
I designed this project to examine whether physical therapy availability is associated with emergency department utilization for musculoskeletal conditions. Using Medicare provider data from the Centers for Medicare & Medicaid Services (CMS), emergency department utilization data from the Agency for Healthcare Research and Quality (AHRQ), U.S. Census population data, and USDA Rural–Urban Commuting Area (RUCA) classifications, I analyzed geographic access to physical therapy and its relationship to emergency department visits for back and neck pain. 
## Business Problem
Many people end up in the emergency department (ED) for musculoskeletal (MSK) conditions that could be treated in an outpatient orthopedic physical therapy (PT) setting. When these patients end up in the ED, it is more costly for the healthcare system for a number of reasons including high cost of emergency visits, unnecessary imaging, and lack of follow up or root cause treatment which may lead the patient to seek ED care again.
## Business Question
- How many physical therapists who participate in Medicare are in each state, city, and ZIP code?
- How do different levels of rurality affect availability of PT providers?
- When there are more physical therapists in a geographical area, are patients more likely to seek outpatient care for MSK issues rather than ED care?
## Tools
BigQuery, SQL, Excel, Power BI
## Datasets
**1. CMS Medicare Physician & Other Practitioners (2024)** Centers for Medicare & Medicaid Services (CMS)  
This national dataset provided provider-level billing data, including billed service units, Medicare reimbursement amounts, provider credentials, specialty, and practice ZIP codes  
**2. Agency for Healthcare Research and Quality (AHRQ) – Emergency Department Visits**
This dataset provided state-level emergency department visit rates for back and neck pain. Because California was not included in the 2023 or 2024 releases, I used the 2022 dataset to preserve California in the analysis. The AHRQ dataset includes data for 37 states  
**3. U.S. Census Bureau – 2020 Census Apportionment Results**
This dataset provided state population estimates used to calculate physical therapists per 100,000 population and to normalize comparisons across states  
**4. USDA Economic Research Service – RUCA Codes by ZIP Code (2020)**
This dataset provided Rural–Urban Commuting Area (RUCA) classifications for ZIP codes, allowing analysis of physical therapist distribution by geographic tier  

Variables included:
- Provider education level (Doctorate, Master's, Bachelor's)
- Number of Medicare physical therapists
- Physical therapists per 100,000 population
- Medicare billed service units
- Medicare reimbursement amount
- Emergency department visits for back and neck pain
- State population
- RUCA score
- Geographic tier (Urban, Small Rural, Large Rural, Isolated Rural)  

## Methodology
CMS dataset
- Filtered to providers with the specialty "Physical Therapist in an Outpatient Setting"
- Excluded pharmacological billing codes because physical therapists do not have prescribing authority
- Standardized more than 1,500 unique self-reported credential entries into three education categories (Doctorate, Master's, Bachelor's) using SQL regular expressions
- Restored leading zeros to ZIP codes using LPAD() to preserve geographic accuracy
AHRQ dataset
- Excluded military facilities, Guam, Puerto Rico, and the U.S. Virgin Islands to maintain consistency with the state-level analysis
RUCA dataset
- Removed RUCA score 99 entries representing ZIP codes with no resident population
- Standardized ZIP code formatting to support joins with CMS provider data

## Key Findings

## Power BI Dashboard
