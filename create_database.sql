-- Active: 1740480950412@@localhost@3306@covid
CREATE DATABASE IF NOT EXISTS Covid;

USE Covid;

DROP TABLE IF EXISTS coviddeaths;
DROP TABLE IF EXISTS CovidVaccinations;

CREATE TABLE coviddeaths (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,                               -- Use DATE type for proper date handling
    population BIGINT,
    total_cases BIGINT,
    new_cases INT,
    new_cases_smoothed FLOAT NULL,           -- Allow NULL for smoothed cases
    total_deaths BIGINT NULL,                -- Allow NULL for missing death counts
    new_deaths INT NULL,                     -- Allow NULL for new deaths
    new_deaths_smoothed FLOAT NULL,          -- Allow NULL for smoothed deaths
    total_cases_per_million FLOAT NULL,      
    new_cases_per_million FLOAT NULL,
    new_cases_smoothed_per_million FLOAT NULL,
    total_deaths_per_million FLOAT NULL,
    new_deaths_per_million FLOAT NULL,
    new_deaths_smoothed_per_million FLOAT NULL,
    reproduction_rate FLOAT NULL,            -- Allow NULL for missing reproduction rates
    icu_patients FLOAT NULL,                 
    icu_patients_per_million FLOAT NULL,
    hosp_patients FLOAT NULL,                -- Changed to FLOAT and nullable
    hosp_patients_per_million FLOAT NULL,
    weekly_icu_admissions FLOAT NULL,
    weekly_icu_admissions_per_million FLOAT NULL,
    weekly_hosp_admissions FLOAT NULL,
    weekly_hosp_admissions_per_million FLOAT NULL
);


CREATE TABLE CovidVaccinations (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date VARCHAR(100),
    new_tests FLOAT,
    total_tests FLOAT,
    total_tests_per_thousand FLOAT,
    new_tests_per_thousand FLOAT,
    new_tests_smoothed FLOAT,
    new_tests_smoothed_per_thousand FLOAT,
    positive_rate FLOAT,
    tests_per_case FLOAT,
    tests_units VARCHAR(50),
    total_vaccinations FLOAT,
    people_vaccinated FLOAT,
    people_fully_vaccinated FLOAT,
    new_vaccinations FLOAT,
    new_vaccinations_smoothed FLOAT,
    total_vaccinations_per_hundred FLOAT,
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    new_vaccinations_smoothed_per_million FLOAT,
    stringency_index FLOAT,
    population_density FLOAT,
    median_age FLOAT,
    aged_65_older FLOAT,
    aged_70_older FLOAT,
    gdp_per_capita FLOAT,
    extreme_poverty FLOAT,
    cardiovasc_death_rate FLOAT,
    diabetes_prevalence FLOAT,
    female_smokers FLOAT,
    male_smokers FLOAT,
    handwashing_facilities FLOAT,
    hospital_beds_per_thousand FLOAT,
    life_expectancy FLOAT,
    human_development_index FLOAT
);

SET SESSION sql_mode = '';


LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.2\\Uploads\\CovidDeaths.csv"
INTO TABLE coviddeaths
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@iso_code, @continent, @location, @date, @population, @total_cases, @new_cases, 
 @new_cases_smoothed, @total_deaths, @new_deaths, @new_deaths_smoothed, 
 @total_cases_per_million, @new_cases_per_million, @new_cases_smoothed_per_million, 
 @total_deaths_per_million, @new_deaths_per_million, @new_deaths_smoothed_per_million, 
 @reproduction_rate, @icu_patients, @icu_patients_per_million, @hosp_patients, 
 @hosp_patients_per_million, @weekly_icu_admissions, @weekly_icu_admissions_per_million, 
 @weekly_hosp_admissions, @weekly_hosp_admissions_per_million)
