-- comment number of players per version
SELECT version, COUNT(*) AS n_players
  FROM players
  GROUP BY version;
-- commentcheck for duplicate userid
SELECT COUNT(*) AS total_rows,
         COUNT(DISTINCT userid) AS unique_players
  FROM players;
-- comment display the version and number of player who has game round = 0

SELECT version, COUNT(*) FROM players
WHERE sum_gamerounds =0
-- comment number of players in each 
SELECT COUNT(userid) FROM players GROUP by version
