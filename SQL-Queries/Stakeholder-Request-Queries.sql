
-- Section 1: What is the typical amount of time between purchases for all customers and how does it differ between loyalty vs non-loyalty customers?

-- Use CTE to create temporary results set containing the number of days between each customer's orders.
WITH purchase_date_difference AS (
SELECT orders.customer_id,
  DATE_DIFF(orders.purchase_ts, LAG(orders.purchase_ts) OVER (PARTITION BY orders.customer_id ORDER BY orders.purchase_ts), DAY) AS days_btw_orders
FROM core.orders
ORder by 1),

-- Use CTE referencing purhase_date_difference to create temporary results set containing average number of days between each customer's orders and the number of orders they placed after their first order.
customer_avg_days_btw_orders AS (
SELECT purchase_date_difference.customer_id,
  AVG(days_btw_orders) AS avg_days_btw_orders,
  COUNT(days_btw_orders) AS number_orders_after_first
FROM purchase_date_difference
WHERE days_btw_orders IS NOT NULL
GROUP BY 1),

-- Use CTE referencing customer_avg_days_btw_orders to create temporary results set containing the average number of days between orders for loyalty customers and non-loyalty customers.
loyalty_program_avg_days_btw_orders AS (
SELECT CASE 
            WHEN customers.loyalty_program = 0 THEN 'Non-Loyalty Customer'
            WHEN customers.loyalty_program = 1 THEN 'Loyalty Customer'
        END AS loyalty_status,
        AVG(avg_days_btw_orders) AS avg_days_btw_orders
FROM customer_avg_days_btw_orders 
LEFT JOIN core.customers
  ON customers.id =customer_avg_days_btw_orders.customer_id
GROUP BY 1),

-- Use CTE referencing customer_avg_days_btw_orders to to create temporary results set containing average number of days between orders for all customers.
overall AS (
SELECT 'Overall' AS customer_category,
  AVG(avg_days_btw_orders) AS avg_days_btw_orders
FROM customer_avg_days_btw_orders
GROUP BY 1)

-- Reference loyalty_program_avg_days_btw_orders CTE and union with overall CTE to display average days between orders for loyalty customers, non-loyalty customers, and all customers.
SELECT loyalty_status AS customer_category,
  ROUND(loyalty_program_avg_days_btw_orders.avg_days_btw_orders, 2) AS avg_days_btw_orders
FROM loyalty_program_avg_days_btw_orders
UNION ALL
(SELECT customer_category AS customer_category,
  ROUND(overall.avg_days_btw_orders, 2) AS avg_days_btw_orders
FROM overall)
ORDER BY 2 DESC;

-- Section 2: For each brand, which month in 2020 had the highest number of refunds, and how many refunds did that month have?

-- Create helper column for brand using product names and count number of refunds per each brand per month in 2020. Qualify to display month with highest number of refunds.
SELECT CASE WHEN orders.product_name LIKE 'Apple%' or orders.product_name LIKE '%Air%' THEN 'Apple'
  WHEN orders.product_name LIKE 'Thinkpad%' THEN 'Thinkpad'
  WHEN orders.product_name LIKE 'Samsung%' THEN 'Samsung'
  WHEN orders.product_name LIKE 'bose%' THEN 'Bose'
  ELSE 'Unknown' END AS brand,
  DATE_TRUNC(orders.purchase_ts, month) AS month,
  COUNT(order_status.refund_ts) AS refund_count
FROM core.orders
LEFT JOIN core.order_status
  ON orders.id = order_status.order_id
WHERE EXTRACT(YEAR FROM orders.purchase_ts) = 2020
GROUP BY 1, 2
QUALIFY RANK() OVER (PARTITION BY brand ORDER BY refund_count DESC) = 1
ORDER BY 3 DESC

-- Section 3: What was the retention rate from 2021 to 2022, returned as a percent in X.XXXX% format? Retention rate is the percent of customers who placed an order in the first year who also placed an order in the second year.

-- Use CTE to create temporary results set containing customers that made a purchase in 2021.
WITH customers_2021 AS (
SELECT DISTINCT orders.customer_id AS id_2021
FROM core.orders
WHERE EXTRACT(YEAR FROM orders.purchase_ts) = 2021),

-- Use CTE to create temporary results set containing customers that made a purchase in 2022.
customers_2022 AS (
SELECT DISTINCT orders.customer_id AS id_2022
FROM core.orders 
WHERE EXTRACT(YEAR FROM orders.purchase_ts) = 2022)

-- Reference customers_2021 and customer_2022 CTEs to measure retention rate from 2021 to 2022. 
SELECT ROUND((AVG(CASE WHEN customers_2022.id_2022 IS NOT NULL THEN 1 ELSE 0 END)*100), 4) AS retention_rate
FROM customers_2021
LEFT JOIN customers_2022
  ON customers_2021.id_2021 = customers_2022.id_2022;
