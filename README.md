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

# About the Data

# Insights
## **Sales trends:**
- From 2019 to 2022, ElectroniCart accumulated a total sales revenue of **$28M**, driven by **108K orders** from customers with an **AOV of $260**.
- Sales performance skyrocketed in 2020 amid the onset of the COVID-19 pandemic - number of orders **doubled** (**17K** -> **34K**), accompanied by a **significant one-third increase in AOV (+$71)**, resulting in a remarkable **163% surge in revenue**, amounting to **$10.1 million in total sales**. Consequently, 2020 emerged as the top-performing year within the period.
 - In 2021, despite achieving the **highest number of sales** at **36K orders**, **revenue dropped by $1M (-10%)** from 2020 due to a **15% decline in AOV** – this decrease marked the onset of a downward trend in AOV that persisted throughout the period, ultimately settling back to pre-pandemic levels at approximately **$230**.
- In 2022, as many parts of the world started to regain normalcy post-pandemic, ElectroniCart saw a **substantial 40% decline in orders** placed. Coupled with the falling AOV, this led to a **massive 46% drop in revenue (-$4.2M)**. Although yearly revenue and number of orders each remained 28% higher (+$1.1M/+~5K orders) than 2019 figures. <!-- Need to revisit -->

**Seasonal trends:**
- January/September/December regularly experienced **high order volumes** – up a **respective 11%/13%/20%** above the average. 
- February/June/October regularly experience **low order volumes** – down a **respective 19%/7%/20%** below the average.

Seasonal patterns were observed in order volumes throughout each year. Seasonal summary:
- Strong start in January – orders are up **11% above the monthly average**.
- Orders drop in February – **falling 27%** on average.
- Rebounding in March **(+21%)** followed by a downward trend from April to June (**-7%** across the period) (notable growth in 2020 due to pandemic).
- Steady increase of orders throughout Q3, cresting in September - **22% growth** from June to September (not observed in 2022)
- Orders dive in October - **29% MoM descent**.
- Strongest growth exhibited towards year-end, with orders **increasing by 50%** from October to December.

* *In 2022, as COVID-19 restrictions began to ease, order seasonality deviated from typical trends. In Q3, order volume declined by 18% from June to September, trending towards the pre-pandemic levels - this could be indicative of a return to pre-pandemic consumer purchasing behavior.* *

**Monthly trends:**
- December 2020 had both the **highest number of sales (4K)** and the **most total sales ($1.2M)** as well as the second most expensive sales (**AOV of $311**) – this peak can likely be attributed to the compounding effect of pandemic spending with holiday sales.
- October 2022 had the **lowest number of sales (825)** and **least expensive sales (AOV of $216)** resulting in that month having the **lowest total sales ($178K)** for the period (*across the period, the month of October sees a seasonal dip in numbers of orders).

**Regional trends**
- NA and EMEA were the **best performing regions**, generating a **respective ~$14.6M and $8.2M** in revenue. Combined, purchases from the two regions accounted for **81%** of total revenue.
- APAC customers were willing to pay the most for products, with an AOV of $279 - ~$19 higher than the average customer. However, orders from the region only accounted for 12% of the total order volume.

## **Product performance:**
- Product revenue distribution was notably concentrated, as 85% ($24M) of total revenue stemmed from only three out of the eight products offered: the 27-inch 4K gaming monitor ($9.9M), Apple AirPods headphones ($7.7M), and MacBook Air laptops ($6.3M)
- In the headphone category, the Bose Soundsport Headphones significantly underperformed across the board, contributing to ~0.01% of total revenue. In contrast, consumers consistently showed a strong preference for Apple AirPods, with these headphones being the most purchased product, accounting for 45% of total orders placed and commanding an average premium of 29% over other headphone options.
- Consumers exhibit a strong preference for Apple products, with these products collectively accounting for approximately 51% of total revenue.

## **Refund rates:**
* *The following analysis of refunds aggregates refund data based on the date of purchase. The scope focuses on purchases made from 2019 – 2021 as 2022 purchases did not have refund data points.* *
- The **average refund rate was 6%**, resulting in **$2.2M in lost revenue** (refund loss). This represents a loss equivalent to **approximately 10%** of the total revenue ($23M) for that period.
- Refund rates varied across products, ranging from **0% to 14%** for which there appears to be a positive correlation between AOV and refund rate, suggesting that **higher-priced products** tend to **have higher refund rates**.
- Products with the highest refund rates:
  - ThinkPad Laptop: 14% refund rate – equating to $382K or 17% of total refund loss
  - Macbook Air Laptop: 13.3% - equating to $746K or 33% of total refund loss
  - Apple iPhone: 9% - equating to $16K or >1% of total refund loss
- Products with the highest refund loss:
  - Macbook Air Laptop: $746K
  - 27in 4K gaming monitor: $642K
  - Apple Airpod Headphones: $430K
- The Laptop product category exhibited the highest average refund rate at **approximately 14%**. This category also accounted for **50%** of the total refund loss, totaling **$1.1M** in lost sales across 800 refunded orders, representing 15% of the total returned orders.
- Refund rates fluctuated from year to year, increasing from **5.7%** in 2019 to **9.6%** in 2020, then decreasing to **3.6%** in 2021.

## **Loyalty program performance:**
- From 2019 to 2022, there was a notable YoY growth in revenue generated by loyalty program members. Accounting for only **11%** of yearly revenue in 2019, by 2021 they would surpass non-members in revenue contribution, and by 2022, their purchases would account for **55%** of total revenue.
- In 2022, loyalty customers demonstrated a willingness to pay an average of **14% more** ($30) for products compared to non-members, with an AOV of $244 versus $214 for non-members
- From August to September 2022, as order volume was falling sharply across the board, sales from non-members would begin to outpace sales of loyalty customers in a trend that would persist through the rest of the year - non-members revenue contributions rose from a **43%** in August to **70%** in December.

# **Recommendations:** 
- Recommend operations team look into refund date data as all average number of days before products are refunded is 733 with minimum of 670 days.
- Recommendation to marketing to update product descriptions of expensive products to better inform customers of products
- Based on the performance growth from loyalty members, I would recommend the program should continue to be supported. However, in light of the program's poor performance in late 2022, we should closely to track program KPIs moving into 2023 and reevaluate at the end of Q1 23. 


