SELECT * FROM covid_data.coviddeaths;

-- 1.	Retrieve the total number of cases for each location:
SELECT COUNT(location) 
AS Total_No_Cases, location 
FROM coviddeaths GROUP BY location
limit 15;

-- 2.	Calculate the average number of new cases per day for each continent:
SELECT continent, AVG(new_cases) 
AS New_Cases_Per_Day 
FROM coviddeaths GROUP BY continent;

-- 3.	Find the dates with the highest number of total deaths globally:
SELECT date, total_deaths 
FROM coviddeaths 
WHERE total_deaths = (SELECT MAX(total_deaths) 
FROM coviddeaths)
limit 3;

-- 4.	Calculate the total number of cases per million people for a specific date and continent
SELECT date, continent, (total_cases / (population / 1000000)) AS cases_per_million
FROM coviddeaths
WHERE date = '2020-07-01' AND continent = 'Africa';

-- 5.	Determine the average reproduction rate for each continent
SELECT continent, avg(reproduction_rate) AS Average_Reproduction_Rate
FROM coviddeaths
group by continent
order by Average_Reproduction_Rate desc
limit 10;

-- 6.	Retrieve the top 10 locations with the highest population
SELECT location, MAX(population) AS highest_population
FROM coviddeaths
GROUP BY location
ORDER BY highest_population DESC
LIMIT 10;



-- 7.	Find the date range for which data is available in the dataset
SELECT MIN(date) AS start_date, MAX(date) AS end_date
FROM coviddeaths;

-- 8.	Retrieve the top 5 locations with the highest total deaths
SELECT location, SUM(total_deaths) AS total_deaths
FROM coviddeaths
GROUP BY location
ORDER BY total_deaths desc
LIMIT 10;

-- 9.	Find the dates with the highest number of new cases by Continent
SELECT location, continent, (new_cases) AS highest_new_cases
FROM coviddeaths
ORDER BY location
between 352991 and 401993
limit 100;

SELECT continent, new_cases, date
FROM coviddeaths
WHERE (continent, new_cases) 
in (SELECT continent, MAX(new_cases)
    FROM coviddeaths
    GROUP BY continent);

SELECT MAX(total_deaths) AS highest_deaths, continent
FROM (
    SELECT continent, SUM(total_deaths) AS total_deaths
    FROM coviddeaths
    GROUP BY continent, date
) AS continent_cases
GROUP BY continent
ORDER BY highest_deaths DESC;

SELECT min(total_deaths) AS highest_deaths, continent
FROM (
    SELECT continent, SUM(total_deaths) AS total_deaths
    FROM coviddeaths
    GROUP BY continent, date
) AS continent_cases
GROUP BY continent
ORDER BY highest_deaths asc;


-- 10.	Calculate the average number of new cases per day
SELECT AVG(new_cases) as Average_New_cases_Per_Day
FROM coviddeaths;

-- 11.	Retrieve the total number of cases and deaths for locations
SELECT location AS Location_Name, SUM(total_cases) AS total_cases, SUM(total_deaths) AS total_deaths
FROM coviddeaths
GROUP BY location;

-- 12.	Determine the continent with the highest total cases
SELECT continent, SUM(total_cases) AS total_cases
FROM coviddeaths
GROUP BY continent;

-- 13.	Find the date range for which data is available in the dataset
SELECT MAX(date) AS start_date, MIN(date) AS end_date, location as Location_Name
FROM coviddeaths
group by location;

-- 14.	Retrieve the top 5 locations with the highest total deaths
SELECT location, SUM(total_deaths) AS total_deaths
FROM coviddeaths
GROUP BY location
ORDER BY total_deaths DESC
limit 10;

-- Find Locations with the low population
SELECT location, min(population) AS low_population
FROM coviddeaths
GROUP BY location
ORDER BY low_population asc
LIMIT 10;

-- Find the dates with the highest number of total deaths by Location
SELECT date, location, total_deaths
FROM coviddeaths
WHERE (location, total_deaths) IN 
(SELECT location, MAX(total_deaths)
    FROM coviddeaths
    GROUP BY location)
    limit 5;
    
-- Maximum Reproduction rate by Location
SELECT location, max(reproduction_rate) AS Max_Reproduction_Rate
FROM coviddeaths
group by location
order by Max_Reproduction_Rate desc
limit 5;

-- Minimum Reproduction rate by location
SELECT location, min(reproduction_rate) AS Min_Reproduction_Rate
FROM coviddeaths
group by location
order by location asc
limit 10;

SELECT location, COUNT(*) AS total_count
FROM coviddeaths
GROUP BY location;

-- Locations with the Highest Cases
SELECT location, SUM(total_cases) AS Highest_Cases
FROM coviddeaths
GROUP BY location
ORDER BY Highest_Cases DESC
limit 7;

-- Locations with the Lowest Cases
SELECT location, sum(total_cases) AS Lowest_Cases
FROM coviddeaths
GROUP BY location
ORDER BY Lowest_Cases asc
limit 7;

-- Locations with the Highest death 
SELECT location, sum(total_deaths) AS Highest_Death
FROM coviddeaths
GROUP BY location
ORDER BY Highest_Death desc
limit 7;

-- Locations with the Lowest death
SELECT location, sum(total_deaths) AS Lowest_Death
FROM coviddeaths
GROUP BY location
ORDER BY Lowest_Death asc
limit 20;

-- Find the locations with the highest patients in the Hospital
select location, sum(hosp_patients) as Highest_Patients_Hospital
from coviddeaths
group by location
order by Highest_Patients_Hospital desc
limit 10;

-- Locations with the Lowest Patients in the Hospital
select location, sum(hosp_patients) as Lowest_Patients_Hospital
from coviddeaths
group by location
order by Lowest_Patients_Hospital asc
limit 40;

-- How does the total number of ICU patients vary across different continents?
SELECT continent, SUM(icu_patients) AS total_icu_patients
FROM coviddeaths
GROUP BY continent;

-- How does the total number of Reproduction Rate vary across different continents?
SELECT continent, sum(reproduction_rate) AS total_reproduction_rate
FROM coviddeaths
GROUP BY continent;

-- How does the total number of weekly_hosp_admissions vary across different continents?
SELECT continent, sum(weekly_hosp_admissions) AS total_weekly_hosp_admissions
FROM coviddeaths
GROUP BY continent;

-- Are there any significant spikes in new cases or new deaths smoothed per million people?
SELECT date, new_cases_smoothed_per_million, new_deaths_smoothed_per_million
FROM coviddeaths
WHERE new_cases_smoothed_per_million > (SELECT AVG(new_cases_smoothed_per_million) + (2 * STDDEV(new_cases_smoothed_per_million)) FROM coviddeaths)
   or new_deaths_smoothed_per_million > (SELECT AVG(new_deaths_smoothed_per_million) + (2 * STDDEV(new_deaths_smoothed_per_million)) FROM coviddeaths)
   limit 20;
   
   -- What is the average number of new cases per million people for a specific continent?
   SELECT continent, AVG(new_cases_per_million) AS average_new_cases_per_million
FROM coviddeaths
GROUP BY continent;