SELECT 
  order_id,
  sales,
  profit,
  CASE
    WHEN profit > 0 THEN 'Profitable'
    WHEN profit = 0 THEN 'Break-even'
    ELSE 'Loss'
  END AS order_status
FROM orders;

SELECT 
  CASE
    WHEN profit > 0 THEN 'Profitable'
    ELSE 'Loss'
  END AS order_type,
  COUNT(*) AS total_orders
FROM orders
GROUP BY order_type;

SELECT 
  sub_category,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY sub_category
HAVING SUM(profit) >
(
  SELECT AVG(profit)
  FROM orders
);

SELECT 
  sub_category,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 3;

SELECT 
  sub_category,
  ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit ASC
LIMIT 3;
