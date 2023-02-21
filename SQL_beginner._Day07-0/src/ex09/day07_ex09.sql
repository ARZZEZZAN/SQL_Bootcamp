SELECT
    person.address,
    ROUND(
        MAX(age:: numeric) - (
            MIN(age:: numeric) / MAX(age:: numeric)
        ),
        2
    ) AS formula,
    ROUND(AVG(age:: numeric), 2) AS average, (
        SELECT
            CASE
                WHEN ROUND(
                    MAX(age:: integer) - (
                        MIN(age:: integer) / MAX(age:: integer)
                    ),
                    2
                ) > AVG(age:: integer) THEN true
                ELSE false
            END
    ) AS comparison
FROM person
GROUP BY address
ORDER BY address;