Project Workflow
  Data Extraction and Cleaning (SQL Queries)
  Extracted relevant data fields such as location, date, total cases, total deaths, population, and vaccinations.
  Filtered out null or irrelevant data (e.g., locations with missing values).
  Used aggregate functions to determine total cases, deaths, and vaccinations globally and by continent.
  Created CTEs, temp tables, and views for advanced calculations.

Key SQL Queries Used:
  Total cases vs. total deaths → Probability of dying from COVID per country
  Total cases vs. population → Percentage of population infected per country
  Highest infection rate per country → Countries most impacted by COVID
  Highest death count per continent → Continents most affected by COVID deaths
  Rolling vaccinations → Tracking vaccination progress per country

Data Transformation & Preparation (Excel)
  Converted SQL query results into Excel files for Tableau upload.
  Formatted date columns correctly to ensure compatibility in Tableau.
  Replaced NULL values with 0 to maintain data integrity.

Data Visualization (Tableau Public)
Created multiple Tableau visualizations to showcase insights:

Global Numbers Table
  Displays total cases, total deaths, and death percentage globally.
  Key insight: Global death percentage stood at 2.11% as of March 2021.
Total Deaths per Continent
  Europe had the highest death toll, followed by North America and South America.
  Africa and Oceania had the lowest recorded deaths.
Percent Population Infected per Country (Map)
  Heatmap with an orange gradient visualizing infection rates per country.
  Countries like USA, Brazil, UK, and Russia had high infection rates.
  China reported very low infection rates, possibly due to underreporting.
Percent Population Infected Over Time (Line Chart)
  Shows infection trends from March 2020 to September 2021 (forecasted).
  The United States had the highest projected infection rate (19.11%) by Sep 2021.
Percentage of Population Vaccinated (Rolling Vaccination Progress)
  Uses a cumulative sum function in SQL to calculate rolling vaccination rates.
  Key insight: Some countries reached over 50% vaccination, while others lagged behind.

Key Insights from the Analysis
  The United States, Brazil, and the UK had some of the highest infection rates per population.
  Europe and North America had the highest death counts, with Europe exceeding 1 million deaths.
  China reported an extremely low infection rate (potential underreporting or strict lockdown measures).
  COVID-19 vaccinations showed a steady increase, but not all countries progressed at the same rate.
  Forecasting projected a significant rise in infection rates post-March 2021, with the US reaching nearly 20% infection rate by September 2021.

