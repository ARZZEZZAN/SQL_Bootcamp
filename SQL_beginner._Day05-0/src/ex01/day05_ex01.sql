SET enable_seqscan to off;

EXPLAIN ANALYZE
SELECT
    pizza_name,
    name AS pizzeria_name
FROM menu
    JOIN pizzeria ON menu.pizzeria_id = pizzeria.id;