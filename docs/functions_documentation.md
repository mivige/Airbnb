# Data Loading and Preprocessing Script

**Author**: Michele Gentile  
**File**: `data_loading.R`  

---

## Description  

This script loads and preprocesses the datasets required for the Airbnb Mallorca Data Analysis. It handles the following tasks:  
- Loading listing data (`RData` format)  
- Reading reviews and neighborhood data (CSV format)  
- Importing geographical data (GeoJSON format)  
- Creating a basic static map using the `tmap` library  
- Validating the integrity of the loaded datasets  

---

## Dependencies  

The script relies on the following R libraries:  
- `tidyverse` : For data manipulation and reading CSV files.  
- `sf` : For reading and processing spatial data in GeoJSON format.  
- `tmap` : For creating static and interactive maps.  

Make sure these libraries are installed before running the script.  

---

## Functions  

### 1. `load_airbnb_data()`  

**Purpose**:  
Loads and preprocesses Airbnb data, including listings, reviews, and municipalities data.

**Steps**:  
1. **Listings Data**:  
   - Loads the preprocessed `listing_common0_select` dataset from an `RData` file.  
   - Displays the structure and checks unique dates.  

2. **Reviews Data**:  
   - Reads the reviews dataset (`reviews.csv.gz`) in compressed CSV format.  
   - Displays structure and a preview of the data.  

3. **Neighbourhood Data**:  
   - Reads the municipalities data from a CSV file.  
   - Displays structure and a preview of the data.  

4. **Geospatial Data**:  
   - Imports the neighborhoods dataset in GeoJSON format.  
   - Visualizes the geographical data using a static map (`tmap`).  

**Returns**:  
A named list containing:  
- `listings` : Listings dataset  
- `reviews` : Reviews dataset  
- `municipios` : Neighbourhoods dataset  

```r
airbnb_data <- load_airbnb_data()
```

---

### 2. `validate_data(data)`  

**Purpose**:  
Performs data validation and checks the integrity of the loaded datasets.  

**Steps**:  
1. Ensures that required datasets (`listings`, `reviews`, `municipios`) are not `NULL`.  
2. Verifies that the listings dataset contains the required columns:  
   - `id`, `price`, `neighbourhood_cleansed`, and `date`.  
3. Prints a summary of the data, including:  
   - Number of records in listings  
   - Number of records in reviews  
   - Number of municipalities  

**Usage**:  
```r
validate_data(airbnb_data)
```

---

## Outputs  

The script generates:  
- A static map displaying neighborhoods (using `tmap`).  
- Printed summaries of data structure and validation checks.  

---

## Notes  

- The map can be set to interactive mode by using `tmap_mode("view")`.  
- Ensure all file paths are correct, and the datasets exist in the specified directories:  
   - `clean_data/mallorca/listing_common0_select.RData`  
   - `data/mallorca/2023-12-17/reviews.csv.gz`  
   - `data/mallorca/2023-12-17/neighbourhoods.csv`  
   - `data/mallorca/2024-09-13/neighbourhoods.geojson`  

---

## Example Run  

```r
# Load and preprocess the data
airbnb_data <- load_airbnb_data()

# Validate the loaded data
validate_data(airbnb_data)
```

---

## Summary  

The `data_loading.R` script is the initial step for data preprocessing and validation in the Airbnb Mallorca project. It ensures that all datasets are loaded correctly and ready for further analysis.  

---

# Descriptive Statistics by Municipality and Period  

**Author**: Finn Dicke  
**File**: `01_solution.R`  

---

## Description  

This script calculates descriptive statistics for Airbnb listings, grouped by municipality (`neighbourhood_cleansed`) and year. The script outputs a styled table summarizing the price and review data for each group.

---

## Dependencies  

The script relies on the following R libraries:  
- `dplyr` : For data manipulation and summarization.  
- `kableExtra` : For creating and styling HTML tables.  

Ensure that the `data_loading.R` script is sourced correctly, as it provides the input datasets.

---

## Data Input  

This script uses the `listings` dataset, which is loaded from the `data_loading.R` script. The `listings` dataset is expected to contain the following columns:  
- `date` : Date of the listing (used to extract the year).  
- `price` : Price of the listing.  
- `neighbourhood_cleansed` : Municipality name.  
- `number_of_reviews` : Number of reviews for the listing.  

---

## Steps  

1. **Load Data**  
   - The script sources the `data_loading.R` file to load the `listings` dataset.  

2. **Data Preparation**  
   - Extracts the year from the `date` column using the `format()` function.  
   - Groups the data by `neighbourhood_cleansed` (municipality) and year.  

3. **Calculate Descriptive Statistics**  
   The following statistics are computed for each group:  
   - `mean_price` : Mean price of listings.  
   - `median_price` : Median price of listings.  
   - `sd_price` : Standard deviation of listing prices.  
   - `mean_reviews` : Mean number of reviews.  
   - `median_reviews` : Median number of reviews.  
   - `sd_reviews` : Standard deviation of the number of reviews.  

4. **Output Table**  
   - Generates an HTML table using the `kable` function.  
   - Applies styling using the `kable_styling` function to enhance the presentation.

