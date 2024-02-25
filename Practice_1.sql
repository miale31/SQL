-- Excercise 1
select name from city
where countrycode = 'USA'
and population > 120000;

-- Excercise 2
select * from city
where countrycode = 'JPN';

-- Excercise 3
select distinct city, state from station;

-- Exercise 4
select city from station
where city like 'A%' or city like 'E%' or city like 'I%' or city like 'O%' or city like 'U%';

-- Excercise 5
select distinct city from station
where city like '%a' or city like '%e' or city like '%i' or city like '%o' or city like '%u';

-- Excercise 6
select distinct city from station
where not (city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' or city like 'u%'); 

-- Excercise 7
select name from Employee
order by name;










