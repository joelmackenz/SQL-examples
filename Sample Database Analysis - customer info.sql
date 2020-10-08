-- Analyzing the 'classicmodels' database

-- I want to analyze the highest cost of orders (complete),
--	-which day is the highest for ordering,
-- 	-which day was the slowest from order to delivery
-- 	-the relationship between credit limit and total spent on an order


SELECT *
FROM customers
WHERE creditLimit > 100000
LIMIT 4;

SELECT 
	(orderDetails.priceEach * orderdetails.quantityOrdered) AS 'Total Cost',
orders.customerNumber AS 'Customer Number',
orderdetails.priceEach AS 'Price',
orderdetails.quantityOrdered AS 'Quantity Ordered',
orders.orderDate AS 'Order Date',
customers.customerName AS 'Company Name',
CONCAT(customers.contactFirstName, ' ', customers.contactLastName) AS 'Contact Name'
FROM orders
LEFT JOIN customers
	ON orders.customerNumber = customers.customerNumber
LEFT JOIN orderdetails
	ON orders.orderNumber = orderdetails.orderNumber
ORDER BY 'Total Cost' DESC
LIMIT 100;