---

## Output  

The script produces a styled HTML table displaying descriptive statistics for each municipality and year, with the following columns:  
- **neighbourhood_cleansed** : Municipality name.  
- **year** : Year of the data.  
- **mean_price** : Mean price of the listings.  
- **median_price** : Median price of the listings.  
- **sd_price** : Standard deviation of the listing prices.  
- **mean_reviews** : Mean number of reviews.  
- **median_reviews** : Median number of reviews.  
- **sd_reviews** : Standard deviation of the number of reviews.  

**Table Caption**: *"Estadísticos descriptivos por municipio y año"*  

---

## Example Run  

```r
# Load necessary libraries
library(dplyr)
library(kableExtra)

# Source the data
source("R/data_loading.R")

# Prepare and group the data
data_prepared <- airbnb_data$listings %>%
  mutate(year = format(date, "%Y")) %>%
  group_by(neighbourhood_cleansed, year)

# Calculate descriptive statistics
stats <- data_prepared %>%
  summarise(
    mean_price = mean(price, na.rm = TRUE),
    median_price = median(price, na.rm = TRUE),
    sd_price = sd(price, na.rm = TRUE),
    mean_reviews = mean(number_of_reviews, na.rm = TRUE),
    median_reviews = median(number_of_reviews, na.rm = TRUE),
    sd_reviews = sd(number_of_reviews, na.rm = TRUE)
  ) %>%
  ungroup()

# Generate a styled table
stats %>%
  kable("html", caption = "Estadísticos descriptivos por municipio y año") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)
```

---

## Notes  

- Ensure the `data_loading.R` script is in the correct directory and contains the `airbnb_data` object with a `listings` dataset.  
- Columns `date`, `price`, `neighbourhood_cleansed`, and `number_of_reviews` must exist in the dataset.  
- The table output is optimized for HTML rendering and may require an appropriate R Markdown or HTML viewer.  

---

## Summary  

The `01_solution.R` script processes the Airbnb listings data to calculate and display key descriptive statistics for each municipality and year, enabling further analysis and insights into pricing and review trends.

---

# Normality Assessment of Prices and Reviews  

**Author**: Michele Gentile  
**File**: `02_solution.R`  

---

## Description  

This script assesses the normality of the distributions of prices and reviews for Airbnb listings in specific municipalities of Mallorca. It focuses on the municipalities of **Pollença** and **Palma de Mallorca** for listings on **2024-09-13**. The script filters the data based on a valid price range and generates visualizations to assess normality. These visualizations include histograms, kernel density estimates, and normal distribution curves.

---

## Dependencies  

The script relies on the following R libraries:  
- `tidyverse` : For data manipulation and filtering.  
- `ggplot2` : For generating plots and visualizations.  

Ensure that the `data_loading.R` script is sourced to provide the necessary datasets.

---

## Data Input  

This script uses the `listings` dataset, which is loaded from the `data_loading.R` script. The dataset is expected to contain the following columns:  
- `date` : Date of the listing.  
- `neighbourhood_cleansed` : Municipality name (Pollença, Palma de Mallorca, etc.).  
- `price` : Price of the listing.  
- `number_of_reviews` : Number of reviews for the listing.  

---

## Steps  

1. **Load Data**  
   - The script sources the `data_loading.R` file to load the `airbnb_data` object, which contains the `listings` dataset.

2. **Filter Data**  
   - Filters the dataset for the specified date (`2024-09-13`) and locations (`Pollença` and `Palma de Mallorca`).  
   - Filters listings for prices between 50 and 400 (valid price range).  

3. **Plot Distribution**  
   The function `plot_distribution()` generates the following plots for each variable:  
   - **Histogram**: A histogram of the variable values, scaled to density.  
   - **Kernel Density**: A smoothed curve to show the distribution of values.  
   - **Normal Density Curve**: A dashed line representing a normal distribution with the same mean and standard deviation as the data.

   The script generates the following four plots:  
   - Distribution of `price` for **Pollença**.  
   - Distribution of `price` for **Palma de Mallorca**.  
   - Distribution of `number_of_reviews` for **Pollença**.  
   - Distribution of `number_of_reviews` for **Palma de Mallorca**.  

4. **Display Plots**  
   - The four plots are printed in sequence to visualize the distributions.

---

## Example Run  

```r
# Load necessary libraries
library(tidyverse)
library(ggplot2)

# Source the data
source("R/data_loading.R")

# Filter the data
data_filtered <- airbnb_data$listings %>%
  filter(
    date == as.Date("2024-09-13"),
    neighbourhood_cleansed %in% c("Pollença", "Palma de Mallorca"),
    price > 50 & price < 400
  )

# Function to plot distribution
plot_distribution <- function(data, variable, location) {
  data_subset <- data %>% filter(neighbourhood_cleansed == location)
  values <- data_subset[[variable]]
  mean_val <- mean(values, na.rm = TRUE)
  sd_val <- sd(values, na.rm = TRUE)

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

# Generate and print plots
plot_price_pollenca <- plot_distribution(data_filtered, "price", "Pollença")
plot_price_palma <- plot_distribution(data_filtered, "price", "Palma de Mallorca")
plot_reviews_pollenca <- plot_distribution(data_filtered, "number_of_reviews", "Pollença")
plot_reviews_palma <- plot_distribution(data_filtered, "number_of_reviews", "Palma de Mallorca")

print(plot_price_pollenca)
print(plot_price_palma)
print(plot_reviews_pollenca)
print(plot_reviews_palma)
```

