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

--Ex 4
WITH cte AS
(SELECT 
  *,
  RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) as rankno 

FROM user_transactions)
SELECT
  transaction_date,
  user_id,
  count(product_id) AS purchase_count
FROM cte
WHERE rankno = 1
GROUP BY transaction_date, user_id;

-- Ex 5
SELECT    
  user_id,    
  tweet_date,   
  ROUND(AVG(tweet_count) OVER (
    PARTITION BY user_id     
    ORDER BY tweet_date     
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
  ,2) AS rolling_avg_3d
FROM tweets;

-- Ex6
WITH cte AS
(SELECT 
  *,
  LAG(transaction_timestamp) OVER(PARTITION BY merchant_id,credit_card_id,amount
  ORDER BY transaction_timestamp)
  AS previous_transaction,
  EXTRACT( EPOCH FROM transaction_timestamp -  LAG(transaction_timestamp) OVER(PARTITION BY merchant_id,credit_card_id,amount
  ORDER BY transaction_timestamp))/60 as difference
FROM transactions)
SELECT
COUNT(merchant_id) as payment_count
FROM cte 
WHERE difference <= 10;

-- Ex7
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

-- Ex8
WITH cte AS (
  SELECT 
    artists.artist_name,
    DENSE_RANK() OVER (
      ORDER BY COUNT(songs.song_id) DESC) AS artist_rank
  FROM artists
  INNER JOIN songs
    ON artists.artist_id = songs.artist_id
  INNER JOIN global_song_rank AS ranking
    ON songs.song_id = ranking.song_id
  WHERE ranking.rank <= 10
  GROUP BY artists.artist_name
)

SELECT *
FROM cte
WHERE artist_rank <=5;
