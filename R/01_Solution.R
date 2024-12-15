# Cargar librerías necesarias
library(dplyr)
library(kableExtra)

# Paso 1: Preparar los datos
# Convertir las fechas a formato 'Year' y agrupar por municipio y año
data_prepared <- listings_common0_select %>%
  mutate(year = format(date, "%Y")) %>%  # Extraer el año de la columna 'date'
  group_by(neighbourhood_cleansed, year)  # Agrupar por municipio y año

# Paso 2: Calcular estadísticos descriptivos
stats <- data_prepared %>%
  summarise(
    mean_price = mean(price, na.rm = TRUE),       # Media del precio
    median_price = median(price, na.rm = TRUE),  # Mediana del precio
    sd_price = sd(price, na.rm = TRUE),          # Desviación estándar del precio
    mean_reviews = mean(number_of_reviews, na.rm = TRUE),       # Media de reseñas
    median_reviews = median(number_of_reviews, na.rm = TRUE),  # Mediana de reseñas
    sd_reviews = sd(number_of_reviews, na.rm = TRUE)           # Desviación estándar de reseñas
  ) %>%
  ungroup()

stats %>%
  kable("html", caption = "Estadísticos descriptivos por municipio y año") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)
