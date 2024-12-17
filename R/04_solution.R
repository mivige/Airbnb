# 04_solution.R
# Airbnb Mallorca Data Analysis
# Interval comparison, hypothesis testing & boxplot
# Author: Angus Pelegrin, Michele Gentile

# Load necessary libraries
library(tidyverse)
library(dplyr)
library(kableExtra)

source("R/data_loading.R")

# Define comparison dates
date1 <- "2023-12-17"
date2 <- "2024-03-23"

# Filter data for Palma at the two dates
palma_prices_2023 <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca", date == date1) %>%
  pull(price)

palma_prices_2024 <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca", date == date2) %>%
  pull(price)

# Calculate means for reference
mean_palma_2023 <- mean(palma_prices_2023, na.rm = TRUE)
mean_palma_2024 <- mean(palma_prices_2024, na.rm = TRUE)

# Hypothesis Testing
# H0: mean_palma_2023 >= mean_palma_2024
# H1: mean_palma_2023 < mean_palma_2024
t_test_result <- t.test(palma_prices_2023, palma_prices_2024, alternative = "less")

# Extract p-value and confidence interval
p_value <- t_test_result$p.value
conf_int <- t_test_result$conf.int

# Calculate mean difference
mean_diff <- mean_palma_2023 - mean_palma_2024

# Present Results
results <- data.frame(
  `Media 2023-12-17` = mean_palma_2023,
  `Media 2024-03-23` = mean_palma_2024,
  `Diferencia de medias` = mean_diff,
  `P-valor` = p_value,
  `Intervalo de confianza` = paste0("[", round(conf_int[1], 2), ", ", round(conf_int[2], 2), "]")
)

# Display results in a table
kable(results, 
      col.names = c("Media 2023-12-17", "Media 2024-03-23", "Diferencia de medias", "P-valor", "Intervalo de confianza"), 
      align = "c", caption = "Resultados del contraste de hipótesis") %>%
  kable_styling(full_width = FALSE)

# Create a boxplot for visual comparison
boxplot(
  palma_prices_2023, palma_prices_2024, 
  names = c("2023-12-17", "2024-03-23"),
  col = c("skyblue", "salmon"),
  main = "Comparación de precios en Palma",
  ylab = "Precio (€)",
  xlab = "Fecha"
)

# Print a conclusion
if (p_value < 0.05) {
  print("Rechazamos la hipótesis nula: Los precios medios en 2023-12-17 son significativamente menores que en 2024-03-23.")
} else {
  print("No podemos rechazar la hipótesis nula: No hay evidencia suficiente de que los precios medios en 2023-12-17 sean menores que en 2024-03-23.")
}