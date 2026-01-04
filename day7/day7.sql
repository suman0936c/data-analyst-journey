use data_analyst;

WITH profit_data AS (
    SELECT 
      category,
      sub_category,
      ROUND(SUM(profit),2) AS total_profit
    FROM orders
    GROUP BY category, sub_category
)
SELECT 
  category,
  sub_category,
  total_profit,
  DENSE_RANK() OVER (
      PARTITION BY category
      ORDER BY total_profit DESC
  ) AS rank_in_category
FROM profit_data
WHERE total_profit > 0
ORDER BY category, rank_in_category;


SELECT 
  category,
  ROUND(SUM(sales),2) AS total_sales,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY category
HAVING SUM(profit) < 0;


WITH yearly_sales AS (
    SELECT 
      YEAR(order_date) AS year,
      ROUND(SUM(sales),2) AS total_sales
    FROM orders
    GROUP BY YEAR(order_date)
)
SELECT 
  year,
  total_sales,
  total_sales - LAG(total_sales) OVER (ORDER BY year) AS yoy_growth
FROM yearly_sales;


SELECT 
  sub_category,
  ROUND(SUM(profit),2) AS total_profit,
  NTILE(4) OVER (ORDER BY SUM(profit) DESC) AS profit_quartile
FROM orders
GROUP BY sub_category;



SELECT 
  CASE 
    WHEN profit > 0 THEN 'Profitable'
    ELSE 'Loss'
  END AS order_type,
  COUNT(*) AS total_orders
FROM orders
GROUP BY order_type;

