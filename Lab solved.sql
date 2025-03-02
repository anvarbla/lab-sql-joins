-- 1 List the number of films per category.
SELECT c.name as category, count(f.film_id) as number_films from category as c
JOIN film_category as f
ON c.category_id=f.category_id
group  by c.name;
-- 2 Retrieve the store ID, city, and country for each store.
SELECT s.store_id, ci.city, co.country from store as s
JOIN address as a
ON s.address_id=a.address_id
JOIN city as ci
ON a.city_id=ci.city_id
JOIN country as co
on ci.country_id=co.country_id;
-- 3 Calculate the total revenue generated by each store in dollars.
SELECT so.store_id, sum(p.amount) as amount from store as so
JOIN staff as sa
ON so.store_id=sa.store_id
JOIN payment as p
on sa.staff_id = p.staff_id
group by store_id;

-- 4 Determine the average running time of films for each category.
SELECT c.name as category, AVG(f.length) as avg_duration from category as c
JOIN film_category as fc
ON c.category_id = fc.category_id
JOIN film as f
ON fc.film_id=f.film_id
group by c.name;
-- Bonus:

-- 5 Identify the film categories with the longest average running time.
SELECT c.name as category, AVG(f.length) as avg_duration from category as c
JOIN film_category as fc
ON c.category_id = fc.category_id
JOIN film as f
ON fc.film_id=f.film_id
group by c.name
ORDER BY avg_duration DESC
LIMIT 1;
-- 6 Display the top 10 most frequently rented movies in descending order.
SELECT f.title as film, COUNT(r.rental_id) as time_rent from film as f
JOIN inventory as i
ON f.film_id=i.film_id
JOIN rental as r
ON i.inventory_id=r.inventory_id
group by film
order by time_rent DESC
LIMIT 10;
-- 7 Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT f.title as film, s.store_id as store from film as f
JOIN inventory as i
ON f.film_id=i.film_id
JOIN store as s
on i.store_id=s.store_id
WHERE f.title LIKE "%Academy Dinosaue%";
-- 8 Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
SELECT f.title AS film_title,
CASE 
WHEN i.inventory_id IS NOT NULL THEN 'Available'
ELSE 'NOT available'
END AS availability_status
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;