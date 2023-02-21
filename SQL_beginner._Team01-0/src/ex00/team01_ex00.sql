WITH last_rate AS (SELECT c.id, rate_to_usd
				   FROM currency c
							RIGHT JOIN (SELECT id, MAX(updated) AS upd
										FROM currency
										GROUP BY id) up ON (up.id = c.id AND up.upd = c.updated)),
	 new_currency AS (SELECT cur.idd,
							 (CASE WHEN cur.name IS NULL THEN 'not defined' ELSE cur.name END)    AS name,
							 (CASE WHEN cur.rate_to_usd IS NULL THEN 1 ELSE rate.rate_to_usd END) AS rate_to_usd,
							 ROW_NUMBER() OVER ( )                                                AS day_curr
					  FROM (SELECT id AS idd, name AS name, rate_to_usd, updated AS up
							FROM currency
							UNION ALL
							SELECT currency_id AS idd, (NULL) AS name, (NULL) AS rate_to_usd, updated AS up
							FROM balance
							WHERE currency_id = 210
							ORDER BY idd, up) AS cur
							   LEFT JOIN last_rate rate ON rate.id = cur.idd),
	 new_balance AS (SELECT user_id, money, type, currency_id, ROW_NUMBER() OVER ( ) AS day_curr
					 FROM (SELECT user_id, money, type, currency_id
						   FROM balance
						   ORDER BY currency_id, updated) AS new_bal),
	 balance_without_sum AS (SELECT DISTINCT b.user_id,
											 b.type,
											 b.money,
											 (CASE WHEN nc.name IS NULL THEN 'not defined' ELSE nc.name END)       AS name,
											 (CASE WHEN rate_to_usd IS NULL THEN 1 ELSE rate_to_usd END)           AS rate_to_usd,
											 b.money * (CASE WHEN rate_to_usd IS NULL THEN 1 ELSE rate_to_usd END) AS total_volume_in_usd
							 FROM new_balance b
									  LEFT JOIN new_currency nc ON nc.idd = b.currency_id),
	 balance_with_sum AS (SELECT user_id,
								 type,
								 SUM(money)                            AS volume,
								 name,
								 SUM(rate_to_usd) / COUNT(rate_to_usd) AS last_rate_to_usd,
								 SUM(total_volume_in_usd)              AS total_volume_in_usd
						  FROM balance_without_sum
						  GROUP BY user_id, type, name)
SELECT (CASE WHEN u.name IS NULL THEN 'not defined' ELSE u.name END)         AS name,
	   (CASE WHEN u.lastname IS NULL THEN 'not defined' ELSE u.lastname END) AS lastname,
	   type,
	   volume,
	   bws.name                                                              AS currency_name,
	   last_rate_to_usd,
	   total_volume_in_usd
FROM "user" u
		 RIGHT JOIN balance_with_sum bws ON u.id = bws.user_id
ORDER BY name DESC, lastname, type;

