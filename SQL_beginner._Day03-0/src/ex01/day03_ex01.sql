SELECT menu.id
FROM menu
WHERE menu.id NOT IN (
        SELECT menu_id
        FROM person_order
    )
ORDER BY menu.id;