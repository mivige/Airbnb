# 02_solution.R
# Airbnb Mallorca Data Analysis
# Normality assessment of prices and reviews
# Author: Michele Gentile

# Load necessary libraries
library(tidyverse)
library(ggplot2)

source("R/data_loading.R")

# Filter data for the specified date and locations
data_filtered <- airbnb_data$listings %>%
  filter(
    date == as.Date("2024-09-13"),
    neighbourhood_cleansed %in% c("Pollença", "Palma de Mallorca"),
    price > 50 & price < 400 # Filter for valid price range
  )

# Function to plot distribution with histogram, kernel density, and normal density
plot_distribution <- function(data, variable, location) {
  # Extract the data for the given variable and location
  data_subset <- data %>% filter(neighbourhood_cleansed == location)
  values <- data_subset[[variable]]

  # Calculate mean and standard deviation
  mean_val <- mean(values, na.rm = TRUE)
  sd_val <- sd(values, na.rm = TRUE)

  # Create the plot
  ggplot(data_subset, aes_string(x = variable)) +
    geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", alpha = 0.6) +
    geom_density(color = "red", size = 1) +
    stat_function(fun = dnorm, args = list(mean = mean_val, sd = sd_val), color = "blue", linetype = "dashed", size = 1) +
    labs(
      title = paste("Distribution of", variable, "in", location),
      x = variable,
      y = "Density"
    ) +
    theme_minimal()
}

# Plot for `price` in Pollença
plot_price_pollenca <- plot_distribution(data_filtered, "price", "Pollença")

# Plot for `price` in Palma
plot_price_palma <- plot_distribution(data_filtered, "price", "Palma de Mallorca")

# Plot for `number_of_reviews` in Pollença
plot_reviews_pollenca <- plot_distribution(data_filtered, "number_of_reviews", "Pollença")

# Plot for `number_of_reviews` in Palma
plot_reviews_palma <- plot_distribution(data_filtered, "number_of_reviews", "Palma de Mallorca")

# Display the plots
print(plot_price_pollenca)
print(plot_price_palma)
print(plot_reviews_pollenca)
print(plot_reviews_palma)
