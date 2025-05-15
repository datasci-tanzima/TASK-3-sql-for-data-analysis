USE classicmodels;

-- 1. Top 10 customers by total number of orders
SELECT customerNumber, COUNT(*) AS total_orders
FROM orders
GROUP BY customerNumber
ORDER BY total_orders DESC
LIMIT 10;

-- 2. Total payments made by each customer
SELECT customerNumber, SUM(amount) AS total_paid
FROM payments
GROUP BY customerNumber
ORDER BY total_paid DESC;

-- 3. Join: Customer name with their orders
SELECT c.customerName, o.orderNumber, o.status
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
LIMIT 10;

-- 4. Subquery: Payments greater than average
SELECT customerNumber, amount
FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments);

-- 5. View: High value customers (paid > 100k)
DROP VIEW IF EXISTS high_value_customers;
CREATE VIEW high_value_customers AS
SELECT customerNumber, SUM(amount) AS total_spent
FROM payments
GROUP BY customerNumber
HAVING total_spent > 100000;

-- 6. Check the view
SELECT * FROM high_value_customers;

-- 7. Index Optimization Example
DROP INDEX idx_customer ON orders;
CREATE INDEX idx_customer ON orders(customerNumber);
