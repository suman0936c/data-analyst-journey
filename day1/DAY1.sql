USE data_analyst;
DESCRIBE orders;

SELECT * FROM orders LIMIT 5;

SELECT COUNT(*) FROM orders;

SELECT 
  MIN(order_date) AS first_order,
  MAX(order_date) AS last_order
FROM orders;

SELECT 
  ROUND(SUM(sales),2) AS total_sales,
  ROUND(SUM(profit),2) AS total_profit
FROM orders;

SELECT 
  region,
  ROUND(SUM(sales),2) AS total_sales,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY region;

SELECT 
  category,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_profit DESC;

SELECT 
  region,
  ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM orders
GROUP BY region
ORDER BY profit_margin DESC;



