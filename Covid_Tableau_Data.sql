--TABLE 1
--First use CTE to create a table with data we want to use throughout this project
WITH working_tbl AS (
	SELECT location, date, total_cases :: float, new_cases, new_deaths, total_deaths :: float, population
	FROM deaths
	WHERE continent IS NOT NULL
	ORDER BY 1,2)

--Find death percentage for whole world
SELECT SUM(new_cases) total_cases, SUM(new_deaths) total_deaths, CAST(SUM(total_deaths)/SUM(total_cases)*100 AS REAL) deathpercentage
FROM working_tbl

--TABLE 2
--Edit working_tbl for the next query
WITH working_tbl2 AS (
	SELECT location, date, total_cases :: float, new_cases, new_deaths, total_deaths :: float, population
	FROM deaths
	WHERE continent IS NULL AND location NOT IN('International', 'European Union', 'World')
	ORDER BY 1,2)

--Total death count by continent
SELECT location, SUM(new_deaths) total_deaths
FROM working_tbl2
GROUP BY 1
ORDER BY 2 DESC

--TABLE 3
--Infection rate by country (eliminating nulls) (will use this one for Tableau)
SELECT location, population, MAX(total_cases) highest_inf_count, (CAST(MAX(total_cases) AS FLOAT)/CAST(population AS FLOAT)*100) :: REAL infection_rate
FROM deaths
WHERE continent IS NOT NULL
GROUP BY 1, 2
HAVING (CAST(MAX(total_cases) AS FLOAT)/CAST(population AS FLOAT)*100) :: REAL IS NOT NULL
ORDER BY 4 DESC

--Infection rate by country (converting null values to zero)
SELECT location, population, COALESCE(MAX(total_cases), 0) highest_inf_count, (CAST(COALESCE(MAX(total_cases), 0) AS FLOAT)/CAST(population AS FLOAT)*100) :: REAL infection_rate
FROM deaths
WHERE continent IS NOT NULL AND population IS NOT NULL
GROUP BY 1, 2
ORDER BY 4 DESC

--TABLE 4
--Infection rate by country per day (eliminating nulls) (will use this one for Tableau)
SELECT location, population, date, total_cases highest_inf_count, (CAST(MAX(total_cases) AS FLOAT)/CAST(population AS FLOAT)*100) :: REAL infection_rate
FROM deaths
WHERE continent IS NOT NULL
GROUP BY 1, 2, 3, 4
HAVING (CAST(MAX(total_cases) AS FLOAT)/CAST(population AS FLOAT)*100) :: REAL IS NOT NULL
ORDER BY 5 DESC
