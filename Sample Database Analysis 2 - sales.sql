-- Analyzing the 'classicmodels' database

-- Below displays the days with the highest sales. The three highest sales days were 2003-11-14, 
-- 2003-12-02, and 2003-11-12.
SELECT orderDate,
    FORMAT(SUM(quantityOrdered * priceEach), 2) AS 'Total Sales Daily'
FROM orders
LEFT JOIN orderdetails
	ON orders.orderNumber = orderdetails.orderNumber
GROUP BY orderDate
ORDER BY SUM(quantityOrdered * priceEach) DESC
LIMIT 10;

-- Below orders the data into the highest grossing months by year. The top three sales years/months are
-- November 2003, November 2004, and October 2003.
SELECT
	month(orderDate) AS Month, 
	year(orderDate) AS Year, 
	FORMAT(SUM(quantityOrdered * priceEach), 2) AS 'Monthly Sales'
FROM orders
LEFT JOIN orderdetails
	ON orders.orderNumber = orderdetails.orderNumber
GROUP BY month, year
ORDER BY SUM(quantityOrdered * priceEach) DESC;

-- Below shows the total amount spent per month across the 2.5 years included in 'classicmodels', showing
-- the three highest grossing months as November, October, and May.
SELECT 
    EXTRACT(MONTH FROM orderDate) AS Month,
	FORMAT(SUM(quantityOrdered * priceEach), 2) AS 'Total Spent Monthly: 2003 to mid-2005'
FROM orders
LEFT JOIN orderdetails
	ON orders.orderNumber = orderdetails.orderNumber
GROUP BY month
ORDER BY SUM(quantityOrdered * priceEach) DESC;