---

## Output  

The script generates four plots to assess the normality of distributions:  
1. **Price Distribution in Pollença**: Histogram, kernel density, and normal density curve for listing prices in Pollença.  
2. **Price Distribution in Palma de Mallorca**: Histogram, kernel density, and normal density curve for listing prices in Palma de Mallorca.  
3. **Number of Reviews Distribution in Pollença**: Histogram, kernel density, and normal density curve for the number of reviews in Pollença.  
4. **Number of Reviews Distribution in Palma de Mallorca**: Histogram, kernel density, and normal density curve for the number of reviews in Palma de Mallorca.

Each plot provides a visual check for the normality of the data.  

---

## Notes  

- The `plot_distribution()` function is flexible and can be used to plot distributions for any numeric variable and location.  
- Ensure the `data_loading.R` script is correctly sourced to load the `airbnb_data` object with the relevant dataset.  
- The date filtering and price range are set to specific values in this script. Adjust these parameters as needed for different analyses.

---

## Summary  

The `02_solution.R` script provides a comprehensive visual assessment of the normality of `price` and `number_of_reviews` distributions for Airbnb listings in **Pollença** and **Palma de Mallorca**. The generated plots can be used to assess the suitability of normality assumptions for further statistical modeling or analysis.

---

# Price Comparisons Between Municipalities  

**Authors**: Angus Pelegrin, Michele Gentile  
**File**: `03_solution.R`  

---

## Description  

This script compares the mean prices of Airbnb listings between two municipalities in Mallorca, **Palma de Mallorca** and **Pollença**, based on listings priced between 50 and 400 EUR. The script performs a hypothesis test to evaluate whether the mean price in **Pollença** is significantly greater than the mean price in **Palma de Mallorca**.

---

## Dependencies  

The script relies on the following R libraries:  
- `tidyverse` : For data manipulation and filtering.  
- `dplyr` : For filtering data and summarizing results.  
- `kableExtra` : For creating and styling HTML tables.  

Ensure that the `data_loading.R` script is sourced correctly to provide the necessary datasets.

---

## Data Input  

This script uses the `listings` dataset, which is loaded from the `data_loading.R` script. The dataset is expected to contain the following columns:  
- `neighbourhood_cleansed` : Municipality name (either "Palma de Mallorca" or "Pollença").  
- `price` : Price of the listing.

---

## Steps  

1. **Filter Data**  
   - The script filters the listings to include only those in **Palma de Mallorca** and **Pollença**, with prices between 50 and 400 EUR.  
   - Prices are extracted using `pull()` to create two separate vectors: `palma_prices` and `pollensa_prices`.  

2. **Calculate Mean Prices**  
   - The script calculates the mean prices for both **Palma de Mallorca** and **Pollença** using `mean()`.  

3. **Hypothesis Testing**  
   A one-tailed t-test is performed to compare the mean prices between the two municipalities. The hypotheses are as follows:  
   - **Null hypothesis (H0)**: The mean price in **Pollença** is less than or equal to the mean price in **Palma de Mallorca**.  
   - **Alternative hypothesis (H1)**: The mean price in **Pollença** is greater than the mean price in **Palma de Mallorca**.  
   The t-test is performed using the `t.test()` function, with the `alternative = "greater"` argument to test if **Pollença** has a higher mean price.  

4. **Extract Test Results**  
   - The `p-value`, `confidence interval`, and difference in means between the two municipalities are extracted from the t-test result.

5. **Conclusion**  
   - A conclusion is drawn based on the p-value:
     - If the p-value is less than 0.05, the null hypothesis is rejected, indicating that the mean price in **Pollença** is significantly higher than in **Palma de Mallorca**.
     - If the p-value is greater than or equal to 0.05, the null hypothesis is not rejected.

6. **Display Results**  
   - A table summarizing the mean prices, difference in means, p-value, and confidence interval is generated using `kable()`.  
   - The conclusion is printed as a textual output.

---

## Example Run  

```r
# Load necessary libraries
library(tidyverse)
library(dplyr)
library(kableExtra)

# Source the data
source("R/data_loading.R")

# Filter data for Palma and Pollença
palma_prices <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca", price >= 50, price <= 400) %>%
  pull(price)

pollensa_prices <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Pollença", price >= 50, price <= 400) %>%
  pull(price)

# Calculate mean prices
mean_palma <- mean(palma_prices)
mean_pollensa <- mean(pollensa_prices)

# Perform t-test for hypothesis testing
t_test_result <- t.test(pollensa_prices, palma_prices, alternative = "greater")

# Extract p-value and confidence interval
p_value <- t_test_result$p.value
conf_int <- t_test_result$conf.int
diff_means <- mean_pollensa - mean_palma

# Draw conclusion
conclusion <- ifelse(p_value < 0.05, 
                     "Rechazamos la hipótesis nula: El precio medio en Pollença es mayor que en Palma.", 
                     "No podemos rechazar la hipótesis nula: No hay evidencia suficiente de que el precio medio en Pollença sea mayor que en Palma.")

# Create results table
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

# Print conclusion
print(conclusion)
```

