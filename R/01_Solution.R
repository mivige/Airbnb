# 01_solution.R
# Airbnb Mallorca Data Analysis
# Descriptive stats
# Author: Finn Dicke

# Load necessary libraries
library(dplyr)
library(kableExtra)

source("R/data_loading.R")

data_prepared <- airbnb_data$listings %>%
  mutate(year = format(date, "%Y")) %>%  # Convert dates in 'Year' format
  group_by(neighbourhood_cleansed, year)  # Group by neighbourhood and year

# Calculate descriptive stats
stats <- data_prepared %>%
  summarise(
    mean_price = mean(price, na.rm = TRUE),      
    median_price = median(price, na.rm = TRUE),  
    sd_price = sd(price, na.rm = TRUE),   # Standard dev 
    mean_reviews = mean(number_of_reviews, na.rm = TRUE),
    median_reviews = median(number_of_reviews, na.rm = TRUE),
    sd_reviews = sd(number_of_reviews, na.rm = TRUE) 
  ) %>%
  ungroup()

# Present datas in a table format
stats %>%
  kable("html", caption = "Estadísticos descriptivos por municipio y año") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)
