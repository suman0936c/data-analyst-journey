use data_analyst;

SELECT 
  category,
  sub_category,
  ROUND(SUM(profit),2) AS total_profit,
  DENSE_RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(profit) DESC
  ) AS category_rank
FROM orders
GROUP BY category, sub_category;

SELECT *
FROM (
    SELECT 
        category,
        sub_category,
        ROUND(SUM(profit),2) AS total_profit,
        DENSE_RANK() OVER (
            PARTITION BY category 
            ORDER BY SUM(profit) DESC
        ) AS rnk
    FROM orders
    GROUP BY category, sub_category
) t
WHERE rnk <= 2;

SELECT 
  YEAR(order_date) AS year,
  ROUND(SUM(sales),2) AS yearly_sales,
  ROUND(
      SUM(SUM(sales)) OVER (ORDER BY YEAR(order_date)),
  2) AS running_sales
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year;

SELECT 
  year,
  yearly_sales,
  yearly_sales 
    - LAG(yearly_sales) OVER (ORDER BY year) AS yoy_growth
FROM (
    SELECT 
      YEAR(order_date) AS year,
      ROUND(SUM(sales),2) AS yearly_sales
    FROM orders
    GROUP BY YEAR(order_date)
) t;

SELECT 
  year,
  yearly_sales,
  ROUND(
    (yearly_sales - LAG(yearly_sales) OVER (ORDER BY year))
    / LAG(yearly_sales) OVER (ORDER BY year) * 100, 2
  ) AS yoy_growth_percent
FROM (
    SELECT 
      YEAR(order_date) AS year,
      SUM(sales) AS yearly_sales
    FROM orders
    GROUP BY YEAR(order_date)
) t;

SELECT *
FROM (
    SELECT 
      year,
      yearly_sales,
      yearly_sales - LAG(yearly_sales) OVER (ORDER BY year) AS growth
    FROM (
        SELECT 
          YEAR(order_date) AS year,
          SUM(sales) AS yearly_sales
        FROM orders
        GROUP BY YEAR(order_date)
    ) y
) g
WHERE growth < 0;
