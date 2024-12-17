# 03_solution.R
# Airbnb Mallorca Data Analysis
# Price comparisons between municipalities
# Author: Angus Pelegrin, Michele Gentile

# Load necessary libraries
library(tidyverse)
library(dplyr)
library(kableExtra)

source("R/data_loading.R")

# Filter data: Prices between 50 and 400 for Palma and Pollença
palma_prices <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca", price >= 50, price <= 400) %>%
  pull(price)

pollensa_prices <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Pollença", price >= 50, price <= 400) %>%
  pull(price)

# Calculate mean prices for reference
mean_palma <- mean(palma_prices)
mean_pollensa <- mean(pollensa_prices)

# Hypothesis Testing
# H0: mean_pollença <= mean_palma
# H1: mean_pollença > mean_palma
t_test_result <- t.test(pollensa_prices, palma_prices, alternative = "greater")

# Extract relevant values
p_value <- t_test_result$p.value
conf_int <- t_test_result$conf.int
diff_means <- mean_pollensa - mean_palma  # Difference of means

# Conclusion: Reject H0 if p-value < 0.05
conclusion <- ifelse(p_value < 0.05, 
                     "Rechazamos la hipótesis nula: El precio medio en Pollença es mayor que en Palma.", 
                     "No podemos rechazar la hipótesis nula: No hay evidencia suficiente de que el precio medio en Pollença sea mayor que en Palma.")

# Present results
results <- data.frame(
  `Precio medio Palma` = mean_palma,
  `Precio medio Pollença` = mean_pollensa,
  `Diferencia de precios` = diff_means,
  `P-valor` = p_value,
  `Intervalo de confianza` = paste0("[", round(conf_int[1], 2), ", ", round(conf_int[2], 2), "]")
)

# Display table
kable(results, 
      col.names = c("Precio medio Palma", "Precio medio Pollença", 
                    "Diferencia de precios", "P-valor", "Intervalo de confianza"), 
      align = "c", caption = "Resultados del contraste de hipótesis") %>%
  kable_styling(full_width = FALSE)

# Print Conclusion
print(conclusion)