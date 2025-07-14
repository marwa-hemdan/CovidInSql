--------------------------------------------------

select location,date,total_cases,total_deaths,
(total_deaths/total_cases)*100 as DeathPercentage 
from PortfolioProject..CovidDeaths
where location like '%states'
order by 3,4

---- show the percentage of total death per total_cases 

  SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    (total_deaths * 1.0 / total_cases) * 100 AS death_percentage
    FROM PortfolioProject..CovidDeaths
    WHERE location LIKE '%state%'
    ORDER BY 1, 2

    ---show the percentage of  total_cases per population percentage 
    SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    CASE 
        WHEN TRY_CAST(CAST(population AS VARCHAR(MAX)) AS FLOAT) = 0 THEN NULL
        ELSE (TRY_CAST(CAST(total_cases AS VARCHAR(MAX)) AS FLOAT) / 
             TRY_CAST(CAST(population AS VARCHAR(MAX)) AS FLOAT)) * 100
    END AS cases_per_population_percentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%state%'
ORDER BY location, date;

 -----show countries with highest percentPopulationinfected 

  SELECT 
    location,
    population,
   max( total_cases ) as highestInfectionCount, 
   Max((total_cases * 1.0 /population))*100 as percentPopulationInfected
    FROM PortfolioProject..CovidDeaths
    group by location,population 
    ORDER BY percentPopulationInfected desc

    --------showing countries with highest death count per population
    SELECT 
    location,
    max( cast(total_deaths as int)) as totalDeathCount
    FROM PortfolioProject..CovidDeaths
    group by location 
    ORDER BY totalDeathCount desc


    ----- show countries with highest death count per population
    select location, max( total_deaths * 1.0) as totalDeathCount
    from PortfolioProject..CovidDeaths
    where continent is not null
    group by location
    order by totalDeathCount desc


----- Let's break things down by continent-----

  select continent, max( total_deaths * 1.0 ) as totalDeathCount
    from PortfolioProject..CovidDeaths
    where continent is not null
    group by continent
    order by totalDeathCount desc  


---- get the total deaths per continent---- 
  select continent, max( total_deaths * 1.0 ) as totalDeathCount
    from PortfolioProject..CovidDeaths
    where continent is null
    group by continent
    order by totalDeathCount desc  


----- get sum of all cases in the same day all over the world----
 
select date, sum(new_cases) as new_cases, sum(new_deaths) as new_deaths, 
sum(new_deaths * 1.0)/sum(new_cases * 1.0)*100  as total_death_percentage
from PortfolioProject..CovidDeaths
where continent is not null
group by date
order by 1

---- total new cases without grouping ----

select  sum(new_cases) as new_cases, sum(new_deaths) as new_deaths, 
sum(new_deaths * 1.0)/sum(new_cases * 1.0)*100  as total_death_percentage
from PortfolioProject..CovidDeaths
where continent is not null
order by 1
 
---- select total covidVaccination ----

select * from
PortfolioProject..CovidVaccinations


---- USE CTE ----
With PopvsVac ( continent, Location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population ,
vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over 
(partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated 
--(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location= vac.location 
and dea.date=vac.date 
where dea.continent is not null
--order by 1,2,3
)
select *, (RollingPeopleVaccinated * 1.0 /population) *100 from PopvsVac

---- TEMP TABLE ----

 Drop table if exists #percentPopulationVaccinated
 create table #percentPopulationVaccinated
 (
 continent nvarchar(255),
 location nvarchar(255),
 Date dateTime,
 Population numeric,
 New_vaccinations numeric,
 RollingPeopleVaccinated numeric
 )

insert into #percentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population ,
vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over 
(partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated 
--(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location= vac.location 
and dea.date=vac.date 
where dea.continent is not null
----- creating view to store data for later visualization 

create view percentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population ,
vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over 
(partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated 
--(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location= vac.location 
and dea.date=vac.date 
where dea.continent is not null

select * 
from percentPopulationVaccinated