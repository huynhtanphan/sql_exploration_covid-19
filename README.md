# COVID-19 Exploration Data

This SQL project explores and analyzes data related to COVID-19 deaths and vaccinations, likely stored in two tables named "CovidDeaths" and "CovidVaccinations" within the "PortfolioProject" schema. The script performs various queries to understand different aspects of the pandemic across locations and time.

### 1. Initial Exploration:
Retrieves all data from both `CovidDeaths` and `CovidVaccinations` tables, ordered by location and date.

### 2. Selecting Relevant Data:
Selects specific columns (location, date, population, total cases, total deaths) from the `CovidDeaths` table for further analysis.

### 3. Analyzing Case Fatality Rate:
Calculates the death percentage for a specific location (Vietnam in this case) by dividing total deaths by total cases and multiplying by 100.

### 4. Analyzing Infection Rates:
Calculates the percentage of the population infected in each location by dividing total cases by population and multiplying by 100.

### 5. Identifying Countries with Highest Infection Rates:
Uses group by and aggregate functions to find the maximum total cases and corresponding maximum infection rate (percentage of population infected) for each location.

### 6. Identifying Countries with Highest Death Rates:
Focuses on locations with a continent specified.
Groups by location and population, then finds the maximum total death count for each location.
Calculates the death rate per population by dividing the maximum death count by the population and multiplying by 100.

### 7. Analyzing Deaths by Continent:
Groups data by continent (excluding locations with no continent specified) and finds the continent with the highest total death count.

### 8. Global COVID-19 Numbers:
Calculates global totals for new cases, deaths, and death percentage.

### 9. Analyzing Vaccination Rates with CTE (Common Table Expression):
Creates a CTE named `PopvsVac` to efficiently calculate rolling vaccination totals for each location.
Joins the `CovidDeaths` and `CovidVaccinations` tables based on location and date.
Calculates the vaccination rate as a percentage of the population by dividing the rolling people vaccinated by the population and multiplying by 100.

### 10. Analyzing Vaccination Rates with Temporary Table:
Creates a temporary table named `PercentPopulationVaccinated` with the same structure as the CTE from the previous step.
Populates the temporary table using similar logic as the CTE.
Calculates the vaccination rate as a percentage of the population similar to the CTE approach.

### 11. Creating a View for Later Use:
Creates a view named `PercentPopulationVaccinated` with the same logic as the CTE, potentially for future visualizations or complex queries that leverage pre-calculated rolling vaccination totals.
The view allows querying the pre-processed data without needing to repeat the join and aggregation logic every time.
