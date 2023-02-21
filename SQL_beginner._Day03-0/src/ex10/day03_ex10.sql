INSERT INTO
    person_order(
        id,
        person_id,
        menu_id,
        order_date
    )
VALUES ( (
            SELECT MAX(id) + 1
            FROM person_order
        ), (
            SELECT id
            FROM person
            WHERE name = 'Denis'
            LIMIT 1
        ), (
            SELECT id
            FROM menu
            WHERE
                pizza_name = 'sicilian pizza'
            LIMIT 1
        ), '2022-02-24'
    );

INSERT INTO
    person_order(
        id,
        person_id,
        menu_id,
        order_date
    )
VALUES ( (
            SELECT MAX(id) + 1
            FROM person_order
        ), (
            SELECT id
            FROM person
            WHERE name = 'Irina'
            LIMIT 1
        ), (
            SELECT id
            FROM menu
            WHERE
                pizza_name = 'sicilian pizza'
            LIMIT 1
        ), '2022-02-24'
    );