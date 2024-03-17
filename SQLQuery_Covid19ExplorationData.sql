/*
COVID_19_EXPLORATION_DATA
*/

-----------------------------------------------------------------------
--Looking
SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4

SELECT *	
FROM PortfolioProject..CovidVaccinations
ORDER BY 3,4



-----------------------------------------------------------------------
--Select data that is being used

SELECT location, date, population, total_cases, total_deaths
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2



-----------------------------------------------------------------------
--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%vietnam%'
ORDER BY 1,2



-----------------------------------------------------------------------
--Looking at Total Cases vs Population
--Shows what percentage of population got Covid

SELECT location, date, population, total_cases, (total_cases/ population)*100 as percent_population_infected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%vietnam%'
ORDER BY 1,2



-----------------------------------------------------------------------
--Looking at Countries with Highest Infection Rate compared to Population

SELECT location, Max(total_cases) as highest_infection_count, Max((total_cases/ population)*100) as percent_population_infected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY percent_population_infected DESC




-----------------------------------------------------------------------
--Looking at Countries with Highest Death Count per Population

SELECT location, Max(total_deaths) as total_death_count
, (Max(total_deaths)/population)*100 AS death_rate_per_population
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY total_death_count DESC

	
-----------------------------------------------------------------------
--Let's break things down by continent
--Showing continents with the highest death count per population

SELECT continent, Max(total_deaths) as total_death_count
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY total_death_count DESC


-----------------------------------------------------------------------
--GLOBAL NUMBERS

SELECT sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as death_percentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null 
ORDER BY 1,2



-----------------------------------------------------------------------
--Use CTE

WITH PopvsVac (Continet, Location, Date,Population, New_vaccinations, Rolling_people_vaccinated)
AS
(
SELECT	
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as rolling_people_vaccinated
FROM 
	PortfolioProject..CovidDeaths dea
join
	PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location																																																																
	and dea.date = vac.date
WHERE dea.continent is not null
)

SELECT *, (Rolling_people_vaccinated/ Population)*100 AS vaccination_rate_of_a_population
FROM PopvsVac




-----------------------------------------------------------------------
--TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
	(
	Continet nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	Rolling_people_vaccinated numeric
	)
INSERT INTO #PercentPopulationVaccinated
SELECT	
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as rolling_people_vaccinated
FROM 
	PortfolioProject..CovidDeaths dea
join
	PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location																																																																
	and dea.date = vac.date
WHERE dea.continent is not null


SELECT *, (Rolling_people_vaccinated/ Population)*100 
FROM #PercentPopulationVaccinated



-----------------------------------------------------------------------
--Creating Views to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT	
	dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as rolling_people_vaccinated
FROM 
	PortfolioProject..CovidDeaths dea
join
	PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location																																																																
	and dea.date = vac.date
WHERE dea.continent is not null

SELECT *
FROM PercentPopulationVaccinated
