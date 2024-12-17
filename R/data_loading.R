# data_loading.R
# Airbnb Mallorca Data Analysis
# Data Loading and Preprocessing Script
# Author: Michele Gentile

# Load required libraries
library(tidyverse)
library(sf)
library(tmap)

# Function to load and preprocess data
load_airbnb_data <- function() {
    # Load listings data
    load("clean_data/mallorca/listing_common0_select.RData")
    ls()

    str(listings_common0_select)

    unique(listings_common0_select$date)
    
    # Read reviews data
    reviews = read_csv("data/mallorca/2023-12-17/reviews.csv.gz")
    str(reviews)

    head(reviews)
        # Basic preprocessing
#        mutate(
#        comment_length = str_count(comments, "\\w+"),
#        date = as.Date(date)
#        )
    
    # Read neighbourhoods
    municipios = read_csv("data/mallorca/2023-12-17/neighbourhoods.csv")
    str(municipios)
    
    head(municipios)

    # Leer el archivo GeoJSON
    geojson_sf <- sf::st_read("data/mallorca/2024-09-13/neighbourhoods.geojson")

    # Crear un mapa

    # interactivo
    tmap_mode("plot") # Cambiar a modo  view/plot   que es interactivo/estático
    tm_shape(geojson_sf) + tm_polygons(col = "cyan", alpha = 0.6) + tm_layout(title = "Mapa - GeoJSON Mallorca con municipios")

    # Return list of processed datasets
    list(
        listings = listings_common0_select,
        reviews = reviews,
        municipios = municipios
    )
}

# Load and preprocess data
airbnb_data <- load_airbnb_data()

# Data validation
validate_data <- function(data) {
    # Add checks for data integrity
    stopifnot(
        "Listings data is missing" = !is.null(data$listings),
        "Reviews data is missing" = !is.null(data$reviews),
        "Listings have required columns" = all(c("id", "price", "neighbourhood_cleansed", "date") %in% colnames(data$listings))
    )
    
    # Print basic data summary
    print("Data Loading Summary:")
    print(paste("Listings records:", nrow(data$listings)))
    print(paste("Reviews records:", nrow(data$reviews)))
    print(paste("Municipalities:", nrow(data$municipios)))
}

# Validate loaded data
validate_data(airbnb_data)