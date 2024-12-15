# 04_solution.R
# Airbnb Mallorca Data Analysis
# Interval comparison, hypothesis testing & boxplot
# Author: Angus Pelegrin

# Cargar librerías necesarias
library(tidyverse)
library(dplyr)
library(kableExtra)

source("R/data_loading.R")

# Pregunta 1: Contrastar si las medias de los precios en Palma entre los periodos “2023-12-17” y “2024-03-23” son iguales.
# Paso 1: Preparar los datos

palma_prepared_1 <- airbnb_data$listings %>% #Guarda precios palma 2023-12-17
  filter(neighbourhood_cleansed == "Palma de Mallorca" & date == "2023-12-17") %>% 
  pull(price)

avg_palma_1 <- mean(palma_prepared_1) #precio medio de palma 2023-12-17

palma_prepared_2 <- airbnb_data$listings %>% #Guarda precios palma 2024-06-30
  filter(neighbourhood_cleansed == "Palma de Mallorca" & date == "2024-03-23") %>% 
  pull(price)

avg_palma_2 <- mean(palma_prepared_2) #precio medio de palma 2024-06-30

# Paso 2: Comparar las medias
diff_avg_palma <- avg_palma_1 - avg_palma_2

# Paso 3: Construir la hipótesis nula y alternativa, calcular el p-valor y el intervalo de confianza asociado al contraste

# H0: No hay diferencia entre los precios medios de Palma en los periodos “2023-12-17” y “2024-06-30”
# H1: Hay diferencia entre los precios medios de Palma en los periodos “2023-12-17” y “2024-06-30”

p_value_avg_palma <- t.test(palma_prepared_1, palma_prepared_2, alternative = "two.sided")$p.value
conf_int_avg_palma <- t.test(palma_prepared_1, palma_prepared_2, alternative = "two.sided")$conf.int

# Paso 4: Hacer un boxplot
boxplot(palma_prepared_1, palma_prepared_2, names = c("2023-12-17", "2024-06-30"), col = c("blue", "red"), main = "Precios medios de Palma en 2023-12-17 y 2024-06-30", ylab = "Precio (€)", xlab = "Fecha")