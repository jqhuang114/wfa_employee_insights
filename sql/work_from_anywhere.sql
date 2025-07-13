-- avg. job satisfaction per work arrangement
SELECT remote_flexibility,
    ROUND(AVG(job_satisfaction),2) AS avg_satisfaction,
    COUNT(*) AS sample_size
FROM portfolio_projects.work_from_anywhere
GROUP BY remote_flexibility
ORDER BY avg_satisfaction DESC;

-- Avg. job satisfaction per perk
SELECT perks,
    ROUND(AVG(job_satisfaction),2) AS avg_satisfaction,
    COUNT(*) AS sample_size
FROM portfolio_projects.work_from_anywhere
GROUP BY perks
ORDER BY avg_satisfaction DESC;

-- Avg. promotion cycle per job satisfaction
SELECT job_satisfaction,
    ROUND(AVG(years_since_last_promotion),2) AS avg_promotion_cycle,
    COUNT(*) AS sample_size
FROM portfolio_projects.work_from_anywhere
GROUP BY job_satisfaction
ORDER BY job_satisfaction DESC;

-- Avg. salary, median and job satisfaction by experience level
WITH row_num AS(
	SELECT experience_level,
	job_satisfaction,
	annual_salary,
    ROW_NUMBER() OVER(
		PARTITION BY experience_level,
			job_satisfaction
        ORDER BY annual_salary
	) AS row_asc,
    ROW_NUMBER() OVER(
		PARTITION BY experience_level,
			job_satisfaction
        ORDER BY annual_salary DESC
	) AS row_desc
	FROM portfolio_projects.work_from_anywhere
    WHERE currency = 'USD'
	ORDER BY experience_level,
		job_satisfaction DESC,
		annual_salary
),

job_satisfaction_median AS(
	SELECT experience_level,
		job_satisfaction,
		ROUND(AVG(annual_salary),0) AS median
	FROM row_num
	WHERE ABS(CAST(row_asc AS SIGNED) - CAST(row_desc AS SIGNED)) <= 1
	GROUP BY experience_level,
		job_satisfaction
)

SELECT wfa.experience_level,
	wfa.job_satisfaction,
    ROUND(AVG(wfa.annual_salary),0) AS avg_salary,
    jsm.median,
    COUNT(*) AS sample_size
FROM portfolio_projects.work_from_anywhere wfa
JOIN job_satisfaction_median jsm
	ON wfa.experience_level = jsm.experience_level
    AND wfa.job_satisfaction = jsm.job_satisfaction
WHERE wfa.currency = 'USD'
GROUP BY wfa.experience_level,
	wfa.job_satisfaction
ORDER BY experience_level,
	wfa.job_satisfaction DESC;

-- avg. salary and median by industry and years of experience
WITH main_data AS (
SELECT industry,
    CASE
		WHEN years_of_experience >= 0 AND years_of_experience < 3 THEN '0-3'
        WHEN years_of_experience >= 3 AND years_of_experience < 6 THEN '3-6'
        WHEN years_of_experience >= 6 AND years_of_experience < 9 THEN '6-9'
        WHEN years_of_experience >= 9 AND years_of_experience < 12 THEN '9-12'
        WHEN years_of_experience >= 12 AND years_of_experience < 15 THEN '12-15'
        ELSE '15+'
	END AS yrs_experience_buckets,
    annual_salary
FROM portfolio_projects.work_from_anywhere
WHERE currency = 'USD'
),

rankings AS (
    SELECT industry,
		yrs_experience_buckets,
        annual_salary,
    ROW_NUMBER() OVER(
		PARTITION BY industry, yrs_experience_buckets
        ORDER BY annual_salary
	) AS row_asc,
    ROW_NUMBER() OVER(
		PARTITION BY industry, yrs_experience_buckets
        ORDER BY annual_salary DESC
	) AS row_desc
	FROM main_data
),

industry_exp_median AS(
	SELECT industry,
		yrs_experience_buckets,
		ROUND(AVG(annual_salary),0) AS median
	FROM rankings
	WHERE ABS(CAST(row_asc AS SIGNED) - CAST(row_desc AS SIGNED)) <= 1
	GROUP BY industry,
		yrs_experience_buckets
)

SELECT md.industry,
	md.yrs_experience_buckets,
    ROUND(AVG(md.annual_salary),0) AS avg_salary,
    iem.median,
    COUNT(*) AS sample_size
FROM main_data md
JOIN industry_exp_median iem
	ON md.industry = iem.industry
    AND md.yrs_experience_buckets = iem.yrs_experience_buckets
GROUP BY md.industry,
	md.yrs_experience_buckets
ORDER BY md.industry,
	md.yrs_experience_buckets;

-- tech skills by salary
WITH skills_split AS (
	SELECT TRIM(SUBSTRING(tech_skills, 1, LOCATE(',', tech_skills)-1)) AS skill_1,
		TRIM(SUBSTRING(tech_skills, LOCATE(',', tech_skills)+1, LENGTH(tech_skills))) AS skill_2,
		annual_salary
	FROM portfolio_projects.work_from_anywhere
    WHERE currency = 'USD'
),

all_skills AS (
	SELECT skill_1 AS skill_type, annual_salary FROM skills_split
	UNION ALL
	SELECT skill_2 AS skill_type, annual_salary FROM skills_split
),

skills_rank AS (
    SELECT skill_type,
        annual_salary,
    ROW_NUMBER() OVER(
		PARTITION BY skill_type
        ORDER BY annual_salary
	) AS row_asc,
    ROW_NUMBER() OVER(
		PARTITION BY skill_type
        ORDER BY annual_salary DESC
	) AS row_desc
	FROM all_skills
),

skill_median AS(
	SELECT skill_type,
		ROUND(AVG(annual_salary),0) AS median
	FROM skills_rank
	WHERE ABS(CAST(row_asc AS SIGNED) - CAST(row_desc AS SIGNED)) <= 1
	GROUP BY skill_type
)

SELECT als.skill_type,
	ROUND(AVG(als.annual_salary),0) AS avg_salary,
    sm.median,
    COUNT(*) AS sample_size
FROM all_skills als
JOIN skill_median sm
	ON als.skill_type = sm.skill_type
GROUP BY als.skill_type
ORDER BY avg_salary DESC;