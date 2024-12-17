# 06_solution.R
# Airbnb Mallorca Data Analysis
# Comparative proportion analysis
# Author: Finn Dicke, Michele Gentile

# Load necessary libraries
library(dplyr)
library(kableExtra)

source("R/data_loading.R")

# Function to calculate proportion of ratings > 4
calculate_proportion <- function(data, neighbourhood, date) {
  data %>%
    filter(neighbourhood_cleansed == neighbourhood, date == date) %>%
    pull(review_scores_rating) %>%
    na.omit() %>%
    {. -> ratings; mean(ratings > 4)}
}

# Sample sizes function
calculate_sample_size <- function(data, neighbourhood, date) {
  data %>%
    filter(neighbourhood_cleansed == neighbourhood, date == date) %>%
    pull(review_scores_rating) %>%
    na.omit() %>%
    length()
}

# Proportions and sample sizes for Palma
p_Palma_2023 <- calculate_proportion(airbnb_data$listings, "Palma de Mallorca", "2023-12-17")
n_Palma_2023 <- calculate_sample_size(airbnb_data$listings, "Palma de Mallorca", "2023-12-17")

p_Palma_2024 <- calculate_proportion(airbnb_data$listings, "Palma de Mallorca", "2024-03-23")
n_Palma_2024 <- calculate_sample_size(airbnb_data$listings, "Palma de Mallorca", "2024-03-23")

# Proportions and sample sizes for Pollença
p_Pollença_2023 <- calculate_proportion(airbnb_data$listings, "Pollença", "2023-12-17")
n_Pollença_2023 <- calculate_sample_size(airbnb_data$listings, "Pollença", "2023-12-17")

p_Pollença_2024 <- calculate_proportion(airbnb_data$listings, "Pollença", "2024-03-23")
n_Pollença_2024 <- calculate_sample_size(airbnb_data$listings, "Pollença", "2024-03-23")

# Calculate differences of proportions (Palma and Pollença combined across years)
diferencia_2023 <- p_Palma_2023 - p_Pollença_2023
diferencia_2024 <- p_Palma_2024 - p_Pollença_2024

# Standard error calculation
error_2023 <- sqrt((p_Palma_2023 * (1 - p_Palma_2023) / n_Palma_2023) +
                     (p_Pollença_2023 * (1 - p_Pollença_2023) / n_Pollença_2023))
error_2024 <- sqrt((p_Palma_2024 * (1 - p_Palma_2024) / n_Palma_2024) +
                     (p_Pollença_2024 * (1 - p_Pollença_2024) / n_Pollença_2024))

# Critical value for 95% confidence interval
z <- qnorm(0.975)

# Confidence intervals
ci_2023 <- c(diferencia_2023 - z * error_2023, diferencia_2023 + z * error_2023)
ci_2024 <- c(diferencia_2024 - z * error_2024, diferencia_2024 + z * error_2024)

# Results
results <- data.frame(
  Period = c("2023-12-17", "2024-03-23"),
  Palma_Proportion = c(p_Palma_2023, p_Palma_2024),
  Pollenca_Proportion = c(p_Pollença_2023, p_Pollença_2024),
  Difference = c(diferencia_2023, diferencia_2024),
  CI_Lower = c(ci_2023[1], ci_2024[1]),
  CI_Upper = c(ci_2023[2], ci_2024[2])
)

# Display results
kable(results, caption = "Diferencia de proporciones entre Palma y Pollença") %>%
  kable_styling(full_width = FALSE)