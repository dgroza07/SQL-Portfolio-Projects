
# 🧼 Automated Data Cleaning in MySQL with Stored Procedures, Triggers, and Events

**Author:** Daniel Groza  
**Date:** May 19, 2025  
**Tools Used:** MySQL, Stored Procedures, Triggers, Event Scheduler, Window Functions  

---

## 📌 Project Overview

This project automates the data cleaning process for a large **U.S. Household Income dataset** using advanced SQL features. The dataset contains over **32,000 rows** with multiple columns representing geographic and income-related attributes across U.S. states, counties, and cities.

The goal was to **automate data quality checks** using **only SQL**, removing the need for manual intervention or third-party tools.

---

## 🧠 Key Concepts Applied

- **Stored Procedures**: Encapsulate data cleaning logic for reuse.
- **Triggers**: Automatically clean data immediately after it's inserted.
- **Events**: Schedule recurring clean-up jobs every 30 days.
- **Window Functions**: Identify and remove duplicate records.
- **Data Standardization**: Normalize inconsistent text formats and value entries.

---

## ⚙️ Technical Steps

### 1. 🔄 Create a Cleaned Table
Used `CREATE TABLE IF NOT EXISTS` to build a cleaned table with the same schema as the original.

```sql
CREATE TABLE IF NOT EXISTS us_household_income_cleaned (...);
```

---

### 2. 🧪 Copy & Timestamp Raw Data
Copied data from `us_household_income` while appending the current timestamp.

```sql
INSERT INTO us_household_income_cleaned
SELECT *, CURRENT_TIMESTAMP FROM us_household_income;
```

---

### 3. 🚫 Remove Duplicates
Removed duplicates based on `id` and `TimeStamp` using `ROW_NUMBER()`.

```sql
DELETE FROM us_household_income_cleaned
WHERE row_id IN (
  SELECT row_id FROM (
    SELECT row_id, ROW_NUMBER() OVER (PARTITION BY id, TimeStamp ORDER BY id) AS row_num
    FROM us_household_income_cleaned
  ) duplicates
  WHERE row_num > 1
);
```

---

### 4. ✨ Data Standardization
Normalized inconsistent entries:

- Capitalized `State_Name`, `City`, `County`, `Place`
- Replaced inconsistent values like `'CPD'` → `'CDP'`, `'Boroughs'` → `'Borough'`

```sql
UPDATE us_household_income_cleaned SET State_Name = UPPER(State_Name);
UPDATE us_household_income_cleaned SET Type = 'CDP' WHERE Type = 'CPD';
```

---

### 5. 🛠 Stored Procedure
Packaged the entire process into a reusable stored procedure:

```sql
CALL Copy_and_Clean_Data();
```

---

### 6. 🗓 Scheduled Event
Automated the process to run every 30 days:

```sql
CREATE EVENT run_data_cleaning
ON SCHEDULE EVERY 30 DAY
DO CALL Copy_and_Clean_Data();
```

---

### 7. 🧲 Trigger on Insert
Automatically cleans new data upon insertion into the original table:

```sql
CREATE TRIGGER Transfer_clean_data
AFTER INSERT ON us_household_income
FOR EACH ROW
CALL Copy_and_Clean_Data();
```

---

## ✅ Benefits

- 💡 Fully **automated ETL pipeline** using SQL-native features.
- 📉 Reduced duplicate entries using efficient **window functions**.
- 🔁 Enabled **real-time and scheduled** data maintenance.
- ⚙️ Improved **data consistency** for downstream analytics and visualization tools (e.g., Power BI, Tableau).

---

## 🔎 Sample Query Outputs

- Confirm duplicate removal:
```sql
SELECT row_id, id, ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
FROM us_household_income_cleaned
HAVING row_num > 1;
```

- Count records:
```sql
SELECT COUNT(row_id) FROM us_household_income_cleaned;
```

---

## 📚 Skills Demonstrated

- Advanced SQL (MySQL)
- Stored Procedures & Triggers
- ETL Automation
- Data Cleaning & Standardization
- Performance Optimization with Indexing

---

## 🏁 Conclusion

This project demonstrates practical MySQL automation skills for maintaining clean, reliable data pipelines. The use of **stored procedures, triggers, and events** makes the pipeline **scalable**, **production-ready**, and **hands-free**, showing proficiency in **data engineering fundamentals**.

---
