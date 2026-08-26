# Power BI DAX Measures
The following DAX measures were used to calculate key metrics in the Power BI dashboard

### Total ED Visits 2022

Calculates total 2022 emergency department visits by summing quarterly ED visit counts  
```DAX
Total ED Visits 2022 = 
SUM('ED_visits'[2022 Q1]) + 
SUM('ED_visits'[2022 Q2]) + 
SUM('ED_visits'[2022 Q3]) + 
SUM('ED_visits'[2022 Q4])
```

### Total PT Providers

Counts unique Medicare-billing physical therapists using NPI to prevent duplicate provider counts
```DAX
Total PT Providers = 
DISTINCTCOUNT('PT_data_with_RUCA'[npi])
```

### ED Visits per 100K

Normalizes ED visits by population to allow comparisons across states with different population sizes
```DAX
ED visits per 100K = 
DIVIDE([Total ED Visits 2022], [Total Population]) * 100000
```

### PTs per 100K

Normalizes Medicare-billing physical therapist counts by population to compare provider availability across geographic areas
```DAX
PTs per 100K = 
DIVIDE([Total PT Providers], [Total Population]) * 100000
```

### Total Population

Calculates total population within the current filter context
```DAX
Total Population = 
SUM('State_population'[Population])
```
