# data_loading.R
# Airbnb Mallorca Data Analysis
# Data Loading and Preprocessing Script

# Load required libraries
library(tidyverse)
library(sf)

# Function to load and preprocess data
load_airbnb_data <- function() {
    # Load listings data
    load("data/") # INSERT CORRECT DATAS
    
    # Read reviews data
    reviews <- read_csv("data/") %>% # INSERT CORRECT DATAS
        # Basic preprocessing
        mutate(
        comment_length = str_count(comments, "\\w+"),
        date = as.Date(date)
        )
    
    # Read neighbourhoods
    municipios <- read_csv("data/") # INSERT CORRECT DATAS
    
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