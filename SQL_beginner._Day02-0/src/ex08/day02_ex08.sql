SELECT person.name AS name FROM person
JOIN person_order ON person_order.person_id = person.id
JOIN menu ON menu.id = person_order.menu_id
WHERE person.gender = 'male' 
		AND person.address IN('Moscow', 'Samara') 
		AND menu.pizza_name IN('pepperoni pizza', 'mushroom pizza')
ORDER BY name desc;