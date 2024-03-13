-- Excercise 1
select 
  COUNT(*) as duplicate_companies
FROM (SELECT
company_id, 
title,
description,
count(job_id)
FROM job_listings
group by company_id, title, description
HAVING count(job_id)=2) AS SUBQUERIES
;

-- Excercise 2
WITH cte AS (
    SELECT 
        category, 
        product,
        SUM(spend) AS total_spend,
        RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS Ranking
    FROM 
        product_spend
    WHERE 
        EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY 
        category, 
        product
)

SELECT 
    category, 
    product, 
    total_spend
FROM 
    cte
WHERE 
    Ranking IN (1, 2)
ORDER BY 
    category, 
    total_spend desc,
    product;

-- Excercise 3
WITH call_count AS  
  (
  SELECT
  policy_holder_id,
  count(case_id)
  FROM callers
  GROUP BY policy_holder_id
  HAVING count(case_id) >=3)

SELECT 
  COUNT(policy_holder_id)
FROM call_count;

-- Excercise 4
WITH likes AS
  (SELECT 
    DISTINCT page_id,
    count(liked_date) as no_likes
  FROM page_likes
  GROUP BY page_id)
SELECT
  page_id
FROM likes
WHERE no_likes is NULL
ORDER BY page_id;

-- Excercise 6
# Write your MySQL query statement below

select 
    DATE_FORMAT(trans_date, '%Y-%m') as 'month',
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount    
from transactions
;

-- Exercise 7
SELECT
    sales.product_id,
    sales.year AS first_year,
    SUM(sales.quantity) AS quantity,
    SUM(sales.price) AS price
FROM
    sales
JOIN
    (SELECT product_id, MIN(year) AS min_year
     FROM sales
     GROUP BY product_id) AS subquery
ON
    sales.product_id = subquery.product_id
    AND sales.year = subquery.min_year
GROUP BY
    sales.product_id;

