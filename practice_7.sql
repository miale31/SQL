--Ex 1
WITH cte AS 
(SELECT 
  EXTRACT(year FROM transaction_date) AS year,
  product_id,
  spend AS curr_year_spend,
  LAG (spend) OVER(PARTITION BY product_id ORDER BY product_id,EXTRACT(year FROM transaction_date))
  AS prev_year_spend
FROM user_transactions)
SELECT
  year,
  product_id,
  curr_year_spend,
  prev_year_spend,
  ROUND((curr_year_spend-prev_year_spend)/prev_year_spend *100,2) AS yoy_rate
  FROM cte
;

--Ex 2
SELECT
  DISTINCT card_name,
  FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) as issued_amount
FROM monthly_cards_issued
ORDER BY
  issued_amount DESC;

--Ex 3
WITH rank AS
(SELECT
  user_id,
  spend,
  transaction_date,
  RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) AS transaction_rank
FROM transactions)

SELECT
  user_id,
  spend,
  transaction_date
FROM rank 
WHERE transaction_rank = 3;

