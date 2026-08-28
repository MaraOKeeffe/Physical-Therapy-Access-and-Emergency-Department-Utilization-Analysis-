/*
This query calculated a Pearson correlation coefficient between physical therapists per 100K
and ED visits for back and neck pain per 100K population.

The Pearson correlation coefficient was -0.216, indicating a weak negative 
linear association. Within the states represented in all datasets, greater physical therapist 
availability was associated with slightly lower ED visit rates. The magnitude of the coefficient 
is small, however, and the result does not establish that physical therapist availability 
causes changes in ED utilization
*/

WITH state_metrics AS (
  SELECT
    pt.State,


    COUNT(DISTINCT pt.npi) AS total_pts,
   
    SUM(ed.`2022 Q1` + ed.`2022 Q2` + ed.`2022 Q3` + ed.`2022 Q4`) AS total_ed_visits,
   
    MAX(pop.Population) AS state_pop,
   
    (COUNT(DISTINCT pt.npi) / MAX(pop.Population)) * 100000 AS pts_per_100K,


    (SUM(ed.`2022 Q1` + ed.`2022 Q2` + ed.`2022 Q3` + ed.`2022 Q4`) / MAX(pop.Population)) * 100000 AS ed_visits_per_100K


  FROM `pt-data-project.PT_data.PT_data_with_RUCA` AS pt
  JOIN `pt-data-project.PT_data.ED_visits` AS ed
    ON pt.State = ed.State
  JOIN `pt-data-project.PT_data.State_population` AS pop
    ON pt.State = pop.State


  GROUP BY pt.State
)


SELECT


  CORR(pts_per_100K, ed_visits_per_100K) AS normalized_correlation
FROM state_metrics;