SET 
    date = IF(STR_TO_DATE(@date, '%d-%m-%Y') IS NULL, NULL, STR_TO_DATE(@date, '%d-%m-%Y')),
    weekly_hosp_admissions_per_million = NULLIF(@weekly_hosp_admissions_per_million, ''),
    iso_code = @iso_code,
    continent = @continent,
    location = @location,
    population = NULLIF(@population, ''),
    total_cases = NULLIF(@total_cases, ''),
    new_cases = NULLIF(@new_cases, ''),
    new_cases_smoothed = NULLIF(@new_cases_smoothed, ''),
    total_deaths = NULLIF(@total_deaths, ''),
    new_deaths = NULLIF(@new_deaths, ''),
    new_deaths_smoothed = NULLIF(@new_deaths_smoothed, ''),
    total_cases_per_million = NULLIF(@total_cases_per_million, ''),
    new_cases_per_million = NULLIF(@new_cases_per_million, ''),
    new_cases_smoothed_per_million = NULLIF(@new_cases_smoothed_per_million, ''),
    total_deaths_per_million = NULLIF(@total_deaths_per_million, ''),
    new_deaths_per_million = NULLIF(@new_deaths_per_million, ''),
    new_deaths_smoothed_per_million = NULLIF(@new_deaths_smoothed_per_million, ''),
    reproduction_rate = NULLIF(@reproduction_rate, ''),
    icu_patients = NULLIF(@icu_patients, ''),
    icu_patients_per_million = NULLIF(@icu_patients_per_million, ''),
    hosp_patients = NULLIF(@hosp_patients, ''),
    hosp_patients_per_million = NULLIF(@hosp_patients_per_million, ''),
    weekly_icu_admissions = NULLIF(@weekly_icu_admissions, ''),
    weekly_icu_admissions_per_million = NULLIF(@weekly_icu_admissions_per_million, ''),
    weekly_hosp_admissions = NULLIF(@weekly_hosp_admissions, ''),
    weekly_hosp_admissions_per_million = NULLIF(@weekly_hosp_admissions_per_million, '');

SELECT count(*) FROM coviddeaths;


LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.2\\Uploads\\CovidVaccinations.csv"
INTO TABLE CovidVaccinations
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@iso_code, @continent, @location, @date, @new_tests, @total_tests, @total_tests_per_thousand, 
 @new_tests_per_thousand, @new_tests_smoothed, @new_tests_smoothed_per_thousand, 
 @positive_rate, @tests_per_case, @tests_units, @total_vaccinations, @people_vaccinated, 
 @people_fully_vaccinated, @new_vaccinations, @new_vaccinations_smoothed, 
 @total_vaccinations_per_hundred, @people_vaccinated_per_hundred, 
 @people_fully_vaccinated_per_hundred, @new_vaccinations_smoothed_per_million, 
 @stringency_index, @population_density, @median_age, @aged_65_older, @aged_70_older, 
 @gdp_per_capita, @extreme_poverty, @cardiovasc_death_rate, @diabetes_prevalence, 
 @female_smokers, @male_smokers, @handwashing_facilities, @hospital_beds_per_thousand, 
 @life_expectancy, @human_development_index)
SET 
    date = STR_TO_DATE(@date, '%d-%m-%Y'),
    new_tests = NULLIF(@new_tests, ''),
    iso_code = @iso_code,
    continent = @continent,
    location = @location,
    total_tests = NULLIF(@total_tests, ''),
    total_tests_per_thousand = NULLIF(@total_tests_per_thousand, ''),
    new_tests_per_thousand = NULLIF(@new_tests_per_thousand, ''),
    new_tests_smoothed = NULLIF(@new_tests_smoothed, ''),
    new_tests_smoothed_per_thousand = NULLIF(@new_tests_smoothed_per_thousand, ''),
    positive_rate = NULLIF(@positive_rate, ''),
    tests_per_case = NULLIF(@tests_per_case, ''),
    total_vaccinations = NULLIF(@total_vaccinations, ''),
    people_vaccinated = NULLIF(@people_vaccinated, ''),
    people_fully_vaccinated = NULLIF(@people_fully_vaccinated, ''),
    new_vaccinations = NULLIF(@new_vaccinations, ''),
    new_vaccinations_smoothed = NULLIF(@new_vaccinations_smoothed, ''),
    total_vaccinations_per_hundred = NULLIF(@total_vaccinations_per_hundred, ''),
    people_vaccinated_per_hundred = NULLIF(@people_vaccinated_per_hundred, ''),
    people_fully_vaccinated_per_hundred = NULLIF(@people_fully_vaccinated_per_hundred, ''),
    new_vaccinations_smoothed_per_million = NULLIF(@new_vaccinations_smoothed_per_million, ''),
    stringency_index = NULLIF(@stringency_index, ''),
    population_density = NULLIF(@population_density, ''),
    median_age = NULLIF(@median_age, ''),
    aged_65_older = NULLIF(@aged_65_older, ''),
    aged_70_older = NULLIF(@aged_70_older, ''),
    gdp_per_capita = NULLIF(@gdp_per_capita, ''),
    extreme_poverty = NULLIF(@extreme_poverty, ''),
    cardiovasc_death_rate = NULLIF(@cardiovasc_death_rate, ''),
    diabetes_prevalence = NULLIF(@diabetes_prevalence, ''),
    female_smokers = NULLIF(@female_smokers, ''),
    male_smokers = NULLIF(@male_smokers, ''),
    handwashing_facilities = NULLIF(@handwashing_facilities, ''),
    hospital_beds_per_thousand = NULLIF(@hospital_beds_per_thousand, ''),
    life_expectancy = NULLIF(@life_expectancy, ''),
    human_development_index = NULLIF(@human_development_index, '');





