SELECT
    person.name,
    COUNT(person_id) AS count_of_visits
FROM person_visits
    JOIN person ON person.id = person_visits.person_id
GROUP BY person.name
HAVING COUNT(person.id) > 3;