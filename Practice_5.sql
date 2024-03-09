--Excercise 1
select country.continent, floor(avg(city.population))
from country
Inner join city on city.countrycode = country.code
group by country.continent;

--Excercise 2
--Excercise 3
--Excercise 4
--Excercise 5
--Excercise 6
--Excercise 7
