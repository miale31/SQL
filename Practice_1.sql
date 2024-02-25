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

-- Excercise 8
select name from Employee
where salary > 2000
and months < 10
order by employee_id;

-- Excercise 9
select product_id from Products
where low_fats = 'Y' and recyclable = 'Y';

-- Excercise 10
select name from Customer
where not referee_id = 2 or referee_id is null;

-- Excercise 11
select name, population, area from World
where area >= 3000000
or population >= 25000000;

-- Excercise 12
select distinct author_id as id from Views
where author_id = viewer_id
order by author_id;

-- Excercise 13
SELECT part, assembly_step FROM parts_assembly
where finish_date is null;

-- Excercise 14
select * from lyft_drivers
where yearly_salary <= 30000 or yearly_salary >= 70000;

-- Excercise 15
select * from uber_advertising
where year = 2019
and money_spent > 100000;
















