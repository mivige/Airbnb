# 05_solution.R
# Airbnb Mallorca Data Analysis
# Proportion of high-rated apartments
# Author: Finn Dicke, Michele Gentile

# Load necessary libraries
library(tidyverse)
library(kableExtra)

source("R/data_loading.R")

# Filter data for Palma and Pollença on 2024-03-23
rating_Pollença <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Pollença", date == "2024-03-23") %>%
  pull(review_scores_rating) %>%
  na.omit()

rating_Palma <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca", date == "2024-03-23") %>%
  pull(review_scores_rating) %>%
  na.omit()

# Calculate proportions and sample sizes
p_Pollença <- mean(rating_Pollença > 4)
n_Pollença <- length(rating_Pollença)

p_Palma <- mean(rating_Palma > 4)
n_Palma <- length(rating_Palma)

# Calculate difference in proportions
diferencia <- p_Pollença - p_Palma

# Calculate standard error
error <- sqrt((p_Pollença * (1 - p_Pollença) / n_Pollença) + 
                (p_Palma * (1 - p_Palma) / n_Palma))

# Critical value for a 95% confidence interval
z <- qnorm(0.975)

# Confidence interval for the difference in proportions
intervalo <- c(diferencia - z * error, diferencia + z * error)

# Present results
results <- data.frame(
  "Proporción Palma" = p_Palma,
  "Proporción Pollença" = p_Pollença,
  "Diferencia de Proporciones" = diferencia,
  "IC 95% Inferior" = intervalo[1],
  "IC 95% Superior" = intervalo[2]
)

# Display results as a table
kable(results, caption = "Intervalo de confianza para la diferencia de proporciones") %>%
  kable_styling(full_width = FALSE)