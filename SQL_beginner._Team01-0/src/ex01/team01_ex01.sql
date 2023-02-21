-- insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
-- insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');
-- insert into currency values (300, 'JPY', 0.0087, '2022-03-03 13:31');
-- insert into currency values (300, 'JPY', 0.0079, '2022-03-01 13:31');
-- insert into balance values (3, 500,2, 300, '2022-01-09 13:31');

CREATE OR REPLACE FUNCTION rate
(IN id_car INTEGER, IN pdate TIMESTAMP)
    RETURNS NUMERIC
    LANGUAGE plpgsql
    IMMUTABLE
AS $$
BEGIN
    RETURN (SELECT rate_to_usd
        FROM ((SELECT rate_to_usd, updated
             FROM currency c
             WHERE (c.updated <= pdate AND c.id = id_car)
             ORDER BY c.updated DESC
             LIMIT 1)
            UNION
            (SELECT rate_to_usd, updated
             FROM currency c
             WHERE (c.updated > pdate AND c.id = id_car)
             ORDER BY c.updated
             LIMIT 1)
    ORDER BY updated
            LIMIT 1) AS a);
END
$$ ;

WITH common_table AS (SELECT (CASE WHEN u.name IS NULL THEN 'not defined' ELSE u.name END)         AS name,
       (CASE WHEN u.lastname IS NULL THEN 'not defined' ELSE u.lastname END) AS lastname,
       b.user_id, b.currency_id, b.name AS currency_name, b.money, b.updated
FROM "user" u
RIGHT JOIN (SELECT DISTINCT b.user_id, b.currency_id, name, money, b.updated
FROM currency
INNER JOIN balance b on currency.id = b.currency_id) b ON b.user_id = u.id)

SELECT name, lastname, currency_name, (money * rate(currency_id, updated)) as currency_in_usd
FROM common_table
ORDER BY name DESC, lastname, currency_name;
