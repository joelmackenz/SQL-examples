-- Slowest from order to delivery.
-- Notice that the majority of shipping days were 8 and below, which a few special cases above 70.
-- In the following tables, results above 10 were ommitted to account for this.

SELECT orderNumber, orderDate, shippedDate, shippedDate - orderDate as shippingTime
FROM orders
ORDER BY shippingTime DESC;

-- Average shipping time for each month across the whole database. Slowest month is May, fastest February.
-- All results above 10 were removed, because the few results that are above ten are greatly above ten
-- (in the 70s), which would skew the results.
WITH shippingTimes AS
	(SELECT
    shippedDate - orderDate as shippingTime,
    month(orderDate) AS month,
    year(orderDate) AS year
    FROM orders
    HAVING shippingTime < 10)
SELECT 
	FORMAT(AVG(shippingTime), 2) AS 'Average Monthly Shipping Time (days)',
	month,
	year
FROM shippingTimes
GROUP BY Month, year
ORDER BY 1 DESC;

-- Average shipping days per month compared to the quantity of products ordered in that month.
-- All shipping days above 10 days are removed, as any results above ten are greatly above ten, 
-- skewing the results.
WITH shippingTimes AS
	(SELECT
    shippedDate - orderDate as shippingTime,
    month(orderDate) AS month,
    year(orderDate) AS year,
    orderNumber
    FROM orders
    HAVING shippingTime < 10)
SELECT
	FORMAT(AVG(shippingTime), 2) AS 'Average Shipping Time (days)',
	month,
	year,
	SUM(quantityOrdered) AS quantityOrdered
FROM shippingTimes
LEFT JOIN orderdetails
	ON shippingTimes.orderNumber = orderdetails.orderNumber
GROUP BY month, year
ORDER BY 4 DESC;

