-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, district
FROM customer
Join address
ON customer.address_id = address.address_id
GROUP BY district, first_name, last_name
HAVING district = 'Texas';
-- ANSWER: 5 people live in texas





-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
SELECT first_name, last_name, COUNT(amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, amount
HAVING COUNT(amount) > 6.99
ORDER BY COUNT(amount) DESC;







-- 3. Show all customers names who have made at least 4 payments(use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
 	SELECT customer_id
 	FROM payment
 	GROUP BY customer_id
	HAVING COUNT(customer_id) < 4
);
-- I Need to figure out how to group or count by the
-- total of customer id's in payments and i only keep getting
-- the actual id nums above 4, also tried this with payment_id.






-- 4. List all customers that live in Nepal (use the city
-- table)
SELECT first_name, last_name
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- ANSWER: 1 person, Kevin Schuler.








-- 5. Which staff member (first/last name) had the most
--transactions?
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
HAVING COUNT(payment_id) > 200
ORDER BY COUNT(payment_id) DESC;

-- ANSWER: Jon Stephens, 7304 transactions.






-- 6. Which movie title(s) has been rented the most?
SELECT title, COUNT(rental_id)
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
HAVING COUNT(rental_id) > 5
ORDER BY COUNT(rental_id) DESC;

-- ANSWER: Bucket Brotherhood, rented 34 times.







-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
 	SELECT customer_id
 	FROM payment
	GROUP BY customer_id, amount
 	HAVING amount > 6.99 AND COUNT(payment_id) <> 1
);
-- ANSWER: 266 total customers.







-- 8. Which employee gave out the most free rentals?
SELECT first_name, last_name
FROM staff
WHERE staff_id IN (
	SELECT staff_id
	FROM payment
	GROUP BY staff_id, amount
	HAVING amount <= 0
);

SELECT amount, COUNT(staff_id), staff_id
FROM payment
GROUP BY staff_id, amount
HAVING amount <= 0;
-- ANSWER: Mike hillyer, 15 free rentals. I know i did this wrong also.