---

## Output  

The script generates a table displaying the following results:  
- **Precio medio Palma**: The mean price of listings in **Palma de Mallorca**.  
- **Precio medio Pollença**: The mean price of listings in **Pollença**.  
- **Diferencia de precios**: The difference in mean prices between **Pollença** and **Palma de Mallorca**.  
- **P-valor**: The p-value from the hypothesis test.  
- **Intervalo de confianza**: The 95% confidence interval for the difference in means.

Additionally, a textual conclusion is printed based on the p-value of the hypothesis test, indicating whether there is enough evidence to claim that the mean price in **Pollença** is higher than in **Palma de Mallorca**.

---

## Notes  

- Ensure that the `data_loading.R` script is correctly sourced to load the `airbnb_data` object with the relevant dataset.  
- The hypothesis test assumes that the prices in both municipalities follow a normal distribution and that the variances are approximately equal. Further checks could be added to validate these assumptions.
- Adjust the price filtering conditions as needed to analyze different price ranges.

---

## Summary  

The `03_solution.R` script compares Airbnb listing prices between **Palma de Mallorca** and **Pollença** using a hypothesis test. It calculates the mean prices, performs a t-test to assess whether the mean price in **Pollença** is significantly higher than in **Palma de Mallorca**, and presents the results in a table with a conclusion based on the p-value.

---

# Temporal Price Variations  

**Authors**: Angus Pelegrin, Michele Gentile  
**File**: `04_solution.R`  

---

## Description  

This script analyzes the temporal price variations of Airbnb listings in **Palma de Mallorca** by comparing the mean prices on two different dates: **2023-12-17** and **2024-03-23**. The script performs a hypothesis test to determine if there is a statistically significant difference in the mean prices between these two dates. A boxplot is also created to visually compare the price distributions.

---

## Dependencies  

The script relies on the following R libraries:  
- `tidyverse` : For data manipulation and filtering.  
- `dplyr` : For filtering data and summarizing results.  
- `kableExtra` : For creating and styling HTML tables.  

Ensure that the `data_loading.R` script is sourced correctly to provide the necessary datasets.

---

## Data Input  

The script uses the `listings` dataset, which is loaded from the `data_loading.R` script. The dataset should contain the following columns:  
- `neighbourhood_cleansed` : Municipality name (in this case, "Palma de Mallorca").  
- `date` : The date of the listing price.  
- `price` : Price of the listing.

---

## Steps  

1. **Filter Data**  
   - The script filters the `listings` dataset to extract the listings from **Palma de Mallorca** on two different dates: **2023-12-17** and **2024-03-23**.  
   - The filtered price data is extracted using `pull()` for the two dates, creating `palma_prices_2023` and `palma_prices_2024`.

2. **Calculate Mean Prices**  
   - The script calculates the mean prices for **2023-12-17** and **2024-03-23** using `mean()`.

3. **Hypothesis Testing**  
   A one-tailed t-test is performed to compare the mean prices between the two dates. The hypotheses are as follows:  
   - **Null hypothesis (H0)**: The mean price on **2023-12-17** is greater than or equal to the mean price on **2024-03-23**.  
   - **Alternative hypothesis (H1)**: The mean price on **2023-12-17** is less than the mean price on **2024-03-23**.  
   The t-test is performed using the `t.test()` function, with the `alternative = "less"` argument to test if the mean price has increased in 2024.

4. **Extract Test Results**  
   - The `p-value`, `confidence interval`, and mean difference between the two dates are extracted from the t-test result.

5. **Visualize Results**  
   - A boxplot is created using the `boxplot()` function to visually compare the price distributions between the two dates, with separate boxes for each date.

6. **Conclusion**  
   - A conclusion is drawn based on the p-value:
     - If the p-value is less than 0.05, the null hypothesis is rejected, indicating that the mean price on **2023-12-17** is significantly lower than on **2024-03-23**.
     - If the p-value is greater than or equal to 0.05, the null hypothesis is not rejected.

7. **Display Results**  
   - A table summarizing the mean prices, difference in means, p-value, and confidence interval is generated using `kable()`.  
   - The conclusion is printed as a textual output.

---

## Example Run  

```r
# Load necessary libraries
library(tidyverse)
library(dplyr)
library(kableExtra)

# Source the data
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

# Hypothesis testing
t_test_result <- t.test(palma_prices_2023, palma_prices_2024, alternative = "less")

# Extract p-value and confidence interval
p_value <- t_test_result$p.value
conf_int <- t_test_result$conf.int

# Calculate mean difference
mean_diff <- mean_palma_2023 - mean_palma_2024

# Present results
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

# Print conclusion
if (p_value < 0.05) {
  print("Rechazamos la hipótesis nula: Los precios medios en 2023-12-17 son significativamente menores que en 2024-03-23.")
} else {
  print("No podemos rechazar la hipótesis nula: No hay evidencia suficiente de que los precios medios en 2023-12-17 sean menores que en 2024-03-23.")
}
```

