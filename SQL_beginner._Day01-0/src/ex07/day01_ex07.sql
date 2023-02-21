SELECT order_date, CONCAT(person.name, ' (age:', person.age, ')') as person_information 
FROM person
JOIN person_order ON person_order.person_id = person.id
ORDER BY  order_date, person_information;
