SELECT 
  YEAR(order_date) AS year,
  ROUND(SUM(sales),2) AS total_sales,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year;

SELECT 
  YEAR(order_date) AS year,
  ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year;


SELECT 
  MONTH(order_date) AS month,
  ROUND(SUM(sales),2) AS total_sales
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;


SELECT 
  YEAR(order_date) AS year,
  MONTH(order_date) AS month,
  ROUND(SUM(sales),2) AS total_sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
