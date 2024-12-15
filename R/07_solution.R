# 07_solution.R
# Airbnb Mallorca Data Analysis
# Zipf's law
# Author: Michele Gentile

# Load required libraries
library(tidyverse)
library(stringr)

source("R/data_loading.R")

# Save all the listings in Palma
palma_listing_ids <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca") %>%
  pull(id)  # Extract as a vector

# Extract only the reviews for Palma
palma_reviews <- airbnb_data$reviews %>%
  filter(as.character(listing_id) %in% as.character(palma_listing_ids))

# Calculate the length of each comment in words
palma_reviews <- palma_reviews %>% 
  mutate(comment_length = str_count(comments, "\\w+"))

# Compute the frequency of each comment length
length_freq <- palma_reviews %>% 
  count(comment_length, name = "frequency") %>% 
  arrange(desc(frequency))

# Add rank and log transformations for Zipf's analysis
length_freq <- length_freq %>% 
  mutate(
    rank = rank(-frequency, ties.method = "first"), # Rank by descending frequency
    log_frequency = log(frequency),
    log_rank = log(rank)
  ) %>% 
  filter(rank > 10 & rank < 1000) # Filter for specific rank range

# Perform linear regressions
# Regression of frequency vs. rank
model_freq_rank <- lm(frequency ~ rank, data = length_freq)
summary(model_freq_rank)

# Regression of frequency vs. log(rank)
model_freq_logrank <- lm(frequency ~ log_rank, data = length_freq)
summary(model_freq_logrank)

# Regression of log(frequency) vs. log(rank) - most relevant for Zipf's law
model_logfreq_logrank <- lm(log_frequency ~ log_rank, data = length_freq)
summary(model_logfreq_logrank)

# Plot the results
# Frequency vs Rank
ggplot(length_freq, aes(x = rank, y = frequency)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Frequency vs Rank",
    x = "Rank",
    y = "Frequency"
  ) +
  theme_minimal()

# Frequency vs Log(Rank)
ggplot(length_freq, aes(x = log_rank, y = frequency)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(
    title = "Frequency vs Log(Rank)",
    x = "Log(Rank)",
    y = "Frequency"
  ) +
  theme_minimal()

# Log(Frequency) vs Log(Rank)
ggplot(length_freq, aes(x = log_rank, y = log_frequency)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "green") +
  labs(
    title = "Log(Frequency) vs Log(Rank)",
    x = "Log(Rank)",
    y = "Log(Frequency)"
  ) +
  theme_minimal()

# Interpretation:
# Compare the R-squared values and coefficients from the three models:
# - High R-squared in log-log regression suggests adherence to Zipf's law.
# - A slope near -1 in the log-log regression further supports Zipf's law.
