--First create a table with data we want to use throughout this project
WITH working_tbl AS (
	SELECT location, date, total_cases, new_cases, total_deaths :: float, population
	FROM deaths
	ORDER BY 1,2)
	
--Shows likelihood of dying from Covid in the United States
SELECT location, date, total_cases, total_deaths, total_deaths/total_cases AS chance_of_death
FROM working_tbl
WHERE location like 'United States'
ORDER BY 2

--Show percentage of people with Covid in the United States
SELECT date, population, total_cases, total_cases/population
FROM working_tbl
WHERE location LIKE 'United States'
ORDER BY 1
