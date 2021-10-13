-- Joins, MultiJoins, Subqueries


-- Multijoin to find an actor first/last name along with movie title they appear in.
SELECT actor.actor_id, first_name, last_name, film_actor.film_id, title, rating
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
JOIN film
ON film_actor.film_id = film.film_id;



-- Join that will produce first/last name info for customers from Angola.
-- Joining 4 tables together to get this information.
SELECT first_name, last_name, city, country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';



-- Find customer info (first/last, email) where total amount of that
-- customer's payments is greater that $175.
SELECT first_name, last_name, email, SUM(amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
HAVING SUM(amount) > 175.00
ORDER BY SUM(amount) DESC;



-- Subqueries (AKA a query within another query)

-- Find customer information (id, first, last) where the total amount of that 
-- customer's payments is greater than $175, and their id is over 200.

--STEPS
SELECT *
FROM customer
WHERE customer_id > 200;

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id;



-- Adding two queries together
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id;

SELECT customer_id, first_name, last_name, email
FROM customer
WHERE customer_id > 200 AND customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);


-- Find a customer's information (first/last/email) for customers in Angola.
-- that spend $150 or more.
SELECT first_name, last_name, email, country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola' AND customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) >150
);




-- Using a sub query, find all films (title, release date, rating).
-- with a language of 'English'.

SELECT title, release_year, rating
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM "language"
	WHERE "name" = 'English'
);




-- Using a sub query, find all actor who have appeared in more than 25 movies.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN(
	SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
	HAVING COUNT(actor_id) > 25
);



