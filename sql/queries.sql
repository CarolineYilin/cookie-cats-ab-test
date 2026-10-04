SELECT version, COUNT(*) AS n_players
  FROM players
  GROUP BY version;

SELECT COUNT(*) AS total_rows,
         COUNT(DISTINCT userid) AS unique_players
  FROM players;
