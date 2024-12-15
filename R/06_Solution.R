library(dplyr)

# Filtrar y combinar datos para Palma de Mallorca
rating_2023M <- listings_common0_select %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca" & date == "2023-12-17") %>%
  arrange(id) %>%
  select(id, review_scores_rating)

rating_2024M <- listings_common0_select %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca" & date == "2024-03-23") %>%
  arrange(id) %>%
  select(id, review_scores_rating)

rating_23_24_M <- rating_2023M %>%
  left_join(rating_2024M, by = "id", suffix = c("_2023", "_2024"))

# Filtrar y combinar datos para Pollença
rating_2023P <- listings_common0_select %>%
  filter(neighbourhood_cleansed == "Pollença" & date == "2023-12-17") %>%
  arrange(id) %>%
  select(id, review_scores_rating)

rating_2024P <- listings_common0_select %>%
  filter(neighbourhood_cleansed == "Pollença" & date == "2024-03-23") %>%
  arrange(id) %>%
  select(id, review_scores_rating)

rating_23_24_P <- rating_2023P %>%
  left_join(rating_2024P, by = "id", suffix = c("_2023", "_2024"))

# Calcular proporciones para Pollença
p_Pollenca <- mean(rating_23_24_P$review_scores_rating_2023 > 4, na.rm = TRUE)
n_Pollenca <- sum(!is.na(rating_23_24_P$review_scores_rating_2023))

# Calcular proporciones para Palma de Mallorca
p_Mallorca <- mean(rating_23_24_M$review_scores_rating_2023 > 4, na.rm = TRUE)
n_Mallorca <- sum(!is.na(rating_23_24_M$review_scores_rating_2023))

# Calcular diferencia de proporciones
diferencia <- p_Pollenca - p_Mallorca

# Calcular el error estándar
error <- sqrt((p_Pollenca * (1 - p_Pollenca) / n_Pollenca) +
                (p_Mallorca * (1 - p_Mallorca) / n_Mallorca))

# Valor crítico para un intervalo de confianza del 95%
z <- qnorm(0.975)

# Calcular intervalo de confianza
intervalo <- c(diferencia - z * error, diferencia + z * error)

# Resultados finales
list(
  Diferencia = diferencia,
  IC_95 = intervalo,
  Palma_Proporción = p_Mallorca,
  Pollença_Proporción = p_Pollenca
)
