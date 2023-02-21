CREATE OR REPLACE VIEW V_PRICE_WITH_DISCOUNT AS 
	(
	    SELECT
	        person.name,
	        menu.pizza_name,
	        price,
	        ROUND(price - price * 0.1, 0) AS discount_price
	    FROM person_order
	        JOIN menu ON menu.id = person_order.menu_id
	        JOIN person ON person.id = person_order.person_id
	    ORDER BY
	        person.name,
	        menu.pizza_name
	);
; 