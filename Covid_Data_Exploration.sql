--First create a table with data we want to use throughout this project
WITH working_tbl AS (
	SELECT location, date, total_cases :: float, new_cases, total_deaths :: float, population
	FROM deaths
	WHERE continent IS NOT NULL
	ORDER BY 1,2)

--Shows likelihood of dying from Covid in the United States
SELECT location, date, total_cases, total_deaths, total_deaths/total_cases AS chance_of_death
FROM working_tbl
WHERE location like 'United States'
ORDER BY 2

--Show percentage of people with Covid in the United States
SELECT date, population, total_cases, total_cases/population AS infection_rate
FROM working_tbl
WHERE location LIKE 'United States'
ORDER BY 1

--Average rate of infection per country
SELECT location, AVG(total_cases/population) infection_rate
FROM working_tbl
GROUP BY 1
HAVING AVG(total_cases/population) IS NOT NULL
ORDER BY 1

--Countries with highest peak infection rate
SELECT location, MAX(total_cases/population) infection_rate
FROM working_tbl
GROUP BY 1
HAVING AVG(total_cases/population) IS NOT NULL
ORDER BY 2 desc

--Countries with highest peak Covid death rate per population
SELECT location, MAX(total_deaths/population) covid_death_rate
FROM working_tbl
GROUP BY 1
HAVING MAX(total_deaths/population) IS NOT NULL
ORDER BY 2 desc
