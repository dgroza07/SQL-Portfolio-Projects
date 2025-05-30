-- Automated Data Cleaning


Select *
From us_household_income;



DELIMITER $$
DROP PROCEDURE IF EXISTS Copy_and_Clean_Data;
CREATE PROCEDURE Copy_and_Clean_Data()
BEGIN 

	CREATE TABLE IF NOT EXISTS `us_household_income_Cleaned` (
	  `row_id` int DEFAULT NULL,
	  `id` int DEFAULT NULL,
	  `State_Code` int DEFAULT NULL,
	  `State_Name` text,
	  `State_ab` text,
	  `County` text,
	  `City` text,
	  `Place` text,
	  `Type` text,
	  `Primary` text,
	  `Zip_Code` int DEFAULT NULL,
	  `Area_Code` int DEFAULT NULL,
	  `ALand` int DEFAULT NULL,
	  `AWater` int DEFAULT NULL,
	  `Lat` double DEFAULT NULL,
	  `Lon` double DEFAULT NULL,
	  `TimeStamp` TIMESTAMP DEFAULT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
    
    -- COPY DATA TO NEW TABLE 
		INSERT INTO us_household_income_cleaned
		SELECT *, CURRENT_TIMESTAMP
        FROM us_household_income;
    
    -- Data Cleaning Steps
    
    -- 1. Remove Duplicates
	DELETE FROM us_household_income_cleaned
	WHERE 
		row_id IN (
		SELECT row_id
	FROM (
		SELECT row_id, id,
			ROW_NUMBER() OVER (
				PARTITION BY id, `TimeStamp`
				ORDER BY id, `TimeStamp`) AS row_num
		FROM 
			us_household_income_cleaned
	) duplicates
	WHERE 
		row_num > 1
	);

	-- 2. Standardization
	UPDATE us_household_income_cleaned
	SET State_Name = 'Georgia'
	WHERE State_Name = 'georia';

	UPDATE us_household_income_cleaned
	SET County = UPPER(County);

	UPDATE us_household_income_cleaned
	SET City = UPPER(City);

	UPDATE us_household_income_cleaned
	SET Place = UPPER(Place);

	UPDATE us_household_income_cleaned
	SET State_Name = UPPER(State_Name);

	UPDATE us_household_income_cleaned
	SET `Type` = 'CDP'
	WHERE `Type` = 'CPD';

	UPDATE us_household_income_cleaned
	SET `Type` = 'Borough'
	WHERE `Type` = 'Boroughs';
    
    
END $$
DELIMITER ;

CALL Copy_and_Clean_Data();


-- CONFIRMATION IF SP WORKS
		SELECT row_id, id, row_num
	FROM (
		SELECT row_id, id,
			ROW_NUMBER() OVER (
				PARTITION BY id
				ORDER BY id) AS row_num
		FROM 
			us_household_income_cleaned
	) duplicates
	WHERE 
		row_num > 1;

SELECT COUNT(row_id) 
From us_household_income_cleaned; 

SELECT State_Nmae, COUNT(State_Name) 
From us_household_income_cleaned
Group BY State_Name; 


-- CREATE EVENT 

DROP Event run_data_cleaning;
Create Event run_data_cleaning
	ON SCHEDULE EVERY 30 DAY
    DO CALL Copy_and_Clean_Data();




-- CREATE TRIGGER

Delimiter $$
CREATE TRIGGER Transfer_clean_data
	AFTER INSERT ON us_household_income
    For Each Row
Begin
	CALL Copy_and_Clean_Data();
End $$
DELIMITER ;


INSERT INTO us_household_income
(`row_id`, `id`, `State_Code`, `State_Name`, `State_ab`, `County`, `City`, `Place`, `Type`, `Primary`, `Zip_Code`, `Area_Code`, `ALand`, `AWater`, `Lat`, `Lon`)
VALUES
(121671,37025904, 7,'North Carolina','NC','Alamance County','Charlotte','Alamance','Track','Track',28215,980,24011255,98062070,35.2661197,-80.6865346);





















































































