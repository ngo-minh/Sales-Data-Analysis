USE retail_data;

-- viewing all data in table
SELECT *
FROM retail_sales_dataset;

-- update column name
ALTER TABLE retail_sales_dataset 
CHANGE COLUMN `Total Amount` total_amount int;

ALTER TABLE retail_sales_dataset 
CHANGE COLUMN `Product Category` product_category VARCHAR(255);


-- total revenue by month
SELECT 
	extract(MONTH FROM retail_sales_dataset.date) AS months,
    SUM(total_amount) AS total_amount_per_months
FROM
	retail_sales_dataset
GROUP BY
	months
ORDER BY months;


-- age range relation ship with product category and total revenue per category

SELECT
	CASE
		WHEN age between 15 AND 19 THEN '15-19'
        WHEN age between 20 AND 29 THEN '20s'
        WHEN age between 30 AND 39 THEN '30s'
        WHEN age between 40 AND 49 THEN '40s'
        WHEN age between 50 AND 59 THEN '50s'
        WHEN age between 60 AND 69 THEN '60s'
        WHEN age between 70 AND 79 THEN '70s'
        WHEN age between 80 AND 89 THEN '80s'
        WHEN age between 90 AND 99 THEN '90s'
		ELSE 'other'
	END AS age_range,
    product_category AS category,
    SUM(total_amount) AS total_amount_per_category,
    SUM(quantity) AS quantity_per_category
FROM 
	retail_sales_dataset
GROUP BY 
	age_range, 
    category
ORDER BY age_range DESC;


-- Checking SUM of quantity just incase

WITH AgeCategorySums AS (
    SELECT
        CASE
            WHEN age BETWEEN 15 AND 19 THEN '15-19'
            WHEN age BETWEEN 20 AND 29 THEN '20s'
            WHEN age BETWEEN 30 AND 39 THEN '30s'
            WHEN age BETWEEN 40 AND 49 THEN '40s'
            WHEN age BETWEEN 50 AND 59 THEN '50s'
            WHEN age BETWEEN 60 AND 69 THEN '60s'
            WHEN age BETWEEN 70 AND 79 THEN '70s'
            WHEN age BETWEEN 80 AND 89 THEN '80s'
            WHEN age BETWEEN 90 AND 99 THEN '90s'
            ELSE 'other'
        END AS age_range,
        product_category AS category,
        SUM(quantity) AS quantity_sum
    FROM 
        retail_sales_dataset
    GROUP BY 
        age_range, 
        category
)

-- Outer query to sum the quantity sums from the subquery
SELECT
    SUM(quantity_sum) AS total_quantity_sum
FROM
    AgeCategorySums;
    
    
-- Distribution of customers by gender and age

SELECT
	CASE
		WHEN age between 15 AND 19 THEN '15-19'
        WHEN age between 20 AND 29 THEN '20s'
        WHEN age between 30 AND 39 THEN '30s'
        WHEN age between 40 AND 49 THEN '40s'
        WHEN age between 50 AND 59 THEN '50s'
        WHEN age between 60 AND 69 THEN '60s'
        WHEN age between 70 AND 79 THEN '70s'
        WHEN age between 80 AND 89 THEN '80s'
        WHEN age between 90 AND 99 THEN '90s'
		ELSE 'other'
	END AS age_range,
    gender,
    SUM(total_amount) AS total_amount_per_age_and_gender,
    SUM(quantity) AS quantity,
    product_category
FROM
	retail_sales_dataset
GROUP BY 
	age_range, gender, product_category
ORDER BY
	age_range ASC;

-- Most popular product categories for each gender
SELECT 
    gender,
    (SELECT product_category 
     FROM retail_sales_dataset t2 
     WHERE t1.Gender = t2.Gender 
     GROUP BY Gender, product_category 
     ORDER BY COUNT(*) DESC 
     LIMIT 1) AS MostPopularCategory
FROM 
    retail_sales_dataset t1
GROUP BY 
    gender;

-- avg basket size
SELECT
	AVG(total_amount) AS average_amount,
    AVG(quantity) AS average_quantity
FROM retail_sales_dataset;
    
