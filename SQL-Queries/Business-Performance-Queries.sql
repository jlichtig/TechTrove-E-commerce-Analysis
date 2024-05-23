
-- Section 1: What are the yearly monthly trends for order count, sales, and AOV? Include growth rates as well. 

-- 1.1 Yearly trends and growth

-- Use CTE to create temporary results set containing revenue, AOV, and order count per year.
WITH yearly_trend AS (
  SELECT EXTRACT(YEAR FROM orders.purchase_ts) AS year,
    SUM(orders.usd_price) AS revenue,
    AVG(orders.usd_price) AS AOV,
    COUNT(DISTINCT orders.id) AS order_count
  FROM core.orders
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
  GROUP BY 1)

-- Reference yearly_trend CTE to measure yearly growth of revenue, AOV, and order count.
SELECT year,
  ROUND(revenue, 2) AS revenue,
  ROUND(aov, 2) AS aov,
  order_count,
  ROUND((revenue/LAG(revenue) OVER (ORDER BY year) - 1)*100, 1) AS revenue_yearly_growth_pct,
  ROUND((aov/LAG(aov) OVER (ORDER BY year) - 1)*100, 1) AS aov_yearly_growth_pct,
  ROUND((order_count/LAG(order_count) OVER (ORDER BY year) - 1)*100,1) AS order_yearly_growth_pct
FROM yearly_trend
ORDER BY 1;

-- 1.2 Monthly trends growth

-- Use CTE to create temporary results set containing revenue, AOV, and order count per month.
WITH monthly_trends AS (
  SELECT DATE_TRUNC(orders.purchase_ts, MONTH) AS month,
    SUM(orders.usd_price) AS revenue,
    AVG(orders.usd_price) AS aov,
    COUNT(DISTINCT orders.id) AS order_count
  FROM core.orders
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
  GROUP BY 1)

-- Reference monthly_trend CTE to measure monthly growth of revenue, AOV, and order count.
SELECT month,
  ROUND(revenue, 2) AS revenue,
  ROUND(aov, 2) AS aov,
  order_count,
  ROUND((revenue/LAG(revenue) OVER (ORDER BY month) - 1)*100, 1) AS revenue_monthly_growth_pct,
  ROUND((aov/LAG(aov) OVER (ORDER BY month) - 1)*100, 1) AS aov_monthly_growth_pct,
  ROUND((order_count/LAG(order_count) OVER (ORDER BY month) - 1)*100,1) AS order_monthy_growth_pct
FROM monthly_trends
ORDER BY 1;

-- Section 2: What are the refund rates per product?

-- Clean product names and measure refund count, refund rate, AOV, and sales lost to refunds per product.
SELECT 
  CASE 
    WHEN orders.product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor'
    ELSE orders.product_name 
  END AS product_name_cleaned,
  SUM(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) AS refund_count,
  ROUND(AVG(CASE
              WHEN refund_ts IS NULL THEN 0 
              ELSE 1 
            END)*100, 2) AS refund_rate,
  ROUND(AVG(usd_price), 2) AS AOV,
  ROUND(SUM(CASE WHEN refund_ts IS NOT NULL THEN usd_price END),2) AS refund_usd_amt
FROM core.orders
LEFT JOIN core.order_status
  ON orders.id = order_status.order_id
GROUP BY 1
ORDER BY 3 DESC;

-- Section 3: What are the regional trends for revenue, AOV, and order count? Within each region, what are the most popular products? (consider adding something from these findings)

-- 3.1 Regional trends

-- Clean region and measure regional revenue, AOV, and order count.
SELECT CASE 
        WHEN geo_lookup.region IS NULL THEN 'Unknown'
        ELSE geo_lookup.region
      END as region_cleaned,
  ROUND(SUM(orders.usd_price), 2) AS revenue,
  ROUND(AVG(orders.usd_price), 2) AS aov,
  COUNT(DISTINCT orders.id) AS order_count
FROM core.orders
  LEFT JOIN core.customers
ON orders.customer_id = customers.id
  LEFT JOIN core.geo_lookup
ON customers.country_code = geo_lookup.country
GROUP BY 1
ORDER BY 2 DESC;

-- 3.2 Top 3 products per region

-- Use CTE to create temporary results set containing order count per product per region.
WITH regional_product_orders AS
(SELECT 
  CASE 
    WHEN geo_lookup.region IS NULL THEN 'Unknown'
    ELSE geo_lookup.region
  END as region_cleaned,
  CASE
    WHEN orders.product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor'
    ELSE orders.product_name 
  END AS product_name_cleaned,
  COUNT(DISTINCT orders.id) AS order_count
FROM core.orders
LEFT JOIN core.customers
ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup
ON customers.country_code = geo_lookup.country
GROUP BY 1, 2)