---

## Output  

The script generates a table displaying the following results:  
- **Media 2023-12-17**: The mean price of listings on **2023-12-17** in **Palma de Mallorca**.  
- **Media 2024-03-23**: The mean price of listings on **2024-03-23** in **Palma de Mallorca**.  
- **Diferencia de medias**: The difference in mean prices between **2023-12-17** and **2024-03-23**.  
- **P-valor**: The p-value from the hypothesis test.  
- **Intervalo de confianza**: The 95% confidence interval for the difference in means.

Additionally, a boxplot is generated to visually compare the price distributions between the two dates. The conclusion is printed based on the p-value of the hypothesis test, indicating whether there is enough evidence to claim that the mean price in **2023-12-17** was significantly lower than in **2024-03-23**.

---

## Notes  

- Ensure that the `data_loading.R` script is correctly sourced to load the `airbnb_data` object with the relevant dataset.  
- The hypothesis test assumes that the prices on both dates follow a normal distribution and that the variances are approximately equal. Further checks could be added to validate these assumptions.
- Adjust the date filtering conditions as needed for different time points or municipalities.

---

## Summary  

The `04_solution.R` script compares Airbnb listing prices in **Palma de Mallorca** between **2023-12-17** and **2024-03-23**. A hypothesis test is performed to assess if the mean price on **2024-03-23** is significantly higher than on **2023-12-17**, and the results are presented in a table with a visual boxplot for comparison.

---

# Proportion of High-Rated Apartments

**Authors**: Finn Dicke, Michele Gentile  
**File**: `05_solution.R`

---

## Description

This script analyzes the proportion of high-rated Airbnb apartments (with a rating above 4) in the municipalities of **Palma de Mallorca** and **Pollença** on **2024-03-23**. The script calculates the proportions of high-rated apartments in both municipalities, compares these proportions, and provides a 95% confidence interval for the difference in proportions.

---

## Dependencies

The script relies on the following R libraries:  
- `tidyverse`: For data manipulation and filtering.  
- `kableExtra`: For creating and styling HTML tables.

Ensure that the `data_loading.R` script is sourced correctly to provide the necessary datasets.

---

## Data Input

The script uses the `listings` dataset, which is loaded from the `data_loading.R` script. The dataset should contain the following columns:
- `neighbourhood_cleansed`: Municipality name (either **"Pollença"** or **"Palma de Mallorca"**).
- `date`: The date of the listing.
- `review_scores_rating`: The rating given to the listing (a numeric value).

---

## Steps

1. **Filter Data**  
   The script filters the dataset to extract the `review_scores_rating` for **Pollença** and **Palma de Mallorca** on **2024-03-23**, removing any missing values (`NA`).

2. **Calculate Proportions**  
   - The proportion of listings with a rating greater than 4 is calculated for both **Pollença** and **Palma de Mallorca**. This is done by calculating the mean of the logical condition `rating > 4`.
   
3. **Sample Sizes**  
   - The number of listings in each municipality is calculated using the `length()` function.

4. **Calculate the Difference in Proportions**  
   - The difference in proportions of high-rated apartments between **Pollença** and **Palma de Mallorca** is computed.

5. **Calculate Standard Error**  
   - The standard error of the difference in proportions is calculated using the formula for the standard error of two proportions.

6. **Critical Value and Confidence Interval**  
   - The critical value for a 95% confidence interval is obtained using the `qnorm()` function for the standard normal distribution.
   - The confidence interval for the difference in proportions is then calculated by adding and subtracting the critical value times the standard error.

7. **Present Results**  
   - A table summarizing the proportions, the difference in proportions, and the 95% confidence interval is generated using `kable()`.

---

## Example Run

```r
# Load necessary libraries
library(tidyverse)
library(kableExtra)

# Source the data
source("R/data_loading.R")

# Filter data for Palma and Pollença on 2024-03-23
rating_Pollença <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Pollença", date == "2024-03-23") %>%
  pull(review_scores_rating) %>%
  na.omit()

rating_Palma <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca", date == "2024-03-23") %>%
  pull(review_scores_rating) %>%
  na.omit()

# Calculate proportions and sample sizes
p_Pollença <- mean(rating_Pollença > 4)
n_Pollença <- length(rating_Pollença)

p_Palma <- mean(rating_Palma > 4)
n_Palma <- length(rating_Palma)

# Calculate difference in proportions
diferencia <- p_Pollença - p_Palma

# Calculate standard error
error <- sqrt((p_Pollença * (1 - p_Pollença) / n_Pollença) + 
                (p_Palma * (1 - p_Palma) / n_Palma))

# Critical value for a 95% confidence interval
z <- qnorm(0.975)

# Confidence interval for the difference in proportions
intervalo <- c(diferencia - z * error, diferencia + z * error)

# Present results
results <- data.frame(
  "Proporción Palma" = p_Palma,
  "Proporción Pollença" = p_Pollença,
  "Diferencia de Proporciones" = diferencia,
  "IC 95% Inferior" = intervalo[1],
  "IC 95% Superior" = intervalo[2]
)

# Display results as a table
kable(results, caption = "Intervalo de confianza para la diferencia de proporciones") %>%
  kable_styling(full_width = FALSE)
```

