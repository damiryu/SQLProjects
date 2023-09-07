/*SELECT distinct
	inventory.inventory_id
FROM
	inventory INNER JOIN rental
        ON inventory.inventory_id = rental.inventory_id
*/


/*SELECT distinct
			inventory.inventory_id,
            inventory.store_id,
            film.title,
            film.description
FROM
	inventory INNER JOIN film
		ON inventory.film_id = film.film_id
*/


/*SELECT distinct
    film.title,
    COUNT(film_actor.actor_id) as number_of_actors
FROM film LEFT JOIN film_actor
	ON film.film_id = film_actor.film_id
GROUP BY film.title
*/

/*SELECT 
	film.film_id,
	actor.first_name,
    actor.last_name,
    film.title
FROM actor INNER JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
		INNER JOIN film
			ON film_actor.film_id = film.film_id
 ORDER BY 
	film_id
*/

/*SELECT DISTINCT 
	film.title,
    film.description
FROM film INNER JOIN inventory
	ON film.film_id = inventory.film_id
		INNER JOIN store
			ON inventory.store_id = store.store_id AND inventory.store_id = 2
*/

/*SELECT
	'investor' as type,
    first_name,
    last_name
FROM investor
	UNION 
SELECT
	'staff' as type,
    first_name,
    last_name
FROM staff
*/



-- manager's name at each store, street adress, district, city and country of each property.
/*SELECT 
	staff.store_id,
	staff.first_name,
    staff.last_name,
    address.address,
    address.address2,
    address.district,
    city.city,
    country.country
FROM staff INNER JOIN address
	ON staff.address_id = address.address_id
		INNER JOIN city
			ON address.city_id = city.city_id
				INNER JOIN country
					ON city.country_id = country.country_id
*/


-- inventory item, store_id, inventory_id, name of film, film's rating, it's rental rate and replacement cost
/*SELECT 
	inventory.store_id,
    inventory.inventory_id,
    film.title AS name_of_film,
    film.rating,
    film.rental_rate,
    film.replacement_cost
FROM film INNER JOIN inventory
	ON film.film_id = inventory.film_id
*/


-- number of inventory items with each store rating at each store
/*SELECT 
	film.rating,
	COUNT(CASE WHEN inventory.store_id = 1 THEN film.title END) AS store1_films_with_this_rating,
    COUNT(CASE WHEN inventory.store_id = 2 THEN film.title END) AS store2_films_with_this_rating
FROM film INNER JOIN inventory
	ON film.film_id = inventory.film_id
GROUP BY
	film.rating
*/



-- average and total replacement cost sliced by store and film category
/*SELECT
	film_category.category_id,
    AVG(replacement_cost) AS average_replacement_cost,
    SUM(replacement_cost) AS total_replacement_cost
FROM film INNER JOIN film_category
	ON film.film_id = film_category.film_id
GROUP BY
	film_category.category_id

*/

-- all customer names, which store they go to, active status, full address (street address, city and country)
/*SELECT 	
	customer.first_name,
    customer.last_name,
    customer.store_id, 
    CASE 
		WHEN customer.active = 1 then 'active'
		WHEN customer.active = 0 then 'inactive'
        ELSE 'NA'
        END AS status,
    address.address,
    city.city,
    country.country
FROM customer LEFT JOIN address
	ON customer.address_id = address.address_id
		LEFT JOIN city
			ON address.city_id = city.city_id
				LEFT JOIN country
					ON city.country_id = country.country_id
*/
					
    
-- customer names, total lifetime rentals, total payments collected by each customer saved by total lifetime value with the most valuable customer at the top.
/*SELECT
	customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_rentals,
    SUM(payment.amount) AS total_lifetime_value
FROM customer LEFT JOIN payment
	ON customer.customer_id = payment.customer_id
		LEFT JOIN rental
			ON payment.rental_id = rental.rental_id
GROUP BY
	customer.first_name, customer.last_name
ORDER BY
	SUM(payment.amount) DESC
*/

    
    
-- board of advisors and investors, name of investor company
/*SELECT 
	'Advisor' as type,
    advisor.first_name,
    advisor.last_name,
    investor.company_name
FROM advisor LEFT JOIN investor 
	ON advisor.first_name = investor.first_name
			UNION
SELECT
	'Investor' as type,
    first_name,
    last_name,
    company_name
FROM investor
*/


-- most awarded actors, of all actors with three types of award, for what % of them do we carry a film, then for two types and for one type.
SELECT
CASE
	WHEN actor_award.awards = 'Emmy, Oscar, Tony' THEN '3 Awards'
    WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') THEN '2 Awards'
    ELSE '1 Award'
    END AS Awards_won,
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_award 
FROM actor_award
GROUP BY
	CASE
	WHEN actor_award.awards IN ('Emmy, Oscar, Tony') ThEN '3 Awards'
    WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') ThEN '2 Awards'
    ELSE '1 Award'
    END



LIMIT 5000