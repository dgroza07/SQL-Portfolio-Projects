📉 Workforce Downsizing Analytics: Layoff Forecasting & Risk Strategy using MySQL (2020–2023)

🔍 Project Overview
This project uses **MySQL** to transform raw tech layoff data into **business-critical insights** for forecasting workforce risk, optimizing talent strategy, and informing operational planning.

It simulates a real-world analyst role — from data extraction and cleaning to analysis and strategic KPI development — using SQL-based queries to support decision-making in HR, VC, operations, and finance.

---

📁 Dataset & Objective
- Dataset: 1,000+ records of global tech layoffs (2020–2023)
- Fields: Company, industry, funding stage, layoffs (total & %), funds raised, date, location
- Objective: 
   - Forecast when, where, and why layoffs occur
   - Uncover red flags by stage, geography, and scale
   - Generate insights that can inform workforce strategy and risk assessment

---

🧼 Data Cleaning Summary (SQL-Based)
Tools Used: MySQL, SQL Workbench

| Action                       | Method Used                                         |
|-----------------------------|------------------------------------------------------|
| Remove duplicates           | CTE + `ROW_NUMBER()` + `DELETE`                     |
| Standardize fields          | `TRIM()`, `LIKE`, string correction                 |
| Clean date formats          | `STR_TO_DATE()` + column type conversion            |
| Handle NULL values          | Self-join for missing `industry`; removed junk rows |
| Drop temp fields            | Removed helper columns like `row_num` post-cleaning |

> ✅ Result: Clean table `layoffs_staging2` — ready for high-impact business analysis

---

📊 Exploratory Analysis & Key Metrics

🏢 Company Insights
- 🔹 **Amazon led layoffs** (18,150), followed by **Google (12,000)**, Meta, and Microsoft
- 🔹 30+ companies executed **100% workforce cuts**, typically **Series A–C** startups
- 🔹 High-funding ≠ job security → Companies like **Crypto.com**, **Byju’s**, and **Better.com** raised capital before mass layoffs

📆 Temporal Insights
- 📈 Peak month: January 2023 — 84,714 layoffs
- 📉 Lowest layoff year: 2021 — 15,823 layoffs
- 🧮 Cumulative layoffs (Mar 2020–Mar 2023): 385,879
- 🕒 Rolling monthly totals used to detect surge cycles post-earnings and funding rounds

🌍 Country-Level Trends
- 🇺🇸 USA dominated layoffs, followed by India and Canada
- 🔍 U.S. layoffs alone made up 70%+ of the dataset

💸 Stage-Based Risk
| Stage       | Total Layoffs | Risk Level    |
|-------------|---------------|---------------|
| Series B-D  | High           | Financial pressure after scaling |
| Post-IPO    | High           | Public scrutiny + revenue shortfalls |
| Seed/Series A | Moderate     | Small cuts, high volatility    |

🏆 Top Company by Year
| Year | Company   | Layoffs |
|------|-----------|---------|
| 2020 | Uber      | 7,525   |
| 2021 | Bytedance | 3,600   |
| 2022 | Meta      | 11,000  |
| 2023 | Google    | 12,000  |

---

📈 Business Use Cases & Recommendations

1. 🛡️ Risk Forecasting for Workforce Strategy
Use rolling totals and quarterly spikes to predict when to tighten hiring, initiate budget reassessments, or prepare for internal layoffs.

2. 📉 Venture Capital Portfolio Monitoring
Investors can track stage-based layoff risk (Series B–Post-IPO) and adjust funding strategies or board interventions accordingly.

3. 🎯 Talent Acquisition Optimization
Recruiting teams can:
- Proactively target employees from at-risk companies
- Monitor churn-prone industries like Crypto, Retail Tech, and SaaS
- Build pipelines aligned with **layoff-prone stages**

4. 🧭 Executive Reporting
C-suite and HR leaders can integrate KPIs from this analysis into:
- Quarterly workforce reports
- Retention dashboards
- Headcount forecasting models

---

📌 Recruiter-Relevant KPIs Extracted

| KPI/Metric                         | Value                   | Business Use |
|-----------------------------------|-------------------------|--------------|
| Total layoffs (2020–2023)         | 385,879                 | Macro risk benchmarking |
| Avg. layoffs/month (rolling)      | ~10,000+                | Budget + headcount planning |
| Companies with 100% layoffs       | 30+                     | Early warning indicator |
| Peak month/year                   | Jan 2023 / 2022         | Cycle prediction |
| Top industry in layoffs           | Crypto, Retail Tech     | Talent pivoting |
| Most vulnerable stage             | Series C & Post-IPO     | VC portfolio risk |

---

🧠 Final Thoughts
This project models a real-world analyst workflow: turning unstructured layoff data into strategic, stakeholder-ready insights. By pairing SQL proficiency with business judgment, the output informs high-impact decisions across HR, Finance, and VC teams.

