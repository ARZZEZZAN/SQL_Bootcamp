WITH nametb1 AS (
	SELECT menu.pizza_name AS pizza_name, pizzeria.name AS pizzeria_name, person.name FROM person_order
	JOIN person ON person.id = person_order.person_id
	JOIN menu ON menu.id = person_order.menu_id
	JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
	WHERE person.gender = 'female' 
)
SELECT name AS person_name FROM nametb1
WHERE pizza_name = 'cheese pizza' AND name 
		IN (SELECT name FROM nametb1 WHERE pizza_name = 'pepperoni pizza')