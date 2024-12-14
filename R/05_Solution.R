library(dplyr)

# Filtrar los datos para el periodo "2024-03-23" y los municipios deseados
rating_Pollenca= listings_common0_select %>%
  filter(neighbourhood_cleansed=="Pollença" & date=="2024-03-23")
rating_Pollenca=na.omit(rating_Pollenca$review_scores_rating)

rating_Palma= listings_common0_select %>%
  filter(neighbourhood_cleansed=="Palma de Mallorca" & date=="2024-03-23")
rating_Palma=na.omit(rating_Palma$review_scores_rating)

# Calcular la proporción de apartamentos con 'review_scores_rating' > 4 por municipio

#Pollenca
p_Pollenca=mean(rating_Pollenca>4)
n_Pollenca=length(rating_Pollenca)
p_Pollenca
n_Pollenca

#Mallorca
p_Mallorca=mean(rating_Palma>4)
n_Mallorca=length(rating_Palma)
p_Mallorca
n_Mallorca

# Calcular la diferencia de proporciones
diferencia <- p_Pollenca - p_Mallorca

# Calcular el error estándar
error <- sqrt((p_Pollenca * (1 - p_Pollenca) / n_Pollenca) + (p_Mallorca * (1 - p_Mallorca) / n_Mallorca))

# Valor crítico para un intervalo de confianza del 95%
z <- qnorm(0.975)

# Intervalo de confianza
intervalo <- c(diferencia - z * error, diferencia + z * error)

# Resultados finales
list(
  Diferencia = diferencia,
  IC_95 = intervalo,
  Palma_Proporción = p_Mallorca,
  Pollença_Proporción = p_Pollenca
)
