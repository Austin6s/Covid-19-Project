--First use CTE to create a table with data we want to use throughout this project
WITH working_tbl AS (
	SELECT location, date, total_cases :: float, new_cases, total_deaths :: float, population
	FROM deaths
	WHERE continent IS NOT NULL
	ORDER BY 1,2)

--Shows likelihood of dying from Covid in the world
SELECT MAX(total_cases) total_cases, MAX(total_deaths) total_deaths, CAST(MAX(total_deaths)/MAX(total_cases)*100 AS REAL) deathpercentage
FROM working_tbl
WHERE location LIKE 'United States'
ORDER BY 2
