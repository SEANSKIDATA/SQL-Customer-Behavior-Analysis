# SQL Customer Behavior Analysis

## Overview
This project analyzes customer purchasing behavior using transactional order data.  
The objective is to identify customer segments based on order frequency, purchase volume, and average order size to support retention and revenue strategy.

---

## Business Objectives

- Identify high-value and high-frequency customers  
- Detect bulk purchasers vs repeat purchasers  
- Quantify customer concentration risk  
- Segment customers by purchasing patterns  

---

## Dataset Assumptions

**orders**  
(order_id, customer_id, order_date, units)

**customers**  
(customer_id, customer_name, region)

---

## Key Analyses Performed

1. Top 10 customers by total units  
2. Customers with more than 5 orders  
3. Customers with average units per order > 3  
4. High-frequency, low-volume customers  
5. One-time bulk purchasers  
6. Customer concentration (Top 10 % of total units)

---

## Tools Used

- MySQL  
- SQL  

---

## Skills Demonstrated

- Aggregation (SUM, COUNT, AVG)  
- Behavioral segmentation  
- Business metric design  
- Relational joins  
- Analytical filtering (HAVING)  

---

## How to Run

1. Load the assumed schema into MySQL.
2. Execute the queries in `analysis.sql`.
3. Review output tables to evaluate customer behavior patterns.
