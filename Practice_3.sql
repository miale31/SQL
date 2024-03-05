--Excercise 3
SELECT
manufacturer,
concat('$',round(sum(total_sales)/1000000,0),' ','million') as sales
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) DESC, manufacturer;
