--Excercise 1
select country.continent, floor(avg(city.population))
from country
Inner join city on city.countrycode = country.code
group by country.continent;

--Excercise 2
SELECT
round((sum(case when texts.signup_action = 'Confirmed' then 1 else 0 end))/
count(texts.signup_action),2) as confirm_rate
FROM emails
left join texts on emails.email_id = texts.email_id;

--Excercise 3
SELECT 
agebreak.age_bucket,
round((sum(case when act.activity_type = 'send' then act.time_spent else 0 end)/
(sum(case when act.activity_type = 'send' then act.time_spent else 0 end)+sum(case when act.activity_type = 'open' then act.time_spent else 0 end)))*100.0,2) as send_perc,
round((sum(case when act.activity_type = 'open' then act.time_spent else 0 end)/
(sum(case when act.activity_type = 'send' then act.time_spent else 0 end)+sum(case when act.activity_type = 'open' then act.time_spent else 0 end)))*100.0,2) as open_perc
FROM activities as act
left join age_breakdown as agebreak
ON act.user_id = agebreak.user_id
group by agebreak.age_bucket;

--Excercise 4
SELECT
  customer_contracts.customer_id
FROM 
  customer_contracts
LEFT JOIN
  products ON customer_contracts.product_id = products.product_id
group by 
  customer_contracts.customer_id
having 
  count(DISTINCT products.product_category) = 3;

--Excercise 5
select 
    emp.employee_id, 
    emp.name as name,
    count(emp.reports_to) as reports_count,
    round(avg(emp.age),0) as average_age
from employees as emp
left join employees as man on emp.reports_to = man.employee_id
having count(man.name) >= 2;

--Excercise 6
SELECT 
    products.product_name,
    SUM(orders.unit) AS unit
FROM 
    Products
LEFT JOIN 
    Orders ON products.product_id = orders.product_id
WHERE 
    (EXTRACT(MONTH FROM orders.order_date)) = 2
GROUP BY 
    products.product_name, EXTRACT(MONTH FROM orders.order_date)
HAVING
    SUM(orders.unit) >= 100
;

--Excercise 7
SELECT 
  pages.page_id
FROM pages
LEFT JOIN
  page_likes as likes
ON
  pages.page_id = likes.page_id
group by pages.page_id
having count(likes.liked_date)=0
order by pages.page_id;

-------------------------------------

--Mid course test
--Q1
select 
	distinct replacement_cost
from film
order by replacement_cost;

--Q2
select
	sum(case when replacement_cost between 9.99 and 19.99 then 1 else 0
	end) as low,
	sum(case when replacement_cost between 20.00 and 24.99 then 1 else 0
	end) as medium,
	sum(case when replacement_cost between 25.00 and 29.99 then 1 else 0
	end) as high	
from film;

--Q3
select 
	film.title,
	descrip.name as category_name,
	film.length
from film
left join film_category as cate 
	on film.film_id = cate.film_id
left join category as descrip
	on cate.category_id = descrip.category_id
where descrip.name in ('Drama','Sports')
order by film.length desc;

-- Q4
select 
	descrip.name as category_name,
	count(film.title) as total_no
from film
left join film_category as cate 
	on film.film_id = cate.film_id
left join category as descrip
	on cate.category_id = descrip.category_id
group by descrip.name
order by count(film.title) desc;

--Q5
select 
	actor.first_name || ' ' || actor.last_name as full_name,
	count(actor.first_name) as total_film
from actor
left join film_actor as film 
on
	actor.actor_id = film.actor_id
group by full_name
order by total_film desc;
	
-- Q5 - WAY 2 
select 
	actor.first_name || ' ' || actor.last_name as full_name,
	count(cast (film.film_id as TEXT)) as total_film
from actor
left join film_actor as film 
on
	actor.actor_id = film.actor_id
group by full_name
order by total_film desc;

-- Q6
SELECT 
	COUNT(addr.address) total_no
FROM ADDRESS as addr
LEFT JOIN CUSTOMER as cus
	ON addr.address_id = cus.address_id
WHERE cus.customer_id IS NULL;

-- Q7
select 
	city.city,
	sum(pay.amount) as rev 
from city
left join address
	on address.city_id = city.city_id
left join customer as cus
	on cus.address_id = address.address_id
left join payment as pay
	on cus.customer_id = pay.customer_id
group by city.city
order by rev desc;

--Q8

select 
	city.city || ', '|| country.country as "city,country",
	sum(pay.amount) as rev
from city
left join country
	on city.country_id = country.country_id
left join address
	on address.city_id = city.city_id
left join customer as cus
	on cus.address_id = address.address_id
left join payment as pay
	on cus.customer_id = pay.customer_id
group by "city,country"
order by rev desc;


