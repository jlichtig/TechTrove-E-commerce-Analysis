# ElectroniCart Post-Pandemic Ecommerce Analysis
Excel analysis and SQL queries are accessible via GitHub
Tableau dashboards are accessible via Tableau Public

Since its establishment in 2019, ElectroniCart has been an e-commerce platform catering to a global audience, offering a wide range of electronic products. Between 2019 and 2023, they amassed over 100K rows of transactional data rich in metrics, encompassing sales and operations, product offerings, marketing strategies, and loyalty program analytics. This project consolidates the analysis of the largely underutilized dataset, offering the company's business leaders actionable insights and recommendations to improve their business performance.

This project aims to conduct an exploratory analysis to understand ElectroniCart's sales performance from pre-pandemic through post-pandemic (2019 - 2022) to form initial recommendations for marketing and inventory management teams for further areas of exploration.

Insights and recommendations cover the following areas:

- **Sales Trends:** Review of companies performance KPIs. North Star metrics used:
  - Revenue: Total sales (usd)
  - Order Volume: Number of orders placed
  - Average Order Value (AOV):  Average amount spent (usd)  by customer per order
- **Product Performance:**  Assessment  of product mix performance.
- **Refund Rates:** Analysis of trends frequency and value of product refunds  and the monetary effects on the company.
- **Loyalty Program Efficacy:** Assessing the performance and efficacy of the loyalty program.

# Insights
## **Sales trends:**
- From 2019 to 2022, ElectroniCart accumulated a total sales revenue of **$28M**, driven by **108K orders** from customers with an **AOV of $260**.
- Sales performance skyrocketed in 2020 amid the onset of the COVID-19 pandemic - number of orders **doubled** (**17K** -> **34K**), accompanied by a **significant one-third increase in AOV (+$71)**, resulting in a remarkable **163% surge in revenue**, amounting to **$10.1 million in total sales**. Consequently, 2020 emerged as the top-performing year within the period.
 - In 2021, despite achieving the **highest number of sales** at **36K orders**, **revenue dropped by $1M (-10%)** from 2020 due to a **15% decline in AOV** – this decrease marked the onset of a downward trend in AOV that persisted throughout the period, ultimately settling back to pre-pandemic levels at approximately **$230**.
- In 2022, as many parts of the world started to regain normalcy post-pandemic, ElectroniCart saw a **substantial 40% decline in orders** placed. Coupled with the falling AOV, this led to a **massive 46% drop in revenue (-$4.2M)**. Although yearly revenue and number of orders each remained 28% higher (+$1.1M/+~5K orders) than 2019 figures. <!-- Need to revisit -->

**Seasonal trends:**
Seasonal patterns can be observed via the fluctuation of order volume throughout each year. Seasonal summary:
- Strong start in January – orders are up 11% above monthly average.
- Orders decrease by 27% in February.
- Rebounding in March (+21% from February) followed a downward trend from April to June (notable growth in 2020 due to pandemic).
- Steady increase of orders throughout Q3, cresting in September - 22% growth from June to September (not observed in 2022)
- Orders dive in October - 29% MoM descent.
- Strongest growth exhibited towards year-end, with orders increasing by 50% from October to December.

- In 2022, as COVID-19 restrictions began to ease, order seasonality deviated from typical trends. In Q3, order volume declined by 18% from June to September, possibly indicating a return to pre-pandemic consumer purchasing behavior.
- January/September/December regularly experienced high order volumes - up a respective 11%/13%/20% above the average. 
- February/June/October regularly experience low order volumes – down a respective 19%/7%/20% below the average.

-  January/September/December regularly experienced high order volumes - up a respective 11%/13%/20% above the average. 
- February/June/October regularly experience low order volumes – down a respective 19%/7%/20% below the average.

