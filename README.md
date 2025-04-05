🌍 World Life Expectancy SQL Analysis
Exploratory Data Analysis | Trend Analysis | Economic & Health Correlation | Insight Generation

🧠 Project Overview:
This SQL-based project dives into the global life expectancy dataset over a span of ~15 years, combining health indicators with economic variables such as GDP, BMI, and adult mortality.

But rather than simply describing trends, I approached this project through a series of targeted analytical questions, designed to simulate real-world business and policy investigations.

🔍 What Questions Did I Ask?
Each query was crafted around a core question — a problem worth solving or a pattern worth investigating.

Which countries have experienced the most significant improvements in life expectancy?

Are improvements in life expectancy evenly distributed, or are some countries falling behind?

Is there a measurable relationship between a country’s economic status (GDP) and life expectancy?

How does a population’s average BMI correlate with life expectancy — is there a tipping point?

Do developed and developing nations show drastically different health outcomes?

How has adult mortality changed over time in specific nations like the U.S., U.K., and UAE — and what might that say about healthcare efficiency?

🧪 How Did I Explore the Data?
SQL Queries: Used aggregate functions, conditional filtering, GROUP BY, HAVING, and window functions like OVER(PARTITION BY...) to uncover temporal trends and group-based differences.

Cumulative Analysis: Leveraged window functions to evaluate rolling totals (e.g., adult mortality).

Segmentation: Split the data by development status, GDP thresholds, BMI ranges, and country groups to identify disparities.

Comparative Framing: Used consistent metrics across countries to make cross-country comparisons meaningful and standardized.

💡 Key Insights (Framed as Findings to Analytical Questions):
1. Which countries improved most?
Countries like Haiti, Zimbabwe, and Eritrea saw life expectancy increase by 20+ years, driven largely by post-conflict recovery and public health improvements.

📈 Method: Calculated MAX(Life expectancy) - MIN(Life expectancy) per country.

2. Who fell behind?
Countries such as Mexico, Saudi Arabia, and Uruguay showed minimal improvements (<2 years), despite already having moderate to high life expectancy.

🔍 This led me to explore potential stagnation factors: healthcare systems, chronic disease, or data saturation.

3. Is GDP linked to longer lives?
Yes — countries with GDP > 1500 had an average life expectancy of 74.2 years, while those under 1500 averaged just 64.7. That’s a 9.5-year gap.

💰 I bucketed GDP using a threshold and calculated average life expectancy per group.

4. Does BMI tell a similar story?
Not linearly. Countries with very high BMI (e.g., USA, Tonga, Kuwait) showed long life spans despite high obesity rates due to medical advancements — while countries with very low BMI (e.g., Eritrea, Bangladesh) suffered from undernutrition, correlating with lower life expectancy.

⚖️ The BMI-to-life expectancy relationship appears U-shaped.

5. How do developed vs developing nations compare?
Developed countries (32 total) had an average life expectancy of 79.2

Developing countries (161 total) averaged 66.8

🌐 This reaffirms systemic global inequality in healthcare access, education, and stability.

6. What did rolling mortality trends reveal?
I analyzed cumulative adult mortality over time for countries like the United States, United Kingdom, and United Arab Emirates.

The U.S. saw a sharp decline in adult mortality, suggesting effective chronic disease control.

The UK mirrored this trend, while UAE showed more volatility — possibly due to demographic shifts or data anomalies.

🧮 Used window functions with PARTITION BY and ORDER BY Year DESC to calculate rolling sums.

🧩 Business-Friendly Takeaways:
Investments in healthcare infrastructure yield measurable improvements in life expectancy.

Both poverty and obesity present life expectancy risks — but for very different reasons.

Developing nations are catching up, but the gap is still wide — global intervention efforts remain critical.

Rolling analysis techniques are essential to track improvement trajectories, not just static snapshots.

🛠️ Tools Used:
SQL (MySQL Workbench): Data transformation, EDA, trend analysis

Excel & Tableau (optional): For visual validation of trends

Window Functions: Time-series & rolling metrics
