/*
This dataset contained over 1,500 different self-reported credentials for physical therapists. 
This query standardized all credentials by education level and excluded credentials such as,
"RPT" and "PTA" as the first cannot be confirmed as a physical therapist with the
second being a physical therapy assistant and not the main biller for Medicare claims.

The query also restored leading zeros for ZIP codes to maintain a consistent five-digit
ZIP code across all states.
*/

CREATE OR REPLACE TABLE `pt-data-project.PT_data.PT_data_2024_Cleaned` AS


WITH standardized_data AS (
  SELECT
    *,
    LPAD(CAST(zip AS STRING), 5, '0') AS clean_zip,
    UPPER(TRIM(REGEXP_REPLACE(credentials, r'[\.,-]', ' '))) AS clean_crd
  FROM `pt-data-project.PT_data.PT_data_2024`
)


SELECT
  * EXCEPT(clean_crd, zip, clean_zip),
  clean_zip AS zip,
  CASE
    WHEN REGEXP_CONTAINS(clean_crd, r'\b(DPT)\b')
      THEN 'Doctorate'


    WHEN REGEXP_CONTAINS(clean_crd, r'\b(MPT|MSPT|MS)\b')
      OR REGEXP_CONTAINS(clean_crd, r'\bMS\s+PT\b')
      THEN 'master's'


    WHEN REGEXP_CONTAINS(clean_crd, r'\b(BSPT|BS|BA|PT)\b')
      OR REGEXP_CONTAINS(clean_crd, r'\bBS\s+PT\b')
      THEN 'bachelor's'
  END AS pt_education_level
FROM standardized_data
WHERE NOT REGEXP_CONTAINS(clean_crd, r'\b(RPT|PTA)\b')
  AND (
    REGEXP_CONTAINS(clean_crd, r'\b(DPT)\b')
    OR REGEXP_CONTAINS(clean_crd, r'\b(MPT|MSPT|MS)\b')
    OR REGEXP_CONTAINS(clean_crd, r'\bMS\s+PT\b')
    OR REGEXP_CONTAINS(clean_crd, r'\b(BSPT|BS|BA|PT)\b')
    OR REGEXP_CONTAINS(clean_crd, r'\bBS\s+PT\b')
  );
