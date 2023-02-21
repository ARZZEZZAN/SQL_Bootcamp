SELECT object_name DISTINCT FROM
	(SELECT pizza_name AS object_name FROM menu
	 UNION ALL
	 SELECT name AS object_name FROM person) AS pv
ORDER BY object_name