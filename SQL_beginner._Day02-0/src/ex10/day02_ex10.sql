SELECT n1.name AS person_name1,
	   n2.name AS person_name2,
	   n1.address AS common_address
FROM person AS n1
JOIN person AS n2
ON n1.address = n2.address
WHERE n1.id > n2.id
ORDER BY 1, 2, 3;