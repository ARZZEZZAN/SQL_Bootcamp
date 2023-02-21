SELECT object_id, object_name FROM
	(SELECT id AS object_id, pizza_name AS object_name FROM menu
	 UNION 
	 SELECT id AS object_id, name AS object_name FROM person) AS pv
ORDER BY object_id, object_name
	
