-- Data Cleaning

SELECT *
FROM layoffs
;

-- STEPS
-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Recheck NULL and BLANK values
-- 4. Remove any unneccesary columns and rows


CREATE TABLE layoffs_staging
LIKE layoffs;


INSERT layoffs_staging
SELECT * 
FROM layoffs;


SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY 
	company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;

WITH duplicate_cte as 
(
SELECT *,
ROW_NUMBER() OVER( 
PARTITION BY 
	company, location, industry, total_laid_off, 
    percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SELECT * FROM layoffs_staging
WHERE company = 'Casper';