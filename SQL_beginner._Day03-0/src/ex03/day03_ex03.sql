WITH z1 AS(
        SELECT
            pizzeria.name AS pizzeria_name
        FROM person_visits
            JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
            JOIN person ON person_visits.person_id = person.id
        WHERE
            person.gender = 'female'
    ),
    z2 AS (
        SELECT
            pizzeria.name AS pizzeria_name
        FROM person_visits
            JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
            JOIN person ON person_visits.person_id = person.id
        WHERE
            person.gender = 'male'
    ) (
        SELECT *
        FROM z1
        EXCEPT ALL
        SELECT *
        FROM z2
    )
UNION ALL (
    SELECT *
    FROM z2
    EXCEPT ALL
    SELECT *
    FROM z1
)
ORDER BY pizzeria_name