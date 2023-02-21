SELECT
    person.name AS name,
    pizza_name,
    price, (
        menu.price - (
            menu.price / 100 * person_discounts.discount
        )
    ):: integer AS discount_price,
    pizzeria.name AS pizzeria_name
FROM person
    JOIN person_order ON person_order.person_id = person.id
    JOIN menu ON person_order.menu_id = menu.id
    JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
    JOIN person_discounts ON person_discounts.person_id = person_order.person_id
ORDER BY name, pizza_name;