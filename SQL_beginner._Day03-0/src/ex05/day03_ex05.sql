SELECT
    pizzeria.name AS pizzeria_name
FROM pizzeria
    JOIN person_visits ON person_visits.pizzeria_id = pizzeria.id
    JOIN person ON person_visits.person_id = person.id
WHERE person.name = 'Andrey'
EXCEPT
SELECT
    pizzeria.name AS pizzeria_name
FROM menu
    JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
    JOIN person_order ON person_order.menu_id = menu.id
    JOIN person on person_order.person_id = person.id
WHERE person.name = 'Andrey'
ORDER BY pizzeria_name;