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
--Excercise 7
