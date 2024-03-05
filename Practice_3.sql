-- Excercise 1
select
name
from students
where marks >75
order by right(name,3), ID;

-- Excercise 2


--Excercise 3
SELECT
manufacturer,
concat('$',round(sum(total_sales)/1000000,0),' ','million') as sales
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) DESC, manufacturer;

-- Excercise 4
SELECT
extract (month from submit_date) as mth,
product_id as product, 
round(avg(stars),2) as avg_star
FROM reviews
group by extract (month from submit_date), product_id
order by extract (month from submit_date), product_id;

-- Excercise 5
SELECT
sender_id,
count(content) as no_message
FROM messages
group by sender_id, extract(year from sent_date), extract(month from sent_date)
having (extract(year from sent_date)) = 2022 and extract(month from sent_date) = 08
order by count(content) desc
limit 2;

-- Excercise 6
select tweet_id from Tweets
where length(content)>15;

-- Excercise 7
select
activity_date as day,
count(distinct(user_id)) as active_users
from activity
where activity_date between ('2019-06-28') and ('2019-07-27')
group by activity_date;



