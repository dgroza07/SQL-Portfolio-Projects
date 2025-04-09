🏠 US Household Income Analysis (MySQL Project)
📊 Project Objective:
To clean, transform, and explore a U.S. household income dataset (32,000+ records) using SQL to identify patterns in income distribution across states, city types, and geographic features — with real-world implications for economic strategy, equity initiatives, and resource allocation.

🔧 Data Cleaning & Standardization
Performed extensive preprocessing and validation to ensure high data integrity:

Renamed BOM-corrupted columns (e.g., ï»¿id → id)

Removed duplicate rows using ROW_NUMBER() and DELETE

Corrected typos in State_Name, Type, and Place fields ('georia' → 'Georgia', 'CPD' → 'CDP')

Standardized text values and null entries (e.g., blank Place fields filled based on logic)

Validated geographic values:

Flagged and filtered rows where ALand or AWater was 0, null, or suspiciously low

Ensured data types were consistent and analysis-ready

📈 Exploratory Data Analysis (EDA)
🗺️ Geographic Insights
States with Most Land: Texas, California, Missouri

States with Most Water: Michigan, Texas, Florida

Top Water-to-Land Ratio: Hawaii (0.6595), Delaware (0.3323), Alaska (0.2919)

Implication: Land/water ratios can impact infrastructure costs, housing potential, and flood zone risk.

💰 Income Distribution by State
Top Median Incomes: NJ, WY, AK, CT, MA (>$119K)

Lowest Median Incomes: PR, AR, MS, LA, OK (<$65K)

Highest Income Gaps (Mean > Median): Indicates skew and potential inequality.

🏙️ City-Level Income Analysis
Top 5 cities by mean income include:

Delta Junction (AK), Short Hills (NJ), Chevy Chase (MD), Darien (CT), Pelham (NY)

Most are suburban elite zones with concentrated wealth.

🧱 Place Type (Structural) Insights
Filtered and ranked types with 100+ entries:

Type	  Median Income	    Count
CDP	     $116,231.9	      964
Track	   $86,925.3	      28,939
Borough	 $73,384.0	      129
Village	 $72,316.7	      388
City	   $64,850.4	      1,055
Town	   $63,846.6	      473

CDPs and Boroughs consistently rank highest in median income, while Communities and Urban areas showed the lowest — suggesting resource access gaps and classification-driven income stratification.

💼 Business Recommendations

✅ 1. Targeted Infrastructure & Development
Prioritize water-dense states (Hawaii, Michigan) for flood infrastructure, marine transportation investment, or tourism development.

Allocate economic development funds to underperforming states (e.g., Mississippi, Arkansas) with low median and mean incomes.

✅ 2. Policy-Making & Social Equity
Use mean-median income gaps as proxies for inequality; states with high discrepancies may benefit from:

Income redistribution programs

Affordable housing expansion

Localized tax credits or wage subsidies

✅ 3. Market Strategy & Real Estate
Invest or market high-end financial, luxury, or housing services in CDPs, Boroughs, and elite cities (e.g., Darien, Short Hills, Agoura Hills).

In contrast, urban or community-designated regions may represent underserved markets for low-cost housing, public services, or local entrepreneurship incentives.

✅ 4. Federal & State Resource Allocation
States/Territories like Puerto Rico, West Virginia, and Alabama show persistent low-income performance. Agencies could use this data to:

Reallocate grants

Fund community colleges or retraining programs

Improve digital access and broadband in low-income tracts

