-- Q1 — What's the return rate, and does it change by region or category?
-- first we count the total orders region 
SELECT region, COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY region;
-- then we get the returned orders
SELECT o.region, COUNT(DISTINCT r.order_id) AS returned_orders
FROM returns r
JOIN orders o ON r.order_id = o.order_id
GROUP BY o.region;

-- then we combine them to get the return rate 
SELECT 
    t.region,
    t.total_orders,
    COALESCE(r.returned_orders, 0) AS returned_orders,
    ROUND(COALESCE(r.returned_orders, 0) * 100.0 / t.total_orders, 2) AS return_rate_pct
FROM 
    (SELECT region, COUNT(DISTINCT order_id) AS total_orders
     FROM orders
     GROUP BY region) t
LEFT JOIN 
    (SELECT o.region, COUNT(DISTINCT ret.order_id) AS returned_orders
     FROM returns ret
     JOIN orders o ON ret.order_id = o.order_id
     GROUP BY o.region) r
ON t.region = r.region;

-- then we do the same for category
SELECT 
    t.category,
    t.total_orders,
    COALESCE(r.returned_orders, 0) AS returned_orders,
    ROUND(COALESCE(r.returned_orders, 0) * 100.0 / t.total_orders, 2) AS return_rate_pct
FROM 
    (SELECT category, COUNT(DISTINCT order_id) AS total_orders
     FROM orders
     GROUP BY category) t
LEFT JOIN 
    (SELECT o.category, COUNT(DISTINCT ret.order_id) AS returned_orders
     FROM returns ret
     JOIN orders o ON ret.order_id = o.order_id
     GROUP BY o.category) r
ON t.category = r.category;

-- Q2 — Which categories bring in the most money, and which ones are actually losing money after discounts?
SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_sales DESC;

-- Q3 — Does a bigger discount usually mean lower profit?
SELECT category,
CASE 
WHEN discount = 0 THEN '0%'
WHEN discount <= 0.20 THEN '1-20%'
ELSE '21%+'
END AS discount_range ,
COUNT(*) AS num_orders,
ROUND(AVG(profit),2) AS avg_profit
FROM orders
GROUP BY discount_range , category
ORDER BY discount_range ;

-- Q4 — Which regions have the most returns or the lowest profit?
-- lets look at the profit first
SELECT 
  region, 
  SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_profit ASC;

-- now we combine this query with the returns query from q1
SELECT 
    t.region,
    t.total_orders,
    COALESCE(r.returned_orders, 0) AS returned_orders,
    ROUND(COALESCE(r.returned_orders, 0) * 100.0 / t.total_orders, 2) AS return_rate_pct,
    p.total_profit
FROM 
    (SELECT region, COUNT(DISTINCT order_id) AS total_orders
     FROM orders
     GROUP BY region) t
LEFT JOIN 
    (SELECT o.region, COUNT(DISTINCT ret.order_id) AS returned_orders
     FROM returns ret
     JOIN orders o ON ret.order_id = o.order_id
     GROUP BY o.region) r
ON t.region = r.region
LEFT JOIN
    (SELECT region, SUM(profit) AS total_profit
     FROM orders
     GROUP BY region) p
ON t.region = p.region
ORDER BY p.total_profit ASC;

-- Q5 — What's the average order value each month, and does it go up or down over the year?
-- first we look at each individual order total value
SELECT order_id, order_date, SUM(sales) AS order_total
FROM orders
GROUP BY order_id, order_date;

-- now we group those order totals by month and calculate the avg
SELECT EXTRACT (MONTH FROM order_date) AS month_number,
AVG(order_total) AS avg_order_value
FROM (
SELECT order_id, order_date, SUM(sales) AS order_total
FROM orders
GROUP BY order_id, order_date
) AS order_totals
GROUP BY month_number
ORDER BY month_number ;