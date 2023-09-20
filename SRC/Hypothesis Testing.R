# Load the 'readr' library for reading CSV files
library(readr)

# Read the CSV file 'results_spread.csv' into a data frame 'results_spread'
results_spread <- read_csv("results_spread.csv")

# Display the data frame in a viewer (e.g., RStudio's data viewer)
View(results_spread)

# Load the 'dplyr' library for data manipulation
library(dplyr)

# Remove columns named '...1' and 'Unnamed: 0' from the 'results_spread' data frame
df <- results_spread %>%
  select(-...1, -`Unnamed: 0`)

# Create separate data frames 'winners_df' and 'losers_df' based on the 'result' column
winners_df <- df[df$result == 1, ]
losers_df <- df[df$result == 0, ]

# Perform a t-test to compare the 'compound' variable between winners and losers
t_test_result <- t.test(winners_df$compound, losers_df$compound)

# Print the t-test result
t_test_result

# Create a new column 'Group' in the 'df' data frame based on 'result' and 'expected' conditions
df$Group <- ifelse(df$result == 1 & df$expected == 1, "Winners (Expected to Win)",
                   ifelse(df$result == 1 & df$expected == 0, "Winners (Expected to Lose)",
                          ifelse(df$result == 0 & df$expected == 1, "Losers (Expected to Win)",
                                 ifelse(df$result == 0 & df$expected == 0, "Losers (Expected to Lose)", NA))))

# Perform an analysis of variance (ANOVA) on the 'compound' variable using the 'Group' factor
anova_result <- aov(compound ~ Group, data = df)

# Print a summary of the ANOVA results
summary(anova_result)

# Perform Tukey's Honest Significant Difference (HSD) test on the ANOVA results
tukey_result <- TukeyHSD(anova_result)

# Print the Tukey HSD test results
print(tukey_result)

# Create a subset of non-significant results based on adjusted p-values
non_significant_results <- tukey_result$tukey.result[tukey_result$tukey.result[, "p adj"] > 0.05, ]

# Print the non-significant Tukey HSD test results
print(non_significant_results)

# Calculate the mean of the 'compound' variable in the entire data frame 'df'
mean(df$compound)

# Calculate the group means of the 'compound' variable based on the 'Group' factor
group_means <- tapply(df$compound, df$Group, mean)

# Print the group means
print(group_means)

#Summary:

# Welch Two Sample t-test (t_test_result):
#   
#   Test: Welch Two Sample t-test
# Hypothesis: True difference in means is not equal to 0
# Results:
#   t = 13.085
# Degrees of Freedom (df) = 10429
# p-value < 2.2e-16 (indicating strong evidence against the null hypothesis)
# 95% confidence interval: [0.1101713, 0.1489962]
# Sample estimates:
#   Mean of x (winners_df$compound) = 0.1668978
# Mean of y (losers_df$compound) = 0.0373140
# ANOVA (anova_result):
#   
#   Test: Analysis of Variance (ANOVA)
# Factor: Group
# Results:
#   Group has a significant effect on the 'compound' variable (p-value < 2e-16).
# F-statistic: 58.96
# Significance levels:
#   '***' (0.001) indicates extremely significant differences.
# Residuals: 10450 degrees of freedom
# 207 observations were deleted due to missing data.
# Tukey's Honest Significant Difference (HSD) Test (tukey_result):
# 
# Test: Tukey multiple comparisons of means
# 95% family-wise confidence level
# Pairwise comparisons with p-values:
# Losers (Expected to Win) vs. Losers (Expected to Lose): p = 0.0816828 (not significant)
# Winners (Expected to Lose) vs. Losers (Expected to Lose): p < 0.0001 (highly significant)
# Winners (Expected to Win) vs. Losers (Expected to Lose): p < 0.0001 (highly significant)
# Winners (Expected to Lose) vs. Losers (Expected to Win): p < 0.0001 (highly significant)
# Winners (Expected to Win) vs. Losers (Expected to Win): p < 0.0001 (highly significant)
# Winners (Expected to Win) vs. Winners (Expected to Lose): p = 0.9970152 (not significant)