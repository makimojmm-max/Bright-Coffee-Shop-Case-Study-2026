--0. DATA CHECKS AND CLEANING 

-- View Bright Coffee Data
SELECT *
FROM retails.sales.brightcoffee;

-- Replace comma with dot and convert unit_price to a number
SELECT
  transaction_id,
  CAST(REPLACE(unit_price, ',', '.') AS DOUBLE) AS unit_price_num
FROM retails.sales.brightcoffee;

--Check numbre of records 
SELECT 
      COUNT (*) AS total_records
FROM retails.sales.brightcoffee;

--Check for duplicates (not of colums but of the entire row)
SELECT *, 
      COUNT(*) AS duplicate_count
FROM retails.sales.brightcoffee
GROUP BY ALL
HAVING COUNT (*) > 1; --No duplicates found 

--Check for NULL values
SELECT *
FROM retails.sales.brightcoffee
WHERE transaction_id IS NULL OR transaction_date IS NULL OR transaction_time IS NULL OR transaction_qty IS NULL OR store_id IS NULL OR store_location IS NULL OR product_id IS NULL OR unit_price IS NULL OR product_category IS NULL OR product_type IS NULL OR product_detail IS NULL;

--1. TOTAL REVENUE 

  --Calculate total amount for every transaction first
SELECT transaction_id,
       transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DOUBLE) AS Total_Amount
FROM retails.sales.brightcoffee;

--Calclate total revenue- SUM all the Total_Amount Colmn
SELECT 
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee;

--2. TOTAL REVENUE PER PRODUCT CATEGORY 
SELECT 
      product_category,
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee
GROUP BY ALL;

--3. TOTAL REVENUE PRODUCT CATEGORY AND PRODUCT DETAIL 
SELECT 
      product_category,
      product_detail,
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee
--WHERE product_category = 'Coffee'
GROUP BY ALL
ORDER BY product_category; 

--4. TOTAL REVENUE PER PRODUCT TYPE
SELECT 
      product_type,
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee
GROUP BY ALL;

--5. TOTAL REVENUE PRODUCT CATEGORY AND PRODUCT TYPE 
SELECT 
      product_category,
      product_type,
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee
--WHERE product_category = 'Coffee'
GROUP BY ALL
ORDER BY product_category;

--6. TOTAL UNITS SOLD
SELECT 
      SUM(transaction_qty) AS Total_Units_Sold
FROM retails.sales.brightcoffee; 

--7. TOTAL UNITS SOLD PER PRODUCT CATEGORY
SELECT 
      product_category, 
      SUM(transaction_qty) AS Total_Units_Sold
FROM retails.sales.brightcoffee
GROUP BY ALL; 

--8 TOTAL UNITS SOLD PER PRODUCT TYPE
SELECT 
      product_type, 
      SUM(transaction_qty) AS Total_Units_Sold
FROM retails.sales.brightcoffee
GROUP BY ALL; 

--9. TOTAL UNITS SOLD PER PRODUCT CATEGORY AND PRODUCT TYPE
SELECT 
      product_category,
      product_type, 
      SUM(transaction_qty) AS Total_Units_Sold
FROM retails.sales.brightcoffee
GROUP BY ALL;

--10. TOTAL REVENUE PER STORE
SELECT 
      store_location,
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee
GROUP BY ALL;

--11. TOTAL REVENUE PER STORE AND PER PRODUCT CATEGORY
SELECT 
      store_location,
      product_category, 
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee
GROUP BY ALL
ORDER BY store_location; 

--12. TOTAL REVENUE PER STORE AND PER PRODUCT TYPE
SELECT 
      store_location,
      product_type, 
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee
GROUP BY ALL
ORDER BY store_location;

--13. TOTAL REVENUE PER STORE AND PER PRODUCT CATEGORY AND PER PRODUCT TYPE
SELECT 
      store_location,
      product_category, 
      product_type, 
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM retails.sales.brightcoffee
GROUP BY ALL
ORDER BY store_location;

--14. TOTAL REVENUE BASED ON THE TIME OF THE DAY (TIME BUCKETS)- 
--First check the earliest and latest transaction times.
SELECT
     MIN (transaction_time),
     Max (transaction_time)
FROM retails.sales.brightcoffee;
--6:00 -11:59:59 = Morning
--12:00 - 16:59:59 = Afternoon
--17:00 - 19:59:59 = Evening
--After 20:00 = Night 

SELECT
      --transaction_time,
      --product_category,
      CASE 
         WHEN transaction_time BETWEEN '6:00:00' AND '11:59:59' THEN 'Morning'
         WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
         WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
         ELSE 'Night'
      END AS time_bucket,
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
 FROM retails.sales.brightcoffee
 GROUP BY ALL;

--15. NUMBER OF TRANSACTIONS PER TIME BUCKET 
SELECT
      CASE 
         WHEN transaction_time BETWEEN '6:00:00' AND '11:59:59' THEN 'Morning'
         WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
         WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
         ELSE 'Night'
      END AS time_bucket,
      COUNT (transaction_id) AS Total_Transactions
 FROM retails.sales.brightcoffee
 GROUP BY ALL
 ORDER BY time_bucket;

 --16 DATE EXTRACTION (MONTH NAME, MONTH_ID, DAY_NAME)
 SELECT
      transaction_date,
      YEAR (transaction_date) AS year,
      MONTHNAME (transaction_date) AS month_name,
      MONTH (transaction_date) AS month_number,
      DATE_FORMAT (transaction_date, 'yyyy-MM') AS month_id,
      DAYNAME (transaction_date) AS day_name,
      DAYOFWEEK (transaction_date) AS day_number
FROM retails.sales.brightcoffee; 
--------------------------------------------------------------------------
--17. COMBINE ALL THE CODES ABOVE (BUILD ONE BIG TABLE)

SELECT
      transaction_id,
      transaction_date,
      YEAR (transaction_date) AS year,
      MONTHNAME (transaction_date) AS month_name,
      MONTH (transaction_date) AS month_number,
      DATE_FORMAT (transaction_date, 'yyyy-MM') AS month_id,
      DAYNAME (transaction_date) AS day_name,
      DAYOFWEEK (transaction_date) AS day_number,
      product_category,
      product_type,
      product_detail,
      store_location,
      CASE 
         WHEN transaction_time BETWEEN '6:00:00' AND '11:59:59' THEN 'Morning'
         WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
         WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
         ELSE 'Night'
      END AS time_bucket,
      COUNT (transaction_id) AS Total_Transactions,
      SUM(transaction_qty) AS Total_Units_Sold,
      SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
 FROM retails.sales.brightcoffee
 GROUP BY ALL;
 
