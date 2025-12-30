SELECT 
  sub_category,
  ROUND(SUM(sales),2) AS total_sales
FROM orders
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 10;

SELECT 
  sub_category,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 10;

SELECT 
  sub_category,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY sub_category
HAVING SUM(profit) < 0;

SELECT 
  order_id,
  ROUND(SUM(sales),2) AS total_sales
FROM orders
GROUP BY order_id
ORDER BY total_sales DESC
LIMIT 10;

SELECT 
  category,
  ROUND(SUM(profit),2) AS total_profit,
  ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM orders
GROUP BY category;
