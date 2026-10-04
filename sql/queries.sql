SELECT version, COUNT(*) AS n_players
  FROM players
  GROUP BY version;

SELECT COUNT(*) AS total_rows,
         COUNT(DISTINCT userid) AS unique_players
  FROM players;


SELECT userid FROM players
WHERE sum_gamerounds =0

SELECT COUNT(userid) FROM players GROUP by version
