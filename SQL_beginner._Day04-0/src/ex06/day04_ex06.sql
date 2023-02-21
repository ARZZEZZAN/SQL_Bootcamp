CREATE MATERIALIZED VIEW MV_DMITRIY_VISITS_AND_EATS 
AS 
	 (
	    SELECT
	        pizzeria.name AS pizzeria_name
	    FROM pizzeria
	        JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
	        JOIN menu ON menu.pizzeria_id = pizzeria.id
	    WHERE
	        person_visits.visit_date = '2022-01-08'
	        AND person_visits.person_id = 9
	        AND menu.price < 800
	    ORDER BY pizzeria_name
	);
; 