# Data Documentation: Airbnb Mallorca

## Overview

This document describes the data used for analyzing Airbnb listings, reviews, and neighborhoods in Mallorca, Spain. The datasets are sourced from Inside Airbnb, providing insights into property details, reviews, and spatial geography.

---

## **Datasets**

### 1. **Listings Data** (`listing_common0_select`)

**Description**:  
This dataset contains information about Airbnb properties in Mallorca, filtered to include only apartments that appear in **four time periods**. Each property is identified by a unique combination of `id` and `date`.

**Time Periods**:  
The dataset includes observations from these dates:
- `2023-12-17`
- `2024-03-23`
- `2024-06-19`
- `2024-09-13`

**Structure**:
- **Rows**: 52,088  
- **Columns**: 16  

**Variables**:
| Variable                 | Type       | Description                                                                 |
|--------------------------|------------|-----------------------------------------------------------------------------|
| `date`                  | Date       | Observation date of the listing.                                            |
| `id`                    | Character  | Unique identifier for each Airbnb listing.                                  |
| `price`                 | Numeric    | Price per night in the local currency.                                      |
| `longitude`             | Numeric    | Longitude coordinate of the property.                                       |
| `latitude`              | Numeric    | Latitude coordinate of the property.                                        |
| `property_type`         | Character  | Type of property (e.g., Entire home, Entire villa, etc.).                   |
| `room_type`             | Character  | Type of room available (e.g., Entire home/apt, Private room).               |
| `accommodates`          | Numeric    | Number of guests the property can accommodate.                              |
| `bedrooms`              | Numeric    | Number of bedrooms (may contain missing values).                            |
| `beds`                  | Numeric    | Number of beds.                                                             |
| `number_of_reviews`     | Numeric    | Total number of reviews for the property.                                   |
| `review_scores_rating`  | Numeric    | Average review rating score (0–5 scale, missing if no reviews).             |
| `review_scores_value`   | Numeric    | Value rating score from reviews (0–5 scale).                                |
| `host_is_superhost`     | Logical    | Whether the host is a superhost (`TRUE` or `FALSE`).                        |
| `host_name`             | Character  | Name of the host.                                                           |
| `neighbourhood_cleansed`| Character  | Name of the neighborhood where the property is located.                     |

**Notes**:  
- Each property appears **4 times**, corresponding to the 4 sampled time periods.
- Missing values exist for certain variables like `bedrooms` and `review_scores_rating`.

---

### 2. **Reviews Data** (`reviews`)

**Description**:  
This dataset contains user reviews for Airbnb properties in Mallorca.

**Structure**:
- **Rows**: 344,651  
- **Columns**: 6  

**Variables**:
| Variable         | Type       | Description                                                     |
|------------------|------------|-----------------------------------------------------------------|
| `listing_id`     | Numeric    | Identifier linking the review to a specific Airbnb listing.     |
| `id`            | Numeric    | Unique identifier for each review.                              |
| `date`          | Date       | Date the review was posted.                                     |
| `reviewer_id`   | Numeric    | Unique identifier for the reviewer.                             |
| `reviewer_name` | Character  | Name of the reviewer.                                           |
| `comments`      | Character  | Text content of the review.                                     |

**Special Notes**:  
- The columns `listing_id`, `id`, and `reviewer_id` are **numeric**, while `date` and `comments` are `character`.
- Reviews provide qualitative insights into user experiences and feedback.

---

### 3. **Neighborhoods Data** (`neighbourhoods.csv`)

**Description**:  
This dataset contains information about the names of neighborhoods (municipios) in Mallorca.

**Structure**:
- **Rows**: 53  
- **Columns**: 2  

**Variables**:
| Variable               | Type       | Description                                                       |
|------------------------|------------|-------------------------------------------------------------------|
| `neighbourhood_group` | Logical    | Grouping of neighborhoods (contains only `NA` values).            |
| `neighbourhood`       | Character  | Name of the neighborhood/municipality.                            |

**Notes**:  
- This dataset is a simple mapping of neighborhood names without spatial geometries.

---

### 4. **Geospatial Data** (`neighbourhoods.geojson`)

**Description**:  
This is a **GeoJSON** file containing geospatial information for neighborhoods in Mallorca. It provides polygon geometries that define the boundaries of each neighborhood.

**Structure**:
- **Features**: 53  
- **Fields**: 2  

**Variables**:
| Variable               | Type           | Description                                               |
|------------------------|----------------|-----------------------------------------------------------|
| `neighbourhood_group` | Logical        | Grouping variable for neighborhoods (contains `NA`).      |
| `neighbourhood`       | Character      | Name of the neighborhood/municipality.                    |
| Geometry              | MULTIPOLYGON   | Geometrical representation of neighborhood boundaries.    |

**Geospatial Details**:
- **Coordinate Reference System (CRS)**: WGS 84  
- **Bounding Box**:  
  - xmin: `2.303195`  
  - ymin: `39.26403`  
  - xmax: `3.479028`  
  - ymax: `39.96236`  

**Visualization**:  
The geospatial data can be visualized using R libraries like `sf` and `tmap`.

---

## **Summary**

The datasets provide detailed information about Airbnb listings, reviews, and geospatial boundaries in Mallorca. The combination of these datasets enables comprehensive analysis, including spatial mapping, property trends, and user feedback analysis.

**Datasets Included**:
1. `listing_common0_select` (Listings data)
2. `reviews` (Reviews data)
3. `neighbourhoods.csv` (Neighborhood names)
4. `neighbourhoods.geojson` (Geospatial neighborhood boundaries)

For further variable explanations, consult the official [Inside Airbnb documentation](https://insideairbnb.com/get-the-data.html).