/*
This query aggregated 2022 ED visits by state in order to include data from California which does
not appear in 2023 or 2024. Next, it combined 2024 CMS provider counts with 2020 Census population 
data and state-level ED visits. 

The query calculated physical therapists per 100K population, ED visits 
per 100K population, and ED visits per physical therapist to support state-level comparisons of 
provider availability and ED utilization.
*/

WITH localized_2022_ed AS (
  SELECT
    State AS ed_state,
    SUM(`2022 Q1` + `2022 Q2` + `2022 Q3` + `2022 Q4`) AS annual_2022_ed_visits
  FROM `pt-data-project.PT_data.ED_visits`
  GROUP BY State
),


pt_counts_2024 AS (
  SELECT
    state AS pt_state,
    COUNT(*) AS total_pt_providers
  FROM `pt-data-project.PT_data.PT_data_2024_Cleaned`
  GROUP BY state
),


state_pop AS (
  SELECT
    state AS pop_state,
    population AS total_population
  FROM `pt-data-project.PT_data.State_population`
)


SELECT
  pop.pop_state AS State,
  pop.total_population,
  pt.total_pt_providers,
  ed.annual_2022_ed_visits,
 
  ROUND((pt.total_pt_providers / pop.total_population) * 100000, 2) AS pts_per_100K,
 
  ROUND((ed.annual_2022_ed_visits / pop.total_population) * 100000, 2) AS ed_visits_per_100K,
 
  ROUND(ed.annual_2022_ed_visits / pt.total_pt_providers, 2) AS ed_visits_per_pt


FROM state_pop AS pop
INNER JOIN pt_counts_2024 AS pt
  ON pop.pop_state = pt.pt_state
INNER JOIN localized_2022_ed AS ed
  ON pop.pop_state = ed.ed_state


ORDER BY pts_per_100K ASC;
