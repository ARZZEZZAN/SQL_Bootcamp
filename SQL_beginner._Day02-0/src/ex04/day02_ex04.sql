WITH pizza AS (
	SELECT name, id FROM pizzeria),
	menu AS (
		SELECT pizzeria_id, price, pizza_name FROM menu
		WHERE pizza_name IN ('mushroom pizza','pepperoni pizza')
	)
SELECT menu.pizza_name AS pizza_name, 
			pizza.name AS pizzeria_name,
			menu.price AS price
FROM menu
JOIN pizza ON pizza.id = menu.pizzeria_id
ORDER BY pizza_name, pizzeria_name