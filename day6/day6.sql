use data_analyst;

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO categories (category_name)
SELECT DISTINCT category FROM orders;


CREATE TABLE sub_categories (
    sub_category_id INT AUTO_INCREMENT PRIMARY KEY,
    sub_category_name VARCHAR(50),
    category_name VARCHAR(50)
);

INSERT INTO sub_categories (sub_category_name, category_name)
SELECT DISTINCT sub_category, category FROM orders;


SELECT 
  o.order_id,
  o.sales,
  o.profit,
  c.category_name
FROM orders o
INNER JOIN categories c
ON o.category = c.category_name;


SELECT 
  o.order_id,
  o.sales,
  o.profit,
  s.sub_category_name
FROM orders o
LEFT JOIN sub_categories s
ON o.sub_category = s.sub_category_name;

SELECT 
  o.order_id,
  o.sub_category
FROM orders o
LEFT JOIN sub_categories s
ON o.sub_category = s.sub_category_name
WHERE s.sub_category_name IS NULL;

SELECT 
  c.category_name,
  ROUND(SUM(o.sales),2) AS total_sales,
  ROUND(SUM(o.profit),2) AS total_profit
FROM orders o
INNER JOIN categories c
ON o.category = c.category_name
GROUP BY c.category_name;

SELECT 
  o.sub_category,
  ROUND(SUM(o.profit),2) AS product_profit,
  cat.avg_profit
FROM orders o
JOIN (
    SELECT 
      category,
      ROUND(AVG(profit),2) AS avg_profit
    FROM orders
    GROUP BY category
) cat
ON o.category = cat.category
GROUP BY o.sub_category, cat.avg_profit;


SELECT 
  category_name,
  sub_category,
  total_profit,
  RANK() OVER (
      PARTITION BY category_name
      ORDER BY total_profit DESC
  ) AS category_rank
FROM (
    SELECT 
      c.category_name,
      o.sub_category,
      ROUND(SUM(o.profit),2) AS total_profit
    FROM orders o
    JOIN categories c
      ON o.category = c.category_name
    GROUP BY c.category_name, o.sub_category
) t;


