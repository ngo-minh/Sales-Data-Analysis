USE retail_data;

-- viewing all data in table
SELECT *
FROM retail_sales_dataset;

-- update column name
ALTER TABLE retail_sales_dataset 
CHANGE COLUMN `Total Amount` total_amount int;

-- total revenue by month
SELECT 
	extract(MONTH FROM retail_sales_dataset.date) AS months,
    SUM(total_amount) AS total_amount_per_months
FROM
	retail_sales_dataset
GROUP BY
	months
ORDER BY months;


-- 