---

## Output

The script generates a table displaying the following results:
- **Proporción Palma**: The proportion of listings in **Palma de Mallorca** with a rating greater than 4.
- **Proporción Pollença**: The proportion of listings in **Pollença** with a rating greater than 4.
- **Diferencia de Proporciones**: The difference in proportions between **Pollença** and **Palma de Mallorca**.
- **IC 95% Inferior**: The lower bound of the 95% confidence interval for the difference in proportions.
- **IC 95% Superior**: The upper bound of the 95% confidence interval for the difference in proportions.

The results are displayed in a table, and the 95% confidence interval helps assess whether the difference in proportions is statistically significant.

---

## Notes

- Ensure that the `data_loading.R` script is correctly sourced to load the `airbnb_data` object with the relevant dataset.
- The 95% confidence interval for the difference in proportions is based on the assumption of independent samples and normal approximations of the binomial distribution for the proportions.
- You can adjust the filtering dates or municipalities in the script for different analyses.

---

## Summary

The `05_solution.R` script calculates the proportion of high-rated Airbnb listings in **Palma de Mallorca** and **Pollença** on **2024-03-23**, compares the proportions, and computes a 95% confidence interval for the difference between them. The results are summarized in a table, which provides insights into the relative rating distributions between the two municipalities.

---

# Comparative Proportion Analysis

**Authors**: Finn Dicke, Michele Gentile  
**File**: `06_solution.R`

---

## Description

This script compares the proportion of high-rated Airbnb listings (ratings above 4) in **Palma de Mallorca** and **Pollença** on two different dates: **2023-12-17** and **2024-03-23**. The script calculates the proportions of high-rated listings for each municipality and period, and computes the differences in proportions between the two areas, providing 95% confidence intervals for these differences.

---

## Dependencies

The script relies on the following R libraries:  
- `dplyr`: For data manipulation, filtering, and calculation.
- `kableExtra`: For generating and styling HTML tables.

Ensure that the `data_loading.R` script is sourced correctly to provide the necessary datasets.

---

## Data Input

The script uses the `listings` dataset, which is loaded from the `data_loading.R` script. The dataset should contain the following columns:
- `neighbourhood_cleansed`: Municipality name (either **"Pollença"** or **"Palma de Mallorca"**).
- `date`: The date of the listing.
- `review_scores_rating`: The rating given to the listing (a numeric value).

---

## Steps

1. **Define Functions**  
   - `calculate_proportion()`: This function calculates the proportion of listings with a rating greater than 4 for a given municipality and date.
   - `calculate_sample_size()`: This function calculates the sample size (number of listings) for a given municipality and date.

2. **Calculate Proportions and Sample Sizes**  
   The script calculates the proportion of high-rated listings and the sample size for both **Palma de Mallorca** and **Pollença** on both **2023-12-17** and **2024-03-23**.

3. **Calculate Differences in Proportions**  
   The difference in proportions of high-rated listings between **Palma de Mallorca** and **Pollença** is calculated for both periods.

4. **Calculate Standard Errors**  
   The standard error for the difference in proportions is calculated using the formula for two proportions.

5. **Compute Confidence Intervals**  
   The critical value for a 95% confidence interval is obtained using the `qnorm()` function. The confidence intervals for the difference in proportions are then calculated by adding and subtracting the critical value times the standard error.

6. **Present Results**  
   The results are summarized in a table, which shows the proportions, differences, and 95% confidence intervals for both periods.

---

## Example Run

