# 03_solution.R
# Airbnb Mallorca Data Analysis
# Comparison & hypothesis testing
# Author: Angus Pelegrin

# Cargar librerías necesarias
library(tidyverse)
library(dplyr)
library(kableExtra)

# Paso 1: Guardar los datos de precios de palma y pollensa entre 50 y 400euros en dos objetos
palma_prepared <- listings_common0_select %>% 
  filter(city == "Palma" & price >= 50 & price <= 400) %>% 
  pull(price)

precio_medio_palma <- mean(palma_prepared)#precio medio de palma

pollensa_prepared <- listings_common0_select %>%
  filter(city == "Pollensa" & price >= 50 & price <= 400) %>% 
  pull(price)

precio_medio_pollensa <- mean(pollensa_prepared)#precio medio de pollensa

# Paso 2: Comparar los datos
  diff_precio = precio_medio_palma - precio_medio_pollensa
  
# Paso 3: Construid la hipótesis nula y alternativa,
# calculad el p-valor y el intervalo de confiaza asociado al contraste
  
# H0: No hay diferencia entre los precios medios de Palma y Pollensa
# H1: Hay diferencia entre los precios medios de Palma y Pollensa
  
p_value <- t.test(palma_prepared, pollensa_prepared, alternative = "two.sided")$p.value
conf_int <- t.test(palma_prepared, pollensa_prepared, alternative = "two.sided")$conf.int

# Paso 4: Justifica tecnicamente la conclusión del contraste.
# Si el p-valor es menor que el nivel de significancia (0.05), rechazamos la hipótesis nula.
# En este caso, el p-valor es menor que 0.05, por lo que rechazamos la hipótesis nula.
# Por lo tanto, hay una diferencia significativa entre los precios medios de Palma y Pollensa.