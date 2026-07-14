CREATE DATABASE ecommerce_funnel;
use ecommerce_funnel;
SHOW tables;
DESCRIBE ecommerce_funnel;
SELECT COUNT(*) FROM ecommerce_funnel;
SELECT event_type, COUNT(*) 
FROM ecommerce_funnel 
GROUP BY event_type 
ORDER BY COUNT(*) DESC;
SELECT event_type, COUNT(DISTINCT user_id) 
FROM ecommerce_funnel 
GROUP BY event_type 
ORDER BY COUNT(DISTINCT user_id) DESC;
SELECT * FROM ecommerce_funnel LIMIT 10;
SELECT event_type, COUNT(*) AS total_events 
FROM ecommerce_funnel 
GROUP BY event_type 
ORDER BY total_events DESC;
SELECT 
    SUM(event_type = 'view') AS views, 
    SUM(event_type = 'cart') AS carts, 
    SUM(event_type = 'checkout') AS checkouts, 
    SUM(event_type = 'purchase') AS purchases 
FROM ecommerce_funnel;
SHOW COLUMNS FROM ecommerce_funnel;
WITH funnel AS( SELECT 
    SUM(event_type = 'view') AS views, 
    SUM(event_type = 'cart') AS carts, 
    SUM(event_type = 'checkout') AS checkouts, 
    SUM(event_type = 'purchase') AS purchases 
FROM ecommerce_funnel)
SELECT views, carts, checkouts, purchases, 
    ROUND(carts / views * 100, 2) AS view_to_cart_rate, 
    ROUND(checkouts / carts * 100, 2) AS cart_to_checkout_rate, 
    ROUND(purchases / checkouts * 100, 2) AS checkout_to_purchase_rate, 
    ROUND(purchases / views * 100, 2) AS overall_conversion_rate
FROM funnel;
SELECT
    device,
    SUM(event_type = 'view') AS views,
    SUM(event_type = 'cart') AS carts,
    SUM(event_type = 'checkout') AS checkouts,
    SUM(event_type = 'purchase') AS purchases
FROM ecommerce_funnel
GROUP BY device
ORDER BY purchases DESC;
SELECT
    device,
    ROUND(SUM(event_type='cart') / SUM(event_type='view') * 100, 2) AS view_to_cart,
    ROUND(SUM(event_type='checkout') / SUM(event_type='cart') * 100, 2) AS cart_to_checkout,
    ROUND(SUM(event_type='purchase') / SUM(event_type='checkout') * 100, 2) AS checkout_to_purchase
FROM ecommerce_funnel
GROUP BY device;
SELECT
    country,
    SUM(event_type='view') AS views,
    SUM(event_type='cart') AS carts,
    SUM(event_type='checkout') AS checkouts,
    SUM(event_type='purchase') AS purchases
FROM ecommerce_funnel
GROUP BY country
ORDER BY purchases DESC;
SELECT
    category,
    SUM(event_type='view') AS views,
    SUM(event_type='cart') AS carts,
    SUM(event_type='checkout') AS checkouts,
    SUM(event_type='purchase') AS purchases
FROM ecommerce_funnel
GROUP BY category
ORDER BY purchases DESC;
SELECT
    brand,
    SUM(event_type='view') AS views,
    SUM(event_type='cart') AS carts,
    SUM(event_type='checkout') AS checkouts,
    SUM(event_type='purchase') AS purchases
FROM ecommerce_funnel
GROUP BY brand
ORDER BY purchases DESC;
SELECT SUM(price) AS total_revenue
FROM ecommerce_funnel
WHERE event_type = 'purchase';
SELECT country, SUM(price) AS revenue
FROM ecommerce_funnel
WHERE event_type = 'purchase'
GROUP BY country
ORDER BY revenue DESC;
SELECT category, SUM(price) AS revenue
FROM ecommerce_funnel
WHERE event_type = 'purchase'
GROUP BY category
ORDER BY revenue DESC;
SELECT product_id, COUNT(*) AS purchases
FROM ecommerce_funnel
WHERE event_type = 'purchase'
GROUP BY product_id
ORDER BY purchases DESC
LIMIT 10;
SELECT
    session_id,
    MAX(event_type='view') AS viewed,
    MAX(event_type='cart') AS carted,
    MAX(event_type='checkout') AS checked_out,
    MAX(event_type='purchase') AS purchased
FROM ecommerce_funnel
GROUP BY session_id;
SELECT
    user_id,
    MAX(event_type='view') AS viewed,
    MAX(event_type='cart') AS carted,
    MAX(event_type='checkout') AS checked_out,
    MAX(event_type='purchase') AS purchased
FROM ecommerce_funnel
GROUP BY user_id;
SELECT
    HOUR(event_time) AS hour,
    COUNT(*) AS events
FROM ecommerce_funnel
GROUP BY hour
ORDER BY hour;
SELECT
    DATE(event_time) AS day,
    COUNT(*) AS events
FROM ecommerce_funnel
GROUP BY day
ORDER BY day;
SELECT
    MONTH(event_time) AS month,
    COUNT(*) AS events
FROM ecommerce_funnel
GROUP BY month
ORDER BY month;

