--Excercise 1
select country.continent, floor(avg(city.population))
from country
Inner join city on city.countrycode = country.code
group by country.continent;

--Excercise 2
SELECT
round((sum(case when texts.signup_action = 'Confirmed' then 1 end))/
(count(texts.signup_action)),2) as confirm_rate
FROM emails
left join texts on emails.email_id = texts.email_id;

--Excercise 3
--Excercise 4
--Excercise 5
--Excercise 6
--Excercise 7
