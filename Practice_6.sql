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