-- Reference regional_product_orders CTE to select top selling product per region.
SELECT region_cleaned,
  product_name_cleaned AS top_selling_product,
  order_count
FROM regional_product_orders
QUALIFY ROW_NUMBER() OVER (PARTITION BY region_cleaned ORDER BY order_count DESC) = 1
ORDER BY 3 DESC;

-- Section 4: Which marketing channel has the highest average signup rate for the loyalty program, and how does this compare to the channel that has the highest number of loyalty program participants? 

-- Use CTE to create temporary results set containing count of customers.
WITH total_customer_table AS(
  SELECT COUNT(DISTINCT customers.id) AS total_customer_count
  FROM core.customers
  WHERE customers.loyalty_program = 1),

-- Use CTE to create temporary results set containing average signup rate for loyalty program and number of signups per marketing channel.
signups_table AS (
  SELECT COALESCE(marketing_channel, 'unknown') AS marketing_channel,
    ROUND(AVG(customers.loyalty_program)*100, 2) AS avg_loyalty_signup_rate,
    SUM(customers.loyalty_program) AS loyalty_signups
  FROM core.customers
  GROUP BY 1
  )

-- Reference total_customer_table and signups_table CTEs to select average signup rate for loyalty program, number of signups, and signup percentage per marketing channel.
SELECT signups_table.marketing_channel,
  signups_table.avg_loyalty_signup_rate,
  signups_table.loyalty_signups,
  ROUND((signups_table.loyalty_signups/total_customer_table.total_customer_count) * 100, 2) as signup_pct
FROM signups_table CROSS JOIN total_customer_table
ORDER BY 2 DESC;

-- Section 5: What were yearly trends between loyalty and non-loyalty customers? What was the revenue split between them?

-- Use CTE to create temporary results set containing total revenue, aov, and order count per year.
WITH overall_yearly_trends AS (
  SELECT EXTRACT(YEAR FROM orders.purchase_ts) AS year,
    SUM(orders.usd_price) AS revenue,
    AVG(orders.usd_price) AS aov,
    COUNT(DISTINCT orders.id) AS order_count
  FROM core.orders
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
  GROUP BY 1),

-- Use CTE to create temporary results set containing total revenue, aov, and order count for non-loyalty customers per year.
non_loyalty_yearly_trends AS (
  SELECT EXTRACT(YEAR FROM orders.purchase_ts) AS year,
    customers.loyalty_program,
    SUM(orders.usd_price) revenue,
    AVG(orders.usd_price) AS aov,
    COUNT(DISTINCT orders.id) AS order_count
  FROM core.orders
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
  WHERE customers.loyalty_program = 0
  GROUP BY 1, 2),

-- Use CTE to create temporary results set containing total revenue, aov, and order count for loyalty customers per year.
loyalty_yearly_trends AS (
  SELECT EXTRACT(YEAR FROM orders.purchase_ts) AS year,
    customers.loyalty_program,
    SUM(orders.usd_price) AS revenue,
    AVG(orders.usd_price) AS aov,
    COUNT(DISTINCT orders.id) AS order_count
  FROM core.orders
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
  WHERE customers.loyalty_program = 1
  GROUP BY 1, 2)

-- Reference overall_yearly_trends, non_loyalty_yearly_trends, and loyalty_yearly_trends CTEs to measure and compare revenue, AOV, and order count for loyalty and non-loyalty customers as well as their share of revenue shown as a percentage.
SELECT overall_yearly_trends.year,
  ROUND(non_loyalty_yearly_trends.revenue, 2) AS non_loyalty_revenue,
  ROUND(loyalty_yearly_trends.revenue, 2) AS loyalty_revenue,
  ROUND(non_loyalty_yearly_trends.revenue/overall_yearly_trends.revenue * 100, 2) AS non_loyalty_revenue_pct,
  ROUND(loyalty_yearly_trends.revenue/overall_yearly_trends.revenue * 100, 2) AS loyalty_revenue_pct,
  ROUND(non_loyalty_yearly_trends.aov, 2) AS non_loyalty_revenue_aov,
  ROUND(loyalty_yearly_trends.aov, 2) AS loyalty_revenue_aov,
  non_loyalty_yearly_trends.order_count AS non_loyalty_revenue_order_count,
  loyalty_yearly_trends.order_count AS loyalty_revenue_order_count
FROM overall_yearly_trends
JOIN non_loyalty_yearly_trends
  ON overall_yearly_trends.year = non_loyalty_yearly_trends.year
JOIN loyalty_yearly_trends
  ON overall_yearly_trends.year = loyalty_yearly_trends.year 
ORDER BY 1;
