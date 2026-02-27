/*
=====================================================
SQL CUSTOMER BEHAVIOR ANALYSIS (MySQL)
Author: Sean Codner
Objective: Evaluate customer purchasing patterns and concentration risk
Assumed Tables: orders, customers
=====================================================
*/

-- 1) Top 10 customers by total units
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.units) AS total_units
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_units DESC
LIMIT 10;

-- 2) Customers with more than 5 orders
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;

-- 3) Customers with avg units per order > 3
SELECT
    c.customer_id,
    c.customer_name,
    AVG(o.units) AS avg_units_per_order
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING AVG(o.units) > 3
ORDER BY avg_units_per_order DESC;

-- 4) High-frequency, low-volume customers (example thresholds)
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.units) AS total_units
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 5 AND SUM(o.units) <= 10
ORDER BY total_orders DESC;

-- 5) One-time buyers with high units (bulk purchasers)
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.units) AS total_units
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) = 1 AND SUM(o.units) >= 10
ORDER BY total_units DESC;

-- 6) Concentration: % of total units from top 10 customers
SELECT
    ROUND(
        100 * (
            SELECT SUM(t.total_units)
            FROM (
                SELECT
                    c.customer_id,
                    SUM(o.units) AS total_units
                FROM orders o
                JOIN customers c
                    ON c.customer_id = o.customer_id
                GROUP BY c.customer_id
                ORDER BY total_units DESC
                LIMIT 10
            ) t
        ) / (SELECT SUM(units) FROM orders),
    2) AS top10_pct_of_total_units;
