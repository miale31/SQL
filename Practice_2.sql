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
-- Excercise 9
-- Excercise 10






