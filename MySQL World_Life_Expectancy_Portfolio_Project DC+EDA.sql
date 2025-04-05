# World Life Expectancy Project (Data Cleaning)


SELECT * 
FROM world_life_expectancy.world_life_expectancy;



SELECT Country, Year, CONCAT(Country,Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
Group by Country, Year, Concat(Country,Year)
Having count(concat(Country,Year)) > 1;


Select *
From (
    Select Row_ID,
	CONCAT(Country,Year),
	ROW_NUMBER() OVER( Partition by CONCAT(Country,Year) ORDER BY CONCAT(Country,Year)) as Row_Num
	From world_life_expectancy
) AS Row_Table
Where Row_Num > 1
;

DELETE FROM world_life_expectancy
Where 
	Row_ID IN (
	Select Row_ID
From (
	Select Row_ID,
	CONCAT(Country,Year),
	ROW_NUMBER() OVER( Partition by CONCAT(Country,Year) ORDER BY CONCAT(Country,Year)) as Row_Num
	From world_life_expectancy
) AS Row_Table
Where Row_Num > 1
)
;

-- Duplicates were removed, 3 rows were found and affected



Select *
From world_life_expectancy
Where Status = ''
;



Select DISTINCT(Status)
From world_life_expectancy
Where Status <> ''
;

Select DISTINCT(Country)
From world_life_expectancy
Where Status = 'Developing'
;


UPDATE world_life_expectancy
SET STATUS = 'Developing'
WHERE Country IN (Select Distinct(Country)
		From world_life_expectancy
		WHERE Status = 'Developing');
        
        
        
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.STATUS = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing'
;

-- 7 rows were affected

Select *
From world_life_expectancy
Where Country = 'United States of America'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.STATUS = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed'
;

-- 1 row affected
    
Select *
From world_life_expectancy
Where Status IS NULL
;

Select Country, Year, `Life expectancy`
From world_life_expectancy
WHERE `Life expectancy` = ''
;


Select t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
From world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.YEAR = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.YEAR = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;



UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.YEAR = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.YEAR = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;


Select *
From world_life_expectancy
-- WHERE `Life expectancy` = ''
;


# World Life Expectancy Project Part 2 (Exploratory Data Analysis)



Select *
From world_life_expectancy
;


Select Country,
MAX(`Life expectancy`), 
MIN(`Life expectancy`),
round(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
From world_life_expectancy
group by Country
Having MIN(`Life expectancy`) <> 0 AND MAX(`Life expectancy`) <> 0
Order by Life_Increase_15_Years desc
;




Select Year, round(AVG(`Life expectancy`),2)
From world_life_expectancy
Where (`Life expectancy`) <> 0 
AND (`Life expectancy`) <> 0
Group by Year 
Order by Year desc
;



Select *
From world_life_expectancy
;



Select Country, round(AvG(`Life expectancy`),1) as Life_Exp, round(Avg(GDP),1) as GDP
From world_life_expectancy
group by country
HAVING Life_Exp > 0
AND GDP > 0
order by GDP DESC
;



SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE  0 END) High_GDP_Count,
round(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END),1) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE  0 END) Low_GDP_Count,
round(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END),1) Low_GDP_Life_Expectancy
From world_life_expectancy
;



Select *
From world_life_expectancy
;


Select Status,Count(Distinct Country), round(Avg(`Life expectancy`),1)
From world_life_expectancy
Group By Status
;



Select Country, round(AvG(`Life expectancy`),1) as Life_Exp, round(Avg(bmi),1) as BMI
From world_life_expectancy
group by country
HAVING Life_Exp > 0
AND BMI > 0
order by BMI DESC
;



Select Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER (Partition By Country ORDER BY Year desc) As Rolling_Total
From world_life_expectancy
WHERE Country LIKE '%United%'
;





























