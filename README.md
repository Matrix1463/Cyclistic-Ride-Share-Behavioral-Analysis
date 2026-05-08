# Cyclistic Ride-Share Behavioral Analysis
 
**How do casual riders and annual members use Cyclistic differently — and how can that difference drive membership conversion?**
 
This project analyzes Cyclistic's historical bike-share trip data to identify behavioral differences between casual riders and annual members. The findings are used to recommend targeted marketing strategies aimed at converting casual riders into annual members, with the goal of increasing long-term profitability.
 
---
 
## Business Context
 
Cyclistic is a fictional bike-share company operating in Chicago. The business has identified that annual members are significantly more profitable than casual riders. Rather than targeting entirely new customers, the marketing team wants to convert existing casual riders — people already familiar with the service — into annual members.
 
To support this goal, this analysis examines how the two groups differ in ride timing, duration, bike preference, and geographic usage patterns.
 
---
 
## Data Source
 
- **Source:** Cyclistic's historical trip data (first-party data, publicly available)
- **Period covered:** January – March 2021 (Q1 2021)
- **Records:** ~369,000 trips
- **Fields include:** Ride type (electric or classic bike), trip start and end times, start and end station names, geographic coordinates, and user type (casual or annual member)
> **Note:** This dataset covers one quarter of the year only. Seasonal patterns — particularly summer leisure riding — are not captured and represent a limitation of this analysis.
 
---
 
## Tools Used
 
| Tool | Purpose |
|---|---|
| **BigQuery (SQL)** | Data cleaning, preparation, combining monthly tables, and initial aggregation analysis to validate findings |
| **Python (Google Colab)** | Exploratory data analysis, statistical summaries, and validation |
| **Tableau** | Final visualizations and interactive dashboard for stakeholder communication |
 
---
 
## Process Overview
 
**1. SQL — Data Preparation**
Three monthly tables (January, February, March 2021) were combined into a single dataset using UNION ALL in BigQuery. Initial aggregation queries were then run directly in SQL to analyze ride frequency by hour, average ride duration by user type, and ride volume by day of week. These results were used to validate findings later produced in Python, confirming consistency across tools.
 
**2. Python — Exploratory Analysis**
The cleaned dataset was loaded into Google Colab for deeper analysis. New columns were engineered (ride duration, hour of day, day of week) and four analyses were conducted:
- Ride frequency by hour of day
- Ride duration distribution
- Ride frequency by day of week
- Bike type preference by user type
- Top start stations for casual riders
Outliers were handled by capping ride duration at the 95th percentile (51 minutes), removing likely unreturned or improperly docked bikes from the visualization without deleting them from the dataset. Docked bike records were excluded from the bike type analysis as a data artifact — members recorded only 1 docked ride across the entire quarter.
 
**3. Tableau — Dashboard**
Findings were visualized in an interactive Tableau dashboard designed for non-technical stakeholders. Charts use a consistent two-color scheme (casual = orange, member = blue) throughout.
 
---
 
## Key Findings
 
**1. Members commute, casuals ride for leisure**
Annual members show sharp ride peaks at 8AM and 5PM on weekdays — a clear commuting pattern. Casual riders show a gradual midday increase with no commute peaks, indicating flexible, leisure-oriented usage.
 
**2. Casual riders take significantly longer trips**
The median ride duration for casual riders is 17 minutes versus 9 minutes for members. The distribution is also much wider for casual riders, confirming this is a consistent behavioral difference rather than a result of outliers.
 
**3. Casual rider activity concentrates on weekends**
Casual ride volume nearly doubles on Saturday and Sunday compared to weekdays. Members maintain consistent activity throughout the week, with only a modest weekend increase.
 
**4. Casual riders cluster at lakefront recreation destinations**
The top casual rider start stations — including Millennium Park, Streeter Drive, and Lake Shore Drive — are concentrated along Chicago's lakefront recreational corridor. This geographic pattern is direct evidence of leisure-focused usage.
 
**5. Both groups prefer classic bikes, but casuals use electric bikes slightly more**
64% of casual rides use classic bikes vs 72% of member rides. Casual riders show a slightly higher preference for electric bikes (36% vs 28%), which may reflect a preference for lower-effort leisure rides.
 
---
 
## Recommendations
 
**1. Concentrate physical marketing at high-traffic lakefront stations**
A small number of lakefront stations account for a disproportionate share of casual rides. On-site signage, QR codes, or promotional staff at these locations offers high reach with direct access to the highest-opportunity casual riders.
 
**2. Reframe membership value for leisure users**
Standard messaging around commute savings is unlikely to resonate with casual riders. Membership benefits should be positioned around cost savings on longer, extended rides — the type of riding casual users already do.
 
**3. Time weekend promotions to capture peak casual engagement**
Saturday and Sunday are when casual riders are most active. Limited-time membership trials or weekend-only discounts offered in-app during these periods target riders at their highest engagement point.
 
**4. Investigate electric bike access as a membership incentive**
Casual riders show a slightly higher preference for electric bikes than members. Guaranteed electric bike access or a reduced electric ride rate within a membership plan could serve as a meaningful conversion incentive for this group.
 
---
 
## Limitations
 
- **Single quarter of data:** This analysis covers Q1 2021 only. Summer months — when leisure riding typically peaks — are not represented. A full-year dataset is recommended before finalizing conversion strategy.
- **Data recency:** The dataset is from 2021. Rider behavior and service usage patterns may have shifted since then.
- **Inferred intent:** Leisure vs commute behavior is inferred from usage patterns, not stated by users. A survey component would strengthen the conclusions by providing direct insight into rider motivations.
- **Missing station data:** 7.2% of rides are missing start station names, all associated with electric bikes not returned to a named dock. These records were excluded from the station analysis.
---
 
## Dashboard
 
View the interactive Tableau dashboard here:
[Cyclistic Rider Behavior Analysis — Tableau Public](https://public.tableau.com/views/Cyclist_EDA/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
 
---
 
## Files in This Repository
 
```
cyclistic-ride-share-behavioral-analysis/
├── README.md
├── sql/
│   └── analysis_queries.sql        ← BigQuery queries for data prep and validation
├── python/
│   └── Cyclist_EDA_Final.ipynb     ← Full annotated Python notebook
└── tableau/
    └── dashboard_link.md           ← Link to published Tableau Public dashboard
```
 
---
 
*This project was provided by the Google Data Analytics Professional Certificate as a capstone case study.*
