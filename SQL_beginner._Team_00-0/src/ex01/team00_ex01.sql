CREATE TABLE IF NOT EXISTS nodes (
       point1 VARCHAR(1) NOT NULL,
      point2 VARCHAR(1) NOT NULL,
     cost INTEGER NOT NULL
  );

   INSERT INTO nodes (point1, point2, cost)
   VALUES ('a', 'b', 10), ('b', 'a', 10),
          ('a', 'c', 15), ('c', 'a', 15),
          ('a', 'd', 20), ('d', 'a', 20),
          ('b', 'c', 35), ('c', 'b', 35),
         ('b', 'd', 25), ('d', 'b', 25),
          ('c', 'd', 30), ('d', 'c', 30);

WITH RECURSIVE paths (start, finish, cost, tour) AS (
 SELECT point1, point2, cost, ARRAY[point1, point2]::character varying[]
 FROM nodes
 WHERE point1 = 'a'
 UNION ALL
 SELECT p.start, n.point2, p.cost + n.cost, p.tour || n.point2
 FROM paths p, nodes n
 WHERE p.finish = n.point1
 AND n.point2 NOT IN (SELECT unnest(p.tour))
)
, res AS (
	SELECT MIN(cost) AS cost, tour
	FROM paths
	WHERE start = 'a'
	GROUP BY tour
	HAVING array_length(tour || ARRAY ['a'], 1) = 5
	ORDER BY cost, tour
), ex01 AS (
	SELECT CONCAT(res.cost + (SELECT cost FROM nodes WHERE point1 = 'a' AND point2 = res.tour [4] LIMIT 1))::integer AS total_cost, tour || ARRAY ['a'] AS tour FROM res
), ex00 AS (
 	SELECT * FROM ex01 WHERE total_cost = (SELECT MIN(total_cost) FROM ex01)
)
SELECT * FROM ex01
