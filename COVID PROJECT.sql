select * from [dbo].[CovidDeaths$] 

select * from [dbo].[Covidvaccination$] 

 
 --- TOTAL CASES VS TOTAL DEATH
 select location , date , total_cases, total_deaths , (total_deaths/total_cases)*100 as 
 deathpercentage from [dbo].[CovidDeaths$]
 where location like '%india%' and continent is not null order by 1,2

 --- TOTAL CASES VS TOTAL POPULATION
 select location,date,population,total_cases,(total_deaths/total_cases)*100 as
 percentagepopulationinfected from [dbo].[CovidDeaths$]
  where location like '%india%' and continent is not null order by 1,2

  --- COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION
  select location,population,max(total_cases) as highestinfectioncount,
  max((total_cases/population))*100 as percentpopulationinfected
from [dbo].[CovidDeaths$] where continent is not null 
group by location,population order by percentpopulationinfected desc

  --- COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION
  select location, population ,max(cast(total_deaths as int)) as totaldeathcount from [dbo].[CovidDeaths$]
  where continent is not null
  group by location , population
  order by totaldeathcount desc
 
--- CONTINENTS WITH HIGHEST DEATH COUNT PER POPULATIONS
select continent,max(cast(total_deaths as int)) as totaldeathcount
from [dbo].[CovidDeaths$]
where continent is not null 
group by continent
order by totaldeathcount

--- JOINING COVID DEATH AND VACCINATION TABLE
select * from [dbo].[CovidDeaths$] dea join [dbo].[Covidvaccination$] vac
on dea.location = vac.location 
and dea.date = vac.date

--- TOTAL POPULATION VS VACCINATION
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
from [dbo].[CovidDeaths$] dea 
join [dbo].[Covidvaccination$] vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
order by 2,3

