-- US House Income Section Data Cleaning


Select *
From us_household_income
;

Select *
From us_household_income_statistics
;

-- ALTER TABLE us_household_income_statistics RENAME COLUMN ï»¿id to id ;

Select Count(id)
From us_household_income
;

Select Count(id)
From us_household_income_statistics
;

-- missing roughly 230 rows of data out of 32200

Select id, Count(id)
From us_household_income
Group by id
Having Count(id) > 1
;


Select row_id
From (
		Select row_id,
				id,
				Row_Number() Over(Partition by id ORDER BY id) row_num
				From us_household_income
) duplicates
Where row_num > 1 
;


DELETE FROM us_household_income
Where row_id In (
	Select row_id
	From (
			Select row_id,
				id,
				Row_Number() Over(Partition by id ORDER BY id) row_num
				From us_household_income
		) duplicates
	Where row_num > 1)
	;



Select id, Count(id)
From us_household_income_statistics
Group by id
Having Count(id) > 1
;

-- Removed duplicates in both datasets


Select Distinct State_Name
From us_household_income
Order by State_Name
;

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;


Select *
From us_household_income
;

Select Distinct State_ab
From us_household_income
Order by 1
;

Select *
From us_household_income
Where Place = ''
Order by 1
;

UPDATE us_household_income
SET Place = 'Autaugaville'
Where County = 'Autauga County'
AND City = 'Vinemont'
;


Select Type, Count(Type)
From us_household_income
Group by Type
;


UPDATE us_household_income
SET Type = 'Borough'
Where Type = 'Boroughs' 
;

UPDATE us_household_income
SET Type = 'CDP'
Where Type = 'CPD' 
;

Select 	ALand, AWater
From us_household_income
Where AWater = 0 OR AWater = '' OR AWater IS NULL
;


Select ALand, AWater
From us_household_income
Where ALand = 0 OR ALand = '' OR ALand IS NULL
;



-- US Household Income EDA


Select State_Name, SUM(ALand), SUM(AWater)
From us_household_income
Group BY State_Name
Order By 3 desc
LIMIT 10
;

Select *
From us_household_income_statistics;


SELECT State_Name, SUM(ALand) AS Total_Land
FROM us_household_income
GROUP BY State_Name
ORDER BY Total_Land DESC
LIMIT 10;


SELECT State_Name,
       SUM(AWater) AS Total_Water,
       SUM(ALand) AS Total_Land,
       ROUND(SUM(AWater) / NULLIF(SUM(ALand), 0), 4) AS Water_to_Land_Ratio
FROM us_household_income
GROUP BY State_Name
ORDER BY Water_to_Land_Ratio DESC
LIMIT 10;


Select *
From us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
Where Mean <> 0;




Select u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
From us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
Where Mean <> 0
GROUP BY u.State_Name
Order by 3 DESC
LIMIT 10
;


Select Type, Count(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
From us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
Where Mean <> 0
GROUP BY Type
Having Count(Type) > 100
Order by 4 DESC
LIMIT 10
;


Select *
From us_household_income
Where Type = 'Community';



Select u.State_Name, City, Round(Avg(Mean),1)
From us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
Where Mean <> 0
Group by u.State_Name, City
order by 3 Desc;