```r
# Load necessary libraries
library(dplyr)
library(kableExtra)

# Source the data
source("R/data_loading.R")

# Function to calculate proportion of ratings > 4
calculate_proportion <- function(data, neighbourhood, date) {
  data %>%
    filter(neighbourhood_cleansed == neighbourhood, date == date) %>%
    pull(review_scores_rating) %>%
    na.omit() %>%
    {. -> ratings; mean(ratings > 4)}
}

# Sample sizes function
calculate_sample_size <- function(data, neighbourhood, date) {
  data %>%
    filter(neighbourhood_cleansed == neighbourhood, date == date) %>%
    pull(review_scores_rating) %>%
    na.omit() %>%
    length()
}

# Proportions and sample sizes for Palma
p_Palma_2023 <- calculate_proportion(airbnb_data$listings, "Palma de Mallorca", "2023-12-17")
n_Palma_2023 <- calculate_sample_size(airbnb_data$listings, "Palma de Mallorca", "2023-12-17")

p_Palma_2024 <- calculate_proportion(airbnb_data$listings, "Palma de Mallorca", "2024-03-23")
n_Palma_2024 <- calculate_sample_size(airbnb_data$listings, "Palma de Mallorca", "2024-03-23")

# Proportions and sample sizes for Pollença
p_Pollença_2023 <- calculate_proportion(airbnb_data$listings, "Pollença", "2023-12-17")
n_Pollença_2023 <- calculate_sample_size(airbnb_data$listings, "Pollença", "2023-12-17")

p_Pollença_2024 <- calculate_proportion(airbnb_data$listings, "Pollença", "2024-03-23")
n_Pollença_2024 <- calculate_sample_size(airbnb_data$listings, "Pollença", "2024-03-23")

# Calculate differences of proportions (Palma and Pollença combined across years)
diferencia_2023 <- p_Palma_2023 - p_Pollença_2023
diferencia_2024 <- p_Palma_2024 - p_Pollença_2024

# Standard error calculation
error_2023 <- sqrt((p_Palma_2023 * (1 - p_Palma_2023) / n_Palma_2023) +
                     (p_Pollença_2023 * (1 - p_Pollença_2023) / n_Pollença_2023))
error_2024 <- sqrt((p_Palma_2024 * (1 - p_Palma_2024) / n_Palma_2024) +
                     (p_Pollença_2024 * (1 - p_Pollença_2024) / n_Pollença_2024))

# Critical value for 95% confidence interval
z <- qnorm(0.975)

# Confidence intervals
ci_2023 <- c(diferencia_2023 - z * error_2023, diferencia_2023 + z * error_2023)
ci_2024 <- c(diferencia_2024 - z * error_2024, diferencia_2024 + z * error_2024)

# Results
results <- data.frame(
  Period = c("2023-12-17", "2024-03-23"),
  Palma_Proportion = c(p_Palma_2023, p_Palma_2024),
  Pollenca_Proportion = c(p_Pollença_2023, p_Pollença_2024),
  Difference = c(diferencia_2023, diferencia_2024),
  CI_Lower = c(ci_2023[1], ci_2024[1]),
  CI_Upper = c(ci_2023[2], ci_2024[2])
)

# Display results
kable(results, caption = "Diferencia de proporciones entre Palma y Pollença") %>%
  kable_styling(full_width = FALSE)
```

---

## Output

The script generates a table displaying the following results for both **2023-12-17** and **2024-03-23**:

- **Palma Proportion**: The proportion of listings in **Palma de Mallorca** with a rating greater than 4.
- **Pollença Proportion**: The proportion of listings in **Pollença** with a rating greater than 4.
- **Difference**: The difference in proportions of high-rated listings between **Palma de Mallorca** and **Pollença**.
- **CI Lower**: The lower bound of the 95% confidence interval for the difference in proportions.
- **CI Upper**: The upper bound of the 95% confidence interval for the difference in proportions.

This allows for an evaluation of how the proportions of high-rated apartments in these two municipalities compare across the two periods.

---

## Notes

- Ensure that the `data_loading.R` script is correctly sourced to load the `airbnb_data` object with the relevant dataset.
- The 95% confidence interval helps assess whether the difference in proportions between the two municipalities is statistically significant.
- You can modify the dates or municipalities in the script for further analyses.

---

## Summary

The `06_solution.R` script calculates and compares the proportions of high-rated Airbnb listings (ratings above 4) in **Palma de Mallorca** and **Pollença** for two different dates. The differences in proportions are computed, along with 95% confidence intervals for these differences, allowing for a statistical comparison of the high-rating distributions between the two locations across time.

---

# Zipf's Law Analysis on Review Comments

**Author**: Michele Gentile  
**File**: `07_solution.R`

---

## Description

This script applies **Zipf's Law** to analyze the distribution of review comment lengths for listings in **Palma de Mallorca**. Zipf's Law states that in many linguistic and human behavior datasets, the frequency of an item (such as a word or comment length) is inversely proportional to its rank. The script calculates the frequency distribution of comment lengths, performs regression analyses, and visualizes the results to assess how closely the data adheres to Zipf's Law.

---

## Dependencies

The script relies on the following R libraries:  
- `tidyverse`: For data manipulation and visualization.
- `stringr`: For string operations, such as counting words in the comments.

Ensure that the `data_loading.R` script is sourced correctly to provide the necessary datasets.

---

## Data Input

The script uses the following dataset:
- **`airbnb_data$listings`**: Contains details of Airbnb listings, including their `id` and `neighbourhood_cleansed`.
- **`airbnb_data$reviews`**: Contains reviews for listings, including the `listing_id` and `comments`.

The analysis focuses on **Palma de Mallorca** by filtering listings and reviews for that specific neighbourhood.

---

## Steps

1. **Extract Listings in Palma**  
   The script first filters the listings to include only those in **Palma de Mallorca** and retrieves their `id`s.

2. **Extract Reviews for Palma Listings**  
   Reviews corresponding to the listings in **Palma de Mallorca** are filtered, and the length of each review comment is calculated in terms of the number of words.

3. **Calculate Frequency of Comment Lengths**  
   The frequency distribution of review comment lengths is computed.

