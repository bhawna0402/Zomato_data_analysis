# 🍽 Zomato Restaurant Analysis (2018)
> Which Indian cities offer the best value dining — and where should Zomato expand next?

[![Tableau](https://img.shields.io/badge/Tableau-Live%20Dashboard-E23744?style=flat&logo=tableau)](https://public.tableau.com/shared/9FSCP72TK)
[![Python](https://img.shields.io/badge/Python-3.14-blue?style=flat&logo=python)](https://python.org)
[![SQL](https://img.shields.io/badge/SQL-SQLite-green?style=flat)](https://sqlite.org)
[![Pandas](https://img.shields.io/badge/pandas-2.x-150458?style=flat&logo=pandas)](https://pandas.pydata.org)

---

## 📊 Live Dashboard
🔗 **[View Interactive Tableau Dashboard](https://public.tableau.com/shared/9FSCP72TK)**

---

## 📌 Business Question
Analysing 9,551 Zomato restaurant records across 15 countries (2018 data) to answer:
- Which Indian cities have the highest quality restaurants?
- Does online delivery improve restaurant ratings?
- Which cuisines dominate quality dining?
- Where should Zomato prioritise expansion?

> ⚠️ **Data Note:** This dataset was collected in 2018. All findings reflect historical conditions and should not be interpreted as current Zomato platform metrics.

---

## 🔑 Key Findings

### Finding 1 — Smaller cities outperform Delhi in quality

![Top Cities by Rating](dashboard/screenshots/chart1_cities_rating.png)

Lucknow (4.20), Guwahati (4.19), and Ahmedabad (4.16) are India's highest rated cities — outperforming New Delhi (3.30) despite Delhi having **190x more restaurants** on the platform. Bigger presence does not mean better quality.

---

### Finding 2 — Online delivery drives engagement, not quality

![Online Delivery Impact](dashboard/screenshots/chart2_delivery_impact.png)

Delivery restaurants score only marginally higher ratings (3.37 vs 3.34) but receive **35% more customer votes** (218 vs 162). Online delivery increases platform visibility — not food quality.

---

### Finding 3 — Italian cuisine tops all categories unexpectedly

![Top Cuisines](dashboard/screenshots/chart3_cuisines_rating.png)

Italian cuisine (3.82 avg) outperforms North Indian (3.40) by a significant margin — suggesting strong demand for international cuisines in Indian metros that Zomato could leverage for restaurant acquisition.

---

### Finding 4 — Best value dining = Delhi street food

![Best Value Restaurants](dashboard/screenshots/chart4_value_restaurants.png)

Jung Bahadur Kachori Wala scores 8.2 on value (rating per ₹100) with a 4.1 rating at just ₹50 for two. The top 4 value restaurants all cost ₹50 — proving premium quality does not require premium pricing.

---

### Finding 5 — Ahmedabad is the top expansion candidate

![City Expansion Score](dashboard/screenshots/chart5_expansion_score.png)

Ahmedabad leads with an expansion score of 2.18 — the only city combining high ratings (4.16) AND strong delivery adoption (52.4%). Lucknow and Guwahati have better ratings but **0% delivery** — the biggest untapped opportunity on the platform.

---

### Bonus — City Intelligence Map (Interactive)

![City Intelligence Map](dashboard/screenshots/chart6_city_map.png)

Interactive bubble chart: X = avg cost, Y = avg rating, bubble size = restaurant count, colour = delivery adoption %. The two large green bubbles are Delhi and Gurgaon — high volume, moderate quality. Small dots in the top right = hidden gem cities with high quality but low restaurant count.

🔗 **[Interact with this chart live on Tableau Public](https://public.tableau.com/shared/9FSCP72TK)**

---

## 💡 Business Recommendation

Zomato should prioritise delivery partner onboarding in **Lucknow** and **Guwahati** — a high quality restaurant base already exists but delivery infrastructure is completely missing. Ahmedabad proves this model works: high ratings + delivery adoption = platform growth. These three cities represent Zomato's highest ROI expansion opportunity in India.

---

## 🛠 Tools & Approach

| Stage | Tool | What I did |
|---|---|---|
| Data Loading | Python / pandas | Loaded 9,551 records, merged country code lookup table |
| Cleaning | Python / pandas | Removed 2,148 unrated restaurants, handled multi-currency cost column |
| Analysis | SQL (SQLite) | 5 business queries including window functions (RANK) |
| Visualisation | Python (matplotlib, seaborn, plotly) | 6 publication-quality charts |
| Dashboard | Tableau Desktop | 5-sheet interactive dashboard published to Tableau Public |

---

## 📁 Project Structure

```
zomato-restaurant-analysis/
├── data/
│   ├── zomato.csv                    ← raw dataset (Kaggle)
│   └── Country-Code.xlsx             ← country lookup table
├── SQL_Queries/
│   └── queries.sql                   ← all 5 SQL queries
├── Notebooks/
│   └── zomato_eda.ipynb              ← full analysis notebook
├── dashboard/
│   └── screenshots/                  ← all chart images
│       ├── chart1_cities_rating.png
│       ├── chart2_delivery_impact.png
│       ├── chart3_cuisines_rating.png
│       ├── chart4_value_restaurants.png
│       ├── chart5_expansion_score.png
│       ├── chart6_city_map.png
│       └── chart6_city_intelligence_map.html
└── README.md
```

---

## 📈 SQL Queries

5 business queries written in pure SQL (SQLite):

| Query | Business Question | Key Technique |
|---|---|---|
| Q1 | Which cities have the best avg rating? | GROUP BY + HAVING |
| Q2 | Does online delivery improve ratings? | GROUP BY + AVG |
| Q3 | Which cuisines are rated highest? | GROUP BY + HAVING + ORDER BY |
| Q4 | Which restaurants give best value? | Calculated column (rating/cost) |
| Q5 | Which cities should Zomato expand into? | CASE WHEN + composite metric |

Full queries available in `/SQL_Queries/queries.sql`

---

## 🗂 Data Cleaning Decisions

| Decision | Reason |
|---|---|
| Removed 2,148 unrated restaurants (rating = 0) | Rating 0 means never reviewed, not actually rated zero |
| Used median cost (₹500) not mean (₹1,199) | ₹800,000 outlier in Indonesian Rupiah inflates mean |
| India-only for cost analysis | Cost column uses local currency per country — not comparable |
| Minimum 20 restaurants per city/cuisine | Prevents small samples producing misleading averages |

---

## 📦 Dataset

- **Source:** [Zomato Restaurants Dataset — Kaggle](https://www.kaggle.com/datasets/shrutimehta/zomato-restaurants-data)
- **Records:** 9,551 restaurants across 15 countries
- **Year:** 2018
- **Key columns:** Restaurant Name, City, Country, Cuisines, Aggregate Rating, Average Cost for Two, Has Online Delivery, Votes

---

## ✍️ Author

**Bhawna**
Data Analyst | SQL · Python · Power BI · Tableau
B.E. Computer Science — Chandigarh University (2026)

🔗 [LinkedIn](https://www.linkedin.com/in/bhawna-suthar04/)&nbsp;|&nbsp;
🐙 [GitHub](https://github.com/bhawna0402) &nbsp;|&nbsp;
📧 iarmy1949@gmail.com
