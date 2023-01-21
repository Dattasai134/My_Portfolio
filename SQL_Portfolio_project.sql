select * 
from SQL_Portfolio_Project..covid_deaths
order by 3,4

--select * 
--from SQL_Portfolio_Project..covid_vaccinations
--order by 3,4

-- Select data that we are going to be using.

select location, date, total_cases, new_cases, total_deaths, population
from SQL_Portfolio_Project..covid_deaths
order by 1,2

-- Looking at total cases vs total deaths.

select location, date, total_cases, total_deaths, (total_cases/total_deaths)*100 as death_percentage
from SQL_Portfolio_Project..covid_deaths
where location like '%africa%'
order by 1,2

-- Looking at total cases vs Population.
-- shows what percentage of population got covid.

select location, date, Population, total_cases, (total_cases/population)*100 as Population_infected_percentage
from SQL_Portfolio_Project..covid_deaths
--where location like '%africa%'
order by 1,2

-- Looking at Countries with highest infection rate compared to population.

select location, Population, MAX(total_cases) as Highly_infected, MAX((total_cases/population))*100 as Population_infected_percentage
from SQL_Portfolio_Project..covid_deaths
--where location like '%africa%'
group by Location, population
order by Population_infected_percentage desc

-- showing countries with highest death count per population

-- Let's Break things down by contitnent

select continent, MAX(cast(total_deaths as int)) as Totaldeathcount
from SQL_Portfolio_Project..covid_deaths
--where location like '%africa%'
where continent is null
group by continent
order by Totaldeathcount desc

select continent, MAX(cast(total_deaths as int)) as Totaldeathcount
from SQL_Portfolio_Project..covid_deaths
--where location like '%africa%'
where continent is not null
group by continent
order by Totaldeathcount desc

-- Showing continents with the highnest deaths count per population.

select continent, MAX(cast(total_deaths as int)) as Totaldeathcount
from SQL_Portfolio_Project..covid_deaths
--where location like '%africa%'
where continent is not null
group by continent
order by Totaldeathcount desc

-- global numbers

select date, sum(new_cases) as total_cases ,sum(cast(new_deaths as int)) as total_deaths , sum(cast(new_deaths as int))/sum(new_cases)*100 as Deaths_percentage
from SQL_Portfolio_Project..covid_deaths
where continent is not null
group by date
order by 1,2

-- looking at total populations and vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations )) OVER (partition by dea.location order by dea.location,dea.date) 
as rolling_people_vaccinated
from SQL_Portfolio_Project..Covid_Deaths dea
join SQL_Portfolio_Project..Covid_Vaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- USE CTE

with popvsvac (continent, location, date, population, new_vaccinations, Rollingpeoplevaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations )) OVER (partition by dea.location order by dea.location,dea.date) 
as rolling_people_vaccinated
--,(rollingpeoplevaccinated/population)*100
from SQL_Portfolio_Project..Covid_Deaths dea
join SQL_Portfolio_Project..Covid_Vaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *,  (Rollingpeoplevaccinated/population)*1
from popvsvac

-- TEMP TABLE

create table #percentpopulationvaccinated
(
Continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
Rollingpeoplevaccinated numeric
)
insert into #percentpopulationvaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations )) OVER (partition by dea.location order by dea.location,dea.date) 
as rolling_people_vaccinated
--,(rollingpeoplevaccinated/population)*100
from SQL_Portfolio_Project..Covid_Deaths dea
join SQL_Portfolio_Project..Covid_Vaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
select *, (Rollingpeoplevaccinated/population)*1
from #percentpopulationvaccinated

-- Creating view to store data for later visualizations
create view percentpopulationvaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations )) OVER (partition by dea.location order by dea.location,dea.date) 
as rolling_people_vaccinated
--,(rollingpeoplevaccinated/population)*100
from SQL_Portfolio_Project..Covid_Deaths dea
join SQL_Portfolio_Project..Covid_Vaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select * from percentpopulationvaccinated