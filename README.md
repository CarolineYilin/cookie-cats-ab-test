# Cookie Cats A/B Test: Does Moving the Gate Affect Player Retention?
  
  # Summary
  I looked at data from about 90,000 players of a mobile game to see if delaying a "wait gate" from level 30 to level 40 would keep more players coming back. After cleaning the data with SQL and testing the results with both a z-test and 10,000 bootstrap simulations, I found the opposite of what the change was hoping for: moving the gate later lowered 7-day retention from 19.0% to 18.2%, a difference that was very unlikely to be due to chance. The 1-day difference was small and not significant. Because even a small drop adds up to many lost players for a large game, I recommended keeping the gate at level 30.
  
  ## Question
  Does moving the first in-game gate from level 30 to level 40 change player retention?
  
  ## Data
  - Source: Kaggle, "Mobile Games A/B Testing - Cookie Cats" (download separately; not included in this repo)
  - 90,189 players, randomly assigned to `gate_30` (control) or `gate_40` (treatment)
  - Columns: userid, version, sum_gamerounds, retention_1, retention_7
  
  ## Data cleaning
  - No duplicate user IDs
  - Removed 1 player with 49,854 game rounds (implausible: ~3,500 rounds/day); analysis uses 90,188 players
  
  ## Method
  1. SQL exploration (DuckDB): group sizes, play statistics, retention rates
  2. Validity check: sample ratio (chi-square)
  3. Hypothesis tests on 1-day and 7-day retention (two-proportion z-test)
  4. Bootstrap confidence intervals
  5. Engagement comparison (Mann-Whitney U)
  
  ## Results
  Outlier removed: gate_30 now has 44,699 players with a max of 2,961 rounds. The gate_30 average dropped from 52.46 to 51.34, now almost identical to gate_40's 51.30.
  Retention is basically unchanged by the cleaning: 1-day 44.8% vs 44.2%; 7-day 19.0% vs 18.2%.
  
  ## Recommendation
  _To be completed._
  
  ## Limitations
  _To be completed._
  
  ## How to run
  1. Download the dataset from Kaggle into `data/`
  2. `python3 -m venv .venv && source .venv/bin/activate`
  3. `pip install duckdb pandas numpy scipy matplotlib statsmodels jupyter`
  4. Open `analysis.ipynb` and run all cells
