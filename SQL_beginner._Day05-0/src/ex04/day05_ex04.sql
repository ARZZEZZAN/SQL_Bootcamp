CREATE UNIQUE INDEX idx_menu_unique ON menu(pizza_name, pizzeria_id);

SET enable_seqscan to off;

EXPLAIN ANALYSE
SELECT
    pizza_name,
    pizzeria_id
FROM menu
WHERE pizza_name = 'cheese_pizza'