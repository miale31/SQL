-- Excercise 1
select distinct city from station
where id%2=0;
-- Excercise 2
select count(city) - count(distinct city) from station;

-- Excercise 3

-- Excercise 4
SELECT round(cast(sum (item_count * order_occurrences)/ sum (order_occurrences) as decimal),1) as mean FROM items_per_order;

-- Excercise 5
SELECT candidate_id FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3;

-- Excercise 6
-- Excercise 7

-- Excercise 8
SELECT
  manufacturer,
  COUNT(drug) AS number_of_drugs, 
  ABS(SUM(total_sales - cogs)) as total_loss
FROM pharmacy_sales
WHERE total_sales - cogs <=0
GROUP BY manufacturer
ORDER BY total_loss DESC;

-- Excercise 9
SELECT * FROM CINEMA
WHERE NOT ID%2 = 0
AND DESCRIPTION <> 'BORING'
ORDER BY RATING DESC;

-- Excercise 10
SELECT 
TEACHER_ID,
COUNT(DISTINCT SUBJECT_ID) AS CNT 
FROM TEACHER
GROUP BY TEACHER_ID;

-- Excercise 11
SELECT
USER_ID,
COUNT(FOLLOWER_ID) AS FOLLOWERS_COUNT
FROM FOLLOWERS
GROUP BY USER_ID;

--Excercise 12
SELECT CLASS FROM COURSES
HAVING COUNT(CLASS)>=5;








