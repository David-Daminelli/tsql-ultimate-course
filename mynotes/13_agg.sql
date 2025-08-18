SELECT
customer_id,
COUNT(*) AS [NumberOfCustomers],
SUM(sales) AS [TotalSales],
AVG(sales) as AvgSales,
MAX(sales) as HighSale,
MIN(sales) as LowSale
FROM orders
GROUP BY customer_id