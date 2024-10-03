-- How many Warehouses and Product Line distribuition
SELECT 
    w.warehouseName as "Warehouse",
    p.productLine as "Product Line"
FROM 
    products p
JOIN 
    warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY 
    w.warehouseName, p.productLine
ORDER BY 
    w.warehouseName, p.productLine;
    
-- How many products are stored at the warehouses
SELECT 
    'Total' AS "Warehouse",
    SUM(quantityInStock) AS "Total Quantity"
FROM 
    products;
    
-- How many products per warehouse and how is the warehouse capacity

SELECT w.warehouseName as Warehouse, 
       SUM(p.quantityInStock) AS "Current Stock", 
       w.warehousePctCap as "Warehouse Capacity (%)", 
       ROUND((SUM(p.quantityInStock) * 100.0) / w.warehousePctCap) AS "Max Capacity",
       ROUND((SUM(p.quantityInStock) * 100.0) / w.warehousePctCap) - SUM(p.quantityInStock) AS "Available Space",
       CONCAT('1:', MIN(CAST(SUBSTRING_INDEX(p.productScale, ':', -1) AS UNSIGNED))) AS minScale,
       CONCAT('1:', MAX(CAST(SUBSTRING_INDEX(p.productScale, ':', -1) AS UNSIGNED))) AS maxScale
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseName, w.warehousePctCap;

-- And taking in consideration the distribution per ProductLine

SELECT 
    w.warehouseName,
    p.productLine,
    SUM(p.quantityInStock) AS totalQuantity,
    CONCAT('1:', MIN(CAST(SUBSTRING_INDEX(p.productScale, ':', -1) AS UNSIGNED))) AS minScale,
	CONCAT('1:', MAX(CAST(SUBSTRING_INDEX(p.productScale, ':', -1) AS UNSIGNED))) AS maxScale
FROM 
    products p
JOIN 
    warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY 
    w.warehouseName, p.productLine
ORDER BY 
    w.warehouseName, p.productLine;
    
-- How many unique model exist?
SELECT COUNT(DISTINCT productCode) AS "Number of Models"
FROM mintclassics.products;    
    
-- Product with more and less quanitity in stock
SELECT 
    productCode, 
    productName, 
    quantityInStock
FROM 
    products
ORDER BY 
    quantityInStock DESC -- (ASC)
LIMIT 1;

-- Most and Least Expensive product by bought price.

SELECT 
    productName, 
    buyPrice 
FROM 
    products
ORDER BY 
    buyPrice desc -- (asc)
LIMIT 1;

-- Product Model with most accumaleted value in stock

SELECT 
    productName, 
    buyPrice, 
    quantityInStock, 
    (buyPrice * quantityInStock) AS totalValue
FROM 
    mintclassics.products
ORDER BY 
    totalValue asc
LIMIT 5;

-- Most ordered product

SELECT p.productCode, p.productName, 
	COUNT(od.productCode) AS totalOrders,
	COUNT(DISTINCT o.customerNumber) AS totalCustomers 
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY p.productCode, p.productName
ORDER BY totalOrders desc -- asc
LIMIT 3;

-- Product with biggest unit orders

SELECT p.productCode, p.productName, SUM(od.quantityOrdered) AS totalQuantityOrdered
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productCode, p.productName
ORDER BY totalQuantityOrdered desc -- asc
LIMIT 1;

-- Is there any product which didn't registerd an order?
SELECT p.productCode, p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;

-- Is there enough stock to give answer to all orders

SELECT p.productName AS "Product Name", 
       SUM(od.quantityOrdered) AS "Quantity Ordered",
       p.quantityInStock AS "Available Stock",
       CASE 
           WHEN p.quantityInStock - SUM(od.quantityOrdered) < 0 THEN 'Not enough Stock'
           ELSE 'OK'
       END AS "Situation"
FROM mintclassics.orderdetails od
JOIN mintclassics.products p ON od.productCode = p.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock;


-- Which products had the best profit for the company
SELECT 
    p.productName AS "Product Name",                              
    SUM(od.quantityOrdered * od.priceEach) AS revenue, 
    (SUM(od.quantityOrdered * od.priceEach) - sum(od.quantityOrdered * p.buyPrice)) AS profit,
    round(( (SUM(od.quantityOrdered * od.priceEach) - SUM(od.quantityOrdered * p.buyPrice)) / SUM(od.quantityOrdered * od.priceEach) ) * 100) AS profit_margin
FROM orderdetails od                             
JOIN products p ON od.productCode = p.productCode            
GROUP BY p.productCode, p.productName, p.buyPrice                
ORDER BY profit desc
limit 10; 

-- Orders Volume over time
SELECT 
    DATE_FORMAT(orderDate, '%Y-%m') AS "Month", 
    COUNT(orderNumber) AS "Total Orders"
FROM 
    orders
GROUP BY 
    DATE_FORMAT(orderDate, '%Y-%m')
ORDER BY 
    DATE_FORMAT(orderDate, '%Y-%m');
    
-- Whats the Average Processing Time

SELECT 
    DATE_FORMAT(orderDate, '%Y-%m') AS "Month", 
    round(AVG(DATEDIFF(shippedDate, orderDate))) AS "Avg Processing Time (Days)"
FROM orders
GROUP BY 
    DATE_FORMAT(orderDate, '%Y-%m')
ORDER BY 
    DATE_FORMAT(orderDate, '%Y-%m');
    
-- Which employee have the most clients and how much revenue they generated
SELECT 
    e.employeeNumber, e.firstName, e.lastName,
    COUNT(DISTINCT c.customerNumber) AS "Number of Clients",
    SUM(od.quantityOrdered * od.priceEach) AS revenue
FROM employees e
Join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders o on c.customerNumber = o.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
GROUP BY e.employeeNumber
ORDER BY revenue DESC;

-- How many countries are in our clients catalog
select count(distinct country) as "Number of Clients" from customers;

-- Revenue by country
SELECT 
    c.country, 
	count(distinct c.customerNumber) as clients,
    SUM(od.quantityOrdered * od.priceEach) AS revenue
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY revenue DESC
LIMIT 5;

-- best clients by country
SELECT 
    c.customerName, 
    c.country, 
    SUM(od.quantityOrdered * od.priceEach) AS revenue
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY c.customerName, c.country
ORDER BY revenue asc
LIMIT 5;



