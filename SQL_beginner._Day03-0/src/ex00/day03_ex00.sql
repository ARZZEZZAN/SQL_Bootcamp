SELECT
    menu.pizza_name AS pizza_name,
    menu.price AS price,
    pizzeria.name AS pizzeria_name,
    person_visits.visit_date
FROM person_visits
    JOIN menu ON menu.pizzeria_id = person_visits.pizzeria_id
    JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
    JOIN person ON person.id = person_visits.person_id
WHERE (
        price BETWEEN 800 AND 1000
    )
    AND person_visits.person_id = 3
ORDER BY pizza_name, price, pizzeria_name