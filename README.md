# TechTrove E-commerce Analysis
[MSExcel analysis](https://github.com/jlichtig/ElectroniCart-Ecommerce-Analysis/blob/463cfb4605246906c314f40c1cc5f196f60c83ea/ElectroniCart%20Analysis.xlsx) and [SQL queries](https://github.com/jlichtig/ElectroniCart-Ecommerce-Analysis/tree/e6b1571bf42ee7df948def4e4f2ebd8df9cea7df/SQL-Queries) are accessible via GitHub.

Since its establishment in 2019, TechTrove has been an e-commerce platform catering to a global audience, offering a wide range of electronic products. From 2019 to 2022, they amassed over 100K rows of data on their sales, marketing efforts, and loyalty program. Having conducted an exploratory analysis on the largely underutilized dataset, this project consolidates findings on TechTrove's performance through the COVID-19 pandemic, offering the company's sales and marketing leaders actionable insights and recommendations to improve their performance.

Insights and recommendations cover the following areas:

- **Sales Trends:** Review of TechTrove's performance across key dimensions. North Star metrics used:
  - Revenue: Total sales (usd)
  - Order Volume: Number of orders placed
  - Average Order Value (AOV): Average amount spent (usd) by customers per order
- **Product Performance:**  Review of product offerings' sales performance.
- **Refund Rates:** Analysis of refunded products and their impact on TechTrove's bottom line.
- **Loyalty Program Efficacy:** Assessing the loyalty program's performance.

# About the Data
The following ERD reflects the database structure of TechTrove's dataset, aligning primary and foreign keys between tables: 
![image](https://github.com/jlichtig/ElectroniCart-Ecommerce-Analysis/assets/155100360/7b819634-50dd-43de-bb47-c79538217192)

Tables:
- orders: represents unique orders. Table grain is (order) id.
- order_status: represents unique orders (provides additional operational data points) Table grain = order_id
- customers: represents unique customers. Table grain = (customer) id 
- geo_lookup: represents locational data for customers. Table grain = country

The dataset was cleaned and normalized in Excel before being uploaded to a BigQuery database. A detailed log of data cleaning steps can be viewed [here](https://github.com/jlichtig/ElectroniCart-Ecommerce-Analysis/blob/610f1a41aa5f3fc7ba270c914d01a54b268b9935/Data-Cleaning-Log.MD).

# Insights
## **Sales trends:**
- From 2019 to 2022, TechTrove generated **$28M in revenue**, driven by **108K orders** from customers with an **AOV of $260**.
- Sales performance boomed in 2020 amid the onset of the COVID-19 pandemic - **total revenue surged 163% YoY** ($3.9M -> $10.1M), with order volume **doubling** (17K -> 34K) and AOV increasing by nearly **one-third** (+$71). Consequently, 2020 emerged as the top-performing year within the period.
 - In 2021, despite achieving the **highest number of sales** at 36K orders, **revenue dropped by $1M (-10%)** from the previous year due to a **15% decrease in AOV** – this marked the beginning of a downward trend in AOV that persisted throughout the rest of the period.
- From 2021 to 2022, TechTrove experienced a **40% reduction in order volume**, which coupled with already falling AOV returning to pre-pandemic levels (**-10% to $230**), resulted in a massive **46% drop in revenue (-$4.2M)**. This YoY performance shift could signal consumer's return to pre-pandemic spending behavior.
![Yearly Trend](https://github.com/jlichtig/TechTrove-E-commerce-Analysis/assets/155100360/5a018126-9695-401a-80f9-6d5690c3f8b3)

**Seasonal trends:**
- January/September/December regularly experienced **high order volumes** – up a respective **11%/13%/20%** above the average. 
- February/June/October regularly experience **low order volumes** – down a respective **19%/7%/20%** below the average.

Seasonal patterns were observed in order volumes throughout each year. Summary of seasonality:
- Strong start in January – orders were up **11% above the monthly average**.
- Orders drop in February – **falling 27%** on average.
- Rebounding in March **(+21%)** followed by a slight downward trend from April to June (**-7%** across the period). Caveat: 2020 would experience notable growth in this period as consumer spending behavior quickly changed with the onset of the pandemic).
- Steady increase of orders throughout Q3 with the trend peaking in September (**22% growth** from June to September). Caveat: Trend not observed in 2022.
- Orders dive in October - **descending 29% MoM**.
- Strongest period growth exhibited towards year-end, with orders **increasing by 50%** from October to December.

![Total Sales](https://github.com/jlichtig/TechTrove-E-commerce-Analysis/assets/155100360/72729f81-f111-4998-9692-2541bf960738)


*In 2022, as COVID-19 restrictions began to ease, order seasonality deviated from typical trends. In Q3, order volume declined by 18% from June to September, trending towards the pre-pandemic levels - this could be indicative of a return to pre-pandemic consumer purchasing behavior.*

**Regional trends**
- NA and EMEA were the **best performing regions**, generating a respective **~$14.6M and $8.2M** in revenue. Combined, purchases from the two regions accounted for **81%** of total revenue.
- APAC customers were willing to pay the most for products, with an AOV of $279 - **~$19 more** than the average customer. However, orders from the region only accounted for **12% of the total order volume**.

## **Product performance:**
- Product revenue distribution was notably concentrated, as **85%** ($24M) of total revenue stemmed from only **three out of the eight** products offered: the 27-inch 4K gaming monitor ($9.9M), Apple AirPods headphones ($7.7M), and MacBook Air laptops ($6.3M)
- In the headphone category, the Bose Soundsport Headphones significantly underperformed, contributing to **~0.01%** of total revenue. In contrast, consumers consistently showed a strong preference for Apple AirPods, with these headphones being the **most purchased product**, accounting for **45%** of total orders placed and commanding an average premium of **29%** over Bose Soundsport Headphones, the only other headphone offering.
- Consumers exhibit a strong preference for Apple products, with these products collectively accounting for approximately **51%** of total revenue.

## **Refund rates:**
*The following analysis of refunds aggregates refund data based on the date of purchase. The scope focuses on purchases made from 2019 – 2021 as 2022 purchases were missing refund data points.*
- The average refund rate was **6%**, resulting in **$2.2M in lost revenue** (refund loss). This represents a loss equivalent to approximately **10%** of the total revenue ($23M) for that period.
- Refund rates varied across products, ranging from **0% to 14%** for which there appears to be a positive correlation between product AOV and refund rate, suggesting that **higher-priced products** tend to have **higher refund rates**.
- Products with the highest refund rates:
  - ThinkPad Laptop: 14% refund rate – equating to $382K in refund loss (17% of total refund loss)
  - Macbook Air Laptop: 13.3% - equating to $746K in refund loss (33% of total refund loss)
  - Apple iPhone: 9% - equating to $16K in refund loss (>1% of total refund loss)
- Products with the highest refund loss:
  - Macbook Air Laptop: $746K
  - 27in 4K gaming monitor: $642K
  - Apple Airpod Headphones: $430K
- The Laptop product category exhibited the highest average refund rate at approximately **14%**. This category also accounted for **50%** of the total refund loss, totaling **$1.1M** in lost sales across 800 refunded orders, representing 15% of the total returned orders.
- Refund rates fluctuated from year to year, increasing from **5.7%** in 2019 to **9.6%** in 2020, then decreasing to **3.6%** in 2021.

## **Loyalty program performance:**
- From 2019 to 2022, there was notable YoY growth in revenue generated by loyalty program members. Accounting for only **11%** of yearly revenue in 2019, by April 2021 they would surpass non-members in revenue contribution, and by 2022, their purchases would account for **55%** of yearly revenue.
![Loyalty Chart](https://github.com/jlichtig/TechTrove-E-commerce-Analysis/assets/155100360/0fa188f9-13bb-4845-b785-d9daa7be3c9a)

- In 2022, loyalty customers demonstrated a willingness to pay an average of **14% more** ($30) for products compared to non-members, with an AOV of $244 versus $214 for non-members
- From August to September 2022, as order volume was falling sharply with both groups, sales from non-members would begin to outpace sales of loyalty customers in a trend that would persist through the rest of the year - non-members revenue contributions rose from a **43%** in August to **70%** in December.
- The direct marketing channel was responsible for the most loyalty signups, bringing in **71%** (23.3K) of total signups, although its signup rate of **40%** was slightly below the average (~43.5%) 
- Excluding customers coming in from unknown marketing channels, Email had the highest average loyalty signup rate with **59%** but was only responsible for about **one quarter of total signups** (7.8K)
- The social media marketing channel has an above-average signup rate (52%), but only accounts for 1.5% of signups.
- The affiliate marketing channel had both the lowest number of signups (338) as well the lowest signup rate (18% signup rate).

# **Recommendations:** 
## **Sales**
- Create sales incentives and promotional campaigns to boost order volume in seasonally underperforming months (February/June/October).
- Replace poor-performing Bose Soundsport headphones with over-the-ear Apple AirPod Max - leverage consumers' preference for Apple products while expanding headphone style options.
- Capitalize on the APAC region's willingness to purchase more expensive - launch a regionally focused ad campaign to boost order volume.
- Seize the opportunity presented by the increasing popularity of video gaming by expanding your gaming monitor offerings to include 32in screens, one of the most popular sizes in the market.
  
## **Refunds**
- Introduce an installment payment plan option aimed at reducing refund requests for higher-priced products.
  - Additionally offer customers requesting refunds the option to retroactively participate in the installment payment plan.
- Collect 'Refund Reason' as part of the refund request form to better understand the most common drivers.

## **Loyalty Program:**
- Based on the overall performance growth from loyalty members, the program should continue to be supported. However, in light of the program's subpar performance in late 2022, teams should closely track the program moving into 2023 and re-evaluate at the end of Q1 23.
<!-- Leverage the effectiveness of the email marketing channel. Work with marketing to expand the email database. -->
- Marketing channel budget reallocation - due to the low signup rate of the affiliate marketing channel, reallocate funds to support the growth of email marketing (59% signup rate).

