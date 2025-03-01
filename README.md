COVID-19 Data Analysis and Visualization

Overview

This project explores global COVID-19 trends using SQL for data extraction, transformation, and analysis, followed by Tableau Public for data visualization. The dataset includes COVID-19 case counts, deaths, vaccinations, and population data from various countries and continents, spanning from 2020 to 2021.

The project aims to uncover key insights related to infection rates, death percentages, and vaccination progress worldwide. Using SQL queries, I extracted meaningful insights, cleaned the data, and then visualized it using Tableau. The final dashboard presents these findings in an interactive and digestible format.

Link to Tableau Public: https://public.tableau.com/app/profile/daniel.groza8136/viz/shared/T5559HSJ8
![image](https://github.com/user-attachments/assets/51161fba-7602-4577-90c1-bd50a2037f7d)


1a. Project Workflow
  
  a. Data Extraction and Cleaning (SQL Queries)
 
  b. Extracted relevant data fields such as location, date, total cases, total deaths, population, and vaccinations.
  
  c. Filtered out null or irrelevant data (e.g., locations with missing values).
 
  d. Used aggregate functions to determine total cases, deaths, and vaccinations globally and by continent.
 
  e. Created CTEs, temp tables, and views for advanced calculations.

1b. Key SQL Queries Used:
  
  a. Total cases vs. total deaths → Probability of dying from COVID per country
  
  b. Total cases vs. population → Percentage of population infected per country
  
  c. Highest infection rate per country → Countries most impacted by COVID
  
  d. Highest death count per continent → Continents most affected by COVID deaths
 
  e. Rolling vaccinations → Tracking vaccination progress per country

2. Data Transformation & Preparation (Excel)
  
  a. Converted SQL query results into Excel files for Tableau upload.
  
  b. Formatted date columns correctly to ensure compatibility in Tableau.
  
  c. Replaced NULL values with 0 to maintain data integrity.

3. Data Visualization (Tableau Public)
   Created multiple Tableau visualizations to showcase insights:

a. Global Numbers Table
  
  --Displays total cases, total deaths, and death percentage globally.
  
  --Key insight: Global death percentage stood at 2.11% as of March 2021.

b. Total Deaths per Continent
  
  --Europe had the highest death toll, followed by North America and South America.
  
  --Africa and Oceania had the lowest recorded deaths.

c. Percent Population Infected per Country (Map)
  
  --Heatmap with an orange gradient visualizing infection rates per country.
  
  --Countries like USA, Brazil, UK, and Russia had high infection rates.
  
  --China reported very low infection rates, possibly due to underreporting.

d. Percent Population Infected Over Time (Line Chart)
  
  --Shows infection trends from March 2020 to September 2021 (forecasted).
  
  --The United States had the highest projected infection rate (19.11%) by Sep 2021.

e. Percentage of Population Vaccinated (Rolling Vaccination Progress)
  
  --Uses a cumulative sum function in SQL to calculate rolling vaccination rates.
  
  --Key insight: Some countries reached over 50% vaccination, while others lagged behind.


4. Key Insights from the Analysis
  
  a. The United States, Brazil, and the UK had some of the highest infection rates per population.
  
  b. Europe and North America had the highest death counts, with Europe exceeding 1 million deaths.
  
  c. China reported an extremely low infection rate (potential underreporting or strict lockdown measures).
  
  d. COVID-19 vaccinations showed a steady increase, but not all countries progressed at the same rate.
  
  e. Forecasting projected a significant rise in infection rates post-March 2021, with the US reaching nearly 20% infection rate by September 2021.

