SELECT pizza_name, pizzeria.name AS pizzeria_name FROM person_order
JOIN menu ON menu.id = person_order.menu_id
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
WHERE person_order.person_id IN (4, 1)
ORDER BY pizza_name, pizzeria_name