# About:
### This project is a sentiment analysis of all 32 NFL teams after their first game of the season. Data is gathered from each team's subreddit, and ran through a sentiment analysis package called Vader. Statistical analysis is used to determine whether a teams result (W/L) and expected result (W/L) affects reddit comments. 
# Contents
## SRC 
### Installing Code: All code used is in the SRC folder. If the repository is cloned, the code should run with the data in the data folder.
### Usage of Code: Once the repository is cloned: the source code should be ran in the following order:  
| File | Description |
| --- | --- |
| reddit_scrapper.R | scrapes comments from all NFL team subreddits' first season game thread.
| Vader_Pipeline.ipynb | analyzes all comments gathered from web scraping for sentiment using Vader.
| Updating_W_L.ipynb | updates the dataframe with game results, expected results and spread.
| Hypothesis-Testing.R | runs statistical analysis to test our hypotheses. 
## Data
| Data file | Description |
| --- | --- |
| Reddit_Links.xlsx | links to each reddit post and all scraped comments |
| initial_dataset.csv | scraped comments and Vader sentiment scores |
| results_spread | complete dataset: comments, sentiment scores and results (actual/expected) |
## Figures
| Figure | Description |
| --- | --- |
| Average_Compound_Scores.png | the average compound scores from Vader for each team |
| Comment_counts.png | number of comments per team |
## References
### [1] “Welcome to Vadersentiment’s documentation!,” Welcome to VaderSentiment’s documentation! - VaderSentiment 3.3.1 documentation, https://vadersentiment.readthedocs.io/en/latest/ (accessed Sep. 24, 2023).  


