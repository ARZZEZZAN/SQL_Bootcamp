WITH z1 AS(
        SELECT
            pizzeria.name AS pizzeria_name
        FROM menu
            JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
            JOIN person_order ON person_order.menu_id = menu.id
            JOIN person ON person_order.person_id = person.id
        WHERE
            person.gender = 'female'
    ),
    z2 AS (
        SELECT
            pizzeria.name AS pizzeria_name
        FROM menu
            JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
            JOIN person_order ON person_order.menu_id = menu.id
            JOIN person ON person_order.person_id = person.id
        WHERE
            person.gender = 'male'
    ) (
        SELECT *
        FROM z2
        EXCEPT
        SELECT *
        FROM z1
    )
UNION (
    SELECT *
    FROM z1
    EXCEPT
    SELECT *
    FROM z2
)
ORDER BY pizzeria_name