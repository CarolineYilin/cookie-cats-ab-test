 -- =====================================================================
  -- Cookie Cats A/B Test: SQL queries (DuckDB)
  -- Question: does moving the first gate from level 30 to level 40
  --           change player retention?
  -- =====================================================================



  -- 0. Load the raw data
  CREATE OR REPLACE TABLE players AS
  SELECT * FROM 'data/cookie_cats.csv';



  -- 1. Explore the raw data

  -- Number of players in each version
  SELECT version, COUNT(*) AS n_players
  FROM players
  GROUP BY version
  ORDER BY version;

  -- Check for duplicate user IDs (0 rows = no duplicates)
  SELECT userid, COUNT(*) AS times_seen
  FROM players
  GROUP BY userid
  HAVING COUNT(*) > 1;

  -- Players who never played a single round, by version
  SELECT version, COUNT(*) AS zero_round_players
  FROM players
  WHERE sum_gamerounds = 0
  GROUP BY version
  ORDER BY version;

  -- Game rounds played: average, median, maximum by version
  SELECT version,
         AVG(sum_gamerounds)    AS avg_rounds,
         MEDIAN(sum_gamerounds) AS median_rounds,
         MAX(sum_gamerounds)    AS max_rounds
  FROM players
  GROUP BY version
  ORDER BY version;

  -- 1-day and 7-day retention rates by version (raw data)
  SELECT version,
         AVG(CAST(retention_1 AS INTEGER)) AS retention_1day,
         AVG(CAST(retention_7 AS INTEGER)) AS retention_7day
  FROM players
  GROUP BY version
  ORDER BY version;


  
  -- 2. Data cleaning


  -- Find the extreme outlier (49,854 rounds in 14 days, about 3,500/day)
  SELECT *
  FROM players
  WHERE sum_gamerounds = 49854;

  -- Create a cleaned table without the outlier (raw table kept unchanged)
  CREATE OR REPLACE TABLE players_clean AS
  SELECT *
  FROM players
  WHERE sum_gamerounds < 49854;

  -- Check the cleaned table: player counts and new maximum
  SELECT version,
         COUNT(*)            AS n_players,
         MAX(sum_gamerounds) AS max_rounds
  FROM players_clean
  GROUP BY version
  ORDER BY version;
  

  -- 3. Analysis on the cleaned data

  -- Game rounds played after cleaning
  SELECT version,
         AVG(sum_gamerounds)    AS avg_rounds,
         MEDIAN(sum_gamerounds) AS median_rounds,
         MAX(sum_gamerounds)    AS max_rounds
  FROM players_clean
  GROUP BY version
  ORDER BY version;

  -- Retention rates after cleaning
  SELECT version,
         AVG(CAST(retention_1 AS INTEGER)) AS retention_1day,
         AVG(CAST(retention_7 AS INTEGER)) AS retention_7day
  FROM players_clean
  GROUP BY version
  ORDER BY version;

  -- Counts for the 7-day two-proportion z-test (retained / total)
  SELECT version,
         COUNT(*)                          AS n_players,
         SUM(CAST(retention_7 AS INTEGER)) AS retained_7
  FROM players_clean
  GROUP BY version
  ORDER BY version;

  -- Counts for the 1-day two-proportion z-test (retained / total)
  SELECT version,
         COUNT(*)                          AS n_players,
         SUM(CAST(retention_1 AS INTEGER)) AS retained_1
  FROM players_clean
  GROUP BY version
  ORDER BY version;


  -- 4. Data exported to Python for statistical tests


  -- 7-day retention as 0/1 for the bootstrap
  SELECT version, CAST(retention_7 AS INTEGER) AS ret7
  FROM players_clean;

  -- Game rounds for the Mann-Whitney U test
  SELECT version, sum_gamerounds
  FROM players_clean;