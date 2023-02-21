WITH orders AS (
        SELECT
            name,
            COUNT(*) AS count,
            'order' AS action_type
        FROM person_order
            JOIN menu ON menu.id = person_order.menu_id
            JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
        GROUP BY name
        ORDER BY count DESC
        LIMIT 3
    ), visits AS (
        SELECT
            pizzeria.name,
            COUNT(*) AS count,
            'visit' AS action_type
        FROM person_visits
            JOIN person ON person.id = person_visits.person_id
            JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
        GROUP BY pizzeria.name
        ORDER BY count DESC
        LIMIT 3
    ) (
        SELECT *
        FROM orders
    )
UNION (
    SELECT *
    FROM visits
)
ORDER BY
    action_type,
    count DESC;