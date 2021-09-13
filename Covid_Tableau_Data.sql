--First use CTE to create a table with data we want to use throughout this project
WITH working_tbl AS (
	SELECT location, date, total_cases :: float, new_cases, new_deaths, total_deaths :: float, population
	FROM deaths
	WHERE continent IS NOT NULL
	ORDER BY 1,2)

--Find death percentage for whole world
SELECT SUM(new_cases) total_cases, SUM(new_deaths) total_deaths, CAST(SUM(total_deaths)/SUM(total_cases)*100 AS REAL) deathpercentage
FROM working_tbl