select  * from coviddeaths order by 3,4;


select  * from CovidVaccinations order by 3,4;

select count(*) from covidvaccinations;

select Location,date,total_cases,new_cases,total_deaths,population
from coviddeaths order by 1,2;


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From coviddeaths WHERE location like '%states%'
order by 1,2;


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From coviddeaths
order by 1,2;


-- Highest Infection rate compare to population
select Location,population,max(total_cases) as HighestInfectionCount, max((total_cases/population))*100
as PercentPopulationInfected
from coviddeaths
group by Location,population
order by PercentPopulationInfected desc;



-- SHowing countries with highest death count per population

Select Location, MAX(Total_deaths) as TotalDeathCount
From coviddeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc;


-- Showing contintents with the highest death count per population

Select continent, MAX(Total_deaths) as TotalDeathCount
From coviddeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc


-- Total population vs vaccination
-- joining both tables 
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations
from coviddeaths cd join CovidVaccinations cv on 
cd.location=cv.location and cd.date=cv.date
where cd.continent is not null 
order by 2,3;


--  SAME with adding partition by
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location,cd.date) as TotalPeopleVaccination
from coviddeaths cd join CovidVaccinations cv on 
cd.location=cv.location and cd.date=cv.date
where cd.continent is not null 
order by 2,3;


-- How many people in that country are vaccinated
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location,cd.date) as TotalPeopleVaccination
-- (TotalPeopleVaccination/population)       ----> we cannot use column that is just created by us to use it we use CTE
from coviddeaths cd join CovidVaccinations cv on 
cd.location=cv.location and cd.date=cv.date
where cd.continent is not null 
order by 2,3;


-- Using CTE to perform Calculation on Partition By in previous query
with popvacc(Continent, Location, Date, Population, New_Vaccinations, TotalPeopleVaccination)
as(
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location,cd.date) as TotalPeopleVaccination     
from coviddeaths cd join CovidVaccinations cv on 
cd.location=cv.location and cd.date=cv.date
where cd.continent is not null 
)
select *,(TotalPeopleVaccination/population)*100 from popvacc;




-- Creating Temp table
-- DROP Table if exists PopulationVaccinatedPercentage
Create Table PopulationVaccinatedPercentage
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
TotalPeopleVaccination numeric
)

insert INTO PopulationVaccinatedPercentage
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location,cd.date) as TotalPeopleVaccination     
from coviddeaths cd join CovidVaccinations cv on 
cd.location=cv.location and cd.date=cv.date
where cd.continent is not null 

select *,(TotalPeopleVaccination/population)*100 as Percentage_Of_Vaccinated_People from PopulationVaccinatedPercentage;



-- 
-- Creating a View

create View PercentPopVacc as 
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location,cd.date) as TotalPeopleVaccination     
from coviddeaths cd join CovidVaccinations cv on 
cd.location=cv.location and cd.date=cv.date
where cd.continent is not null ;

select * from PercentPopVacc;
