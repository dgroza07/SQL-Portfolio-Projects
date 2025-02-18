Select *
From Covid_Portfolio_Project..CovidDeaths
Where continent is not null
order by 3,4

-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From Covid_Portfolio_Project..CovidDeaths
Where continent is not null
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Demonstrates probability of death from contracting covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid_Portfolio_Project..CovidDeaths
Where location like '%states%'
and continent is not null
order by 1,2

-- Loooking at Total Cases vs Total Deaths
-- Shows what percentage of population contracted Covid

Select Location, date, population, total_cases, (total_cases/population)*100 as Total_Case_by_Population
From Covid_Portfolio_Project..CovidDeaths
Where location like '%states%'
and continent is not null
order by 1,2


-- Looking at Countries with Highest Infecction Rate compared to Population

Select Location, population, MAX(total_cases) as Highest_Infection_Count, MAX(total_cases/population)*100 as Total_Case_by_Population
From Covid_Portfolio_Project..CovidDeaths
--Where location like '%states%'
Group by location, population
order by Total_Case_by_Population desc


-- Showing Countries with Highest Death Count per Population

Select location, MAX(cast(total_deaths as int)) as Total_Death_Count
From Covid_Portfolio_Project..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by location
order by Total_Death_Count desc


-- Categorization by Continent

-- Showing continents with the highest death count per population 

Select continent, MAX(cast(total_deaths as int)) as Total_Death_Count
From Covid_Portfolio_Project..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by continent
order by Total_Death_Count desc


-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Covid_Portfolio_Project..CovidDeaths
Where continent is not null
--Group by date
order by 1,2


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has received at least one Covid Vaccine 

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as Rolling_People_Vaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid_Portfolio_Project..CovidDeaths dea
Join Covid_Portfolio_Project..CovidVaccinations vac 
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null	
order by 2, 3


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid_Portfolio_Project..CovidDeaths dea
Join Covid_Portfolio_Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid_Portfolio_Project..CovidDeaths dea
Join Covid_Portfolio_Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated



-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid_Portfolio_Project..CovidDeaths dea
Join Covid_Portfolio_Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
