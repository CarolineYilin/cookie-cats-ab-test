# Cookie Cats A/B Test: Does Moving the Gate Affect Player Retention?
  
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
  _To be completed._
  
  ## Recommendation
  _To be completed._
  
  ## Limitations
  _To be completed._
  
  ## How to run
  1. Download the dataset from Kaggle into `data/`
  2. `python3 -m venv .venv && source .venv/bin/activate`
  3. `pip install duckdb pandas numpy scipy matplotlib statsmodels jupyter`
  4. Open `analysis.ipynb` and run all cells