4. **Rank and Transformations**  
   The script ranks the comment lengths by frequency, then calculates the log-transformed values of both frequency and rank to facilitate Zipf's Law analysis.

5. **Linear Regression Models**  
   Three regression models are fitted:
   - **Frequency vs. Rank**.
   - **Frequency vs. Log(Rank)**.
   - **Log(Frequency) vs. Log(Rank)**, which is most relevant for Zipf's Law analysis.

6. **Plot the Results**  
   Three plots are generated to visualize the relationships:
   - **Frequency vs Rank**.
   - **Frequency vs Log(Rank)**.
   - **Log(Frequency) vs Log(Rank)**.

7. **Interpretation**  
   - The **log-log regression** is particularly important for Zipf’s Law, where a slope near **-1** and a high **R-squared** value suggest that the data adheres to Zipf's Law.

---

## Example Run

```r
# Load required libraries
library(tidyverse)
library(stringr)

# Source the data
source("R/data_loading.R")

# Save all the listings in Palma
palma_listing_ids <- airbnb_data$listings %>%
  filter(neighbourhood_cleansed == "Palma de Mallorca") %>%
  pull(id)  # Extract as a vector

# Extract only the reviews for Palma
palma_reviews <- airbnb_data$reviews %>%
  filter(as.character(listing_id) %in% as.character(palma_listing_ids))

# Calculate the length of each comment in words
palma_reviews <- palma_reviews %>% 
  mutate(comment_length = str_count(comments, "\\w+"))

# Compute the frequency of each comment length
length_freq <- palma_reviews %>% 
  count(comment_length, name = "frequency") %>% 
  arrange(desc(frequency))

# Add rank and log transformations for Zipf's analysis
length_freq <- length_freq %>% 
  mutate(
    rank = rank(-frequency, ties.method = "first"), # Rank by descending frequency
    log_frequency = log(frequency),
    log_rank = log(rank)
  ) %>% 
  filter(rank > 10 & rank < 1000) # Filter for specific rank range

# Perform linear regressions
# Regression of frequency vs. rank
model_freq_rank <- lm(frequency ~ rank, data = length_freq)
summary(model_freq_rank)

# Regression of frequency vs. log(rank)
model_freq_logrank <- lm(frequency ~ log_rank, data = length_freq)
summary(model_freq_logrank)

# Regression of log(frequency) vs. log(rank) - most relevant for Zipf's law
model_logfreq_logrank <- lm(log_frequency ~ log_rank, data = length_freq)
summary(model_logfreq_logrank)

# Plot the results
# Frequency vs Rank
ggplot(length_freq, aes(x = rank, y = frequency)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Frequency vs Rank",
    x = "Rank",
    y = "Frequency"
  ) +
  theme_minimal()

# Frequency vs Log(Rank)
ggplot(length_freq, aes(x = log_rank, y = frequency)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(
    title = "Frequency vs Log(Rank)",
    x = "Log(Rank)",
    y = "Frequency"
  ) +
  theme_minimal()

# Log(Frequency) vs Log(Rank)
ggplot(length_freq, aes(x = log_rank, y = log_frequency)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "green") +
  labs(
    title = "Log(Frequency) vs Log(Rank)",
    x = "Log(Rank)",
    y = "Log(Frequency)"
  ) +
  theme_minimal()

# Interpretation:
# Compare the R-squared values and coefficients from the three models:
# - High R-squared in log-log regression suggests adherence to Zipf's law.
# - A slope near -1 in the log-log regression further supports Zipf's law.
```

---

## Output

The script generates the following outputs:

1. **Linear Regression Summaries**  
   - **Frequency vs. Rank**: Provides the relationship between frequency and rank for comment lengths.
   - **Frequency vs. Log(Rank)**: Analyzes the relationship with a logarithmic rank transformation.
   - **Log(Frequency) vs. Log(Rank)**: The most crucial model for Zipf’s Law, where the expected slope should be close to **-1**.

2. **Plots**  
   - **Frequency vs Rank**: A scatter plot with a linear regression line to visualize the relationship between frequency and rank.
   - **Frequency vs Log(Rank)**: A plot to visualize how frequency behaves against the logarithmic transformation of rank.
   - **Log(Frequency) vs Log(Rank)**: A log-log plot that is key to determining whether the data follows Zipf’s Law, with the expected slope close to **-1**.

---

## Notes

- The **log-log regression** is the primary method to test Zipf’s Law. A high **R-squared** value and a **slope near -1** suggest that the data adheres to Zipf's Law.
- The script filters the data for ranks between 10 and 1000 to focus on the most common comment lengths, avoiding noise from very rare or very common lengths.
- You can modify the filtering range or change the neighbourhood for different analyses.

---

## Summary

The `07_solution.R` script analyzes the distribution of review comment lengths for listings in **Palma de Mallorca** using Zipf’s Law. It computes the frequency distribution of comment lengths, ranks them, and performs linear regression analyses to assess how closely the data follows Zipf’s Law. The results are visualized through scatter plots and analyzed based on the **log-log regression**, with the slope providing key insights into the adherence to Zipf’s Law.
