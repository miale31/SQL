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
