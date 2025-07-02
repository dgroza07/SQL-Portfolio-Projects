# 🧠 Workforce Analytics Project (SQL + Power BI)

## 📌 Project Goal

The objective of this project is to analyze a fictional company's workforce data to uncover actionable insights regarding **employee distribution**, **diversity**, **hiring trends**, **tenure**, and **termination patterns**. 

Using **SQL** for data cleaning, preprocessing, and exploratory analysis, the project identifies key trends that influence business decisions around talent retention, diversity, and organizational risk. The cleaned and aggregated insights were then visualized in **Power BI** to create a 4-part executive dashboard.

---

## 🧼 Step 1 – Data Cleaning & Preprocessing

The original dataset contained inconsistencies across key fields, including:
- Irregular date formats in `birthdate`, `hire_date`, and `termdate`
- Null values and improperly encoded column headers (e.g., `ï»¿id`)
- Missing or ambiguous values in categorical fields

### ✅ Actions Taken:
- Standardized date formats using `STR_TO_DATE` and converted fields to `DATE` type
- Replaced empty `termdate` values with `NULL` for accuracy
- Created a derived `age` column using `TIMESTAMPDIFF()`
- Renamed key fields for clarity (`emp_id`, `termdate`, etc.)

---

## 🔍 Step 2 – Exploratory Data Analysis (SQL Views)

To enable modular and scalable analysis, I created **17+ SQL views** across the following categories:

### 🧬 Demographic Breakdown
- `v_gender_distribution`, `v_age_group_distribution`, `v_race_distribution`

### 🏢 Organizational Structure
- `v_gender_by_department`, `v_job_title_distribution`, `v_department_distribution`

### 📊 Tenure & Experience
- `v_avg_tenure_current`, `v_tenure_brackets_by_dept`, `v_time_to_turnover_by_jobtitle`

### 📉 Attrition & Termination
- `v_termination_rate_by_dept`, `v_attrition_by_gender_year`, `v_attrition_by_race_year`

### 🌎 Location-Based Analysis
- `v_employee_state_distribution`, `v_work_location_distribution`

### 🧠 Advanced Insights
- `v_high_risk_departments`, `v_hire_cohort_by_year`, `v_avg_tenure_terminated`

All views were designed with `WHERE termdate IS NULL` or `IS NOT NULL` conditions to isolate active vs. terminated employees. 

---

## 📈 Step 3 – Key Insights from SQL EDA

### 📌 Workforce Composition
- Males slightly outnumber females; non-conforming individuals are significantly underrepresented
- The majority of employees are between **25–44 years old**
- **75% of the workforce is on-site**; only 25% are remote

### 📌 Departmental Headcount & Location
- Engineering is the dominant department with over **5,500 employees**
- Primary workforce hubs are **Ohio, Pennsylvania, and Illinois**

### 📌 Tenure Trends
- Long-term employees (10–25+ years) dominate the workforce, especially in Engineering and Accounting
- Very few employees fall within the 0–5 year tenure bracket
- Hiring peaked in the early 2000s and steadily declined post-2010

### 📌 Termination Analysis
- Termination rates have dropped from 211 (2011) to 44 (2020)
- Auditing and Legal have **the highest termination rates** despite being among the smallest departments
- Gender and racial termination rates are fairly balanced

---

## ✅ Realistic Business Recommendations

1. **Audit High-Risk Departments**  
   Review workload and management practices in **Auditing and Legal**, as their high attrition relative to headcount may signal burnout or operational strain.

2. **Invest in Entry-Level Hiring**  
   The workforce is aging, with very few new hires in recent years. Strategic onboarding of younger talent would support succession planning and innovation.

3. **Evaluate Remote Work Strategy**  
   With 75% of employees still in-office, consider expanding remote opportunities to attract wider talent pools.

4. **DEI Strategy Enhancement**  
   While gender and race distributions are relatively even, **non-conforming gender representation** is minimal. Consider targeted inclusion efforts.

---

## 📊 Power BI Visualization & LinkedIn Summary

This report was fully visualized in **Power BI** across four dashboards:
1. **Workforce Demographics**
2. **Department & Location Distribution**
3. **Hiring & Tenure Trends**
4. **Termination Analysis**

Each dashboard was shared in a detailed **LinkedIn article**, with annotated visuals and recommended actions for business stakeholders.  
🔗 *(Link to LinkedIn Article – Coming Soon)*

---

## 🧠 Tools Used

- **SQL (MySQL):** Data cleaning, view creation, cohort & tenure calculations
- **Power BI:** Dashboard creation, demographic visuals, tenure modeling, and KPI reporting

---

## 📁 Files Included

- `hr_project.sql` → full SQL script (cleaning, views, and queries)
- `dashboard_screenshots/` → four Power BI dashboards (optional)
- `README.md` → this report

---

## 📬 Author

**Daniel Groza**  
📍 Charlotte, NC | 📊 BI & Data Analytics Portfolio  
💼 [LinkedIn](https://www.linkedin.com/in/your-profile) | 💻 [GitHub](https://github.com/your-repo)  
