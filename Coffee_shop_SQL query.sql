#Figure out all the tables on the data
SELECT*
FROM CLEMY.COFFEE_SHOP;

#Updated the table as total_revenue was viewed as a string due to "," instead of "."
UPDATE CLEMY.COFFEE_SHOP
SET TOTAL_REVENUE = REPLACE(TOTAL_REVENUE, ',', '.');

#Update the year to the correct format of YYYY and not YY
UPDATE CLEMY.COFFEE_SHOP
SET Month_ID = REPLACE(Month_ID, '0023', '2023');

#Get the total_revenue per store locations
SELECT STORE_LOCATION,
	SUM(TOTAL_REVENUE) AS Total_Revenue
FROM 
	CLEMY.COFFEE_SHOP
GROUP BY 
	STORE_LOCATION;

#Get the number_of_transactions per store locations
SELECT 
	STORE_LOCATION,
	SUM(NUMBER_OF_TRANSACTIONS)
FROM 
	CLEMY.COFFEE_SHOP
GROUP BY 
	STORE_LOCATION;

#selecting the top 5 product categories based on total revenue
SELECT 
	PRODUCT_CATEGORY,
	SUM(TOTAL_REVENUE) AS Revenue_per_Product_Category
FROM 
	CLEMY.COFFEE_SHOP
GROUP BY 
	PRODUCT_CATEGORY
ORDER BY 
	Revenue_per_Product_Category DESC
LIMIT 5;

#selecting the bottom 5 product categories based on total revenue
SELECT 
	PRODUCT_CATEGORY,
	SUM(TOTAL_REVENUE) AS Revenue_per_Product_Category
FROM 
	CLEMY.COFFEE_SHOP
GROUP BY 
	PRODUCT_CATEGORY
ORDER BY 
	Revenue_per_Product_Category ASC
LIMIT 5;

#Sales based on day of the week, which determines which day sells most and worst
SELECT 
	DAY_OF_WEEK,
	SUM(TOTAL_REVENUE) AS Sales_per_Day
FROM 
	CLEMY.COFFEE_SHOP
GROUP BY 
	DAY_OF_WEEK
ORDER BY 
	Sales_per_Day DESC;

#Top Time per Store based on sold products
SELECT *
FROM (
  STORE_LOCATION,
  TIME_BUCKET,
  SUM(UNIQUE_PRODUCTS_SOLD) AS Unique_sold_products
	ROW_NUMBER() OVER(
		PARTITION BY STORE_LOCATION 
		ORDER BY SUM(UNIQUE_PRODUCTS_SOLD) DESC
	) AS rn
FROM 
  CLEMY.COFFEE_SHOP
GROUP BY 
  STORE_LOCATION, TIME_BUCKET
 ) AS ranked_data
 WHERE rn=1;
 
#Revenue per transaction
SELECT STORE_LOCATION, 
    SUM(TOTAL_REVENUE)/ SUM(NUMBER_OF_TRANSACTIONS) AS Revenue_per_Transaction
FROM CLEMY.COFFEE_SHOP
GROUP BY STORE_LOCATION;

#Revenue per quantity sold
SELECT STORE_LOCATION, 
    SUM(TOTAL_REVENUE)/ SUM(TOTAL_QUANTITY_SOLD) AS Revenue_per_Transaction
FROM CLEMY.COFFEE_SHOP
GROUP BY STORE_LOCATION;

#Calculating revenue per month
SELECT
    TO_CHAR(MONTH_ID, 'YYYY-MM') AS Month,
    SUM(TOTAL_REVENUE) AS Revenue_Per_Month
FROM CLEMY.COFFEE_SHOP
GROUP BY Month
ORDER BY Month;