# 🏖️ Mallorca Airbnb Data Analysis  

**📊 Built for:** *Statistics – University of the Balearic Islands (UIB)*  
📆 **Year:** 2024/25
🧑‍💻 **Team Members:** Michele Vincenzo Gentile, Finn Dicke & Angus Pelegrin 

---

## 📖 Project Overview  

This project presents an in-depth **statistical analysis** of Airbnb listings in **Mallorca** 🏝️ across four distinct time periods:  
- 📅 **2023-12-17**  
- 📅 **2024-03-23**  
- 📅 **2024-06-19**  
- 📅 **2024-09-13**  

Through this analysis, we dive into descriptive statistics, hypothesis testing, temporal trends, and explore whether **Zipf's Law** applies to Airbnb review comments.  

---

## 🎯 Objectives  

The project aims to answer **7 key statistical questions**:  

1. **📊 Descriptive Statistics**  
   - Calculate descriptive statistics for `price` and `number_of_reviews` grouped by **municipality** and **time period**.  
   - Present results using **kableExtra** tables.  

2. **📈 Normality Assessment**  
   - For **Pollença** and **Palma** (2024-09-13), study the normality of `price` (filtered between 50 and 400) and `number_of_reviews`:  
     - Plot histograms 📊, kernel density functions, and normal density overlays.  

3. **💰 Price Comparisons**  
   - Test if the mean `price` in Pollença is greater than in Palma for all periods, filtering prices between **50 and 400 euros**.  
   - Perform hypothesis testing, calculate the **p-value** and confidence interval.  

4. **🕒 Temporal Price Changes**  
   - Compare mean `price` in Palma between **2023-12-17** and **2024-03-23**:  
     - Test if prices were lower in December 2023.  
     - Provide **boxplots** for comparison and comment on results.  

5. **⭐ Proportion of High Ratings**  
   - For the period **2024-03-23**, test if the proportion of apartments with `review_scores_rating > 4` in **Palma** and **Pollença** are equal or different.  
   - Construct a confidence interval for the difference in proportions.  

6. **📅 Periodic Comparison of Ratings**  
   - Compare the proportion of apartments with `review_scores_rating > 4` in Palma between **2023-12-17** and **2024-03-23**.  

7. **🔢 Zipf's Law Analysis**  
   - Investigate whether Zipf’s Law applies to the **comment lengths** of Airbnb listings in Palma (2023-12-17).  
   - Conduct a linear regression of **frequency** vs **rank** of comment lengths.  
   - Justify results both statistically 📊 and graphically 📉.  

---

## 🌍 Data Sources  

- **📡 Platform:** [Inside Airbnb](http://insideairbnb.com)  
- **🗺️ Location:** Mallorca, Spain  
- **🕒 Time Periods:**  
   - December 17, 2023  
   - March 23, 2024  
   - June 19, 2024  
   - September 13, 2024  

---

## 🗂️ Repository Structure  

Here’s how the project is organized:  

```
Mallorca-Airbnb-Analysis/
│
├── data/             # Raw and processed data files
├── R/                # R scripts for each analysis question
├── reports/          # Final reports in Rmarkdown and HTML
└── docs/             # Project documentation
```

---

## 🛠️ Required R Packages  

Make sure the following R packages are installed before running the project:  

| **Package**    | **Description**                             |  
|-----------------|--------------------------------------------|  
| `tidyverse`    | Data manipulation and visualization tools   |  
| `kableExtra`   | Enhanced tables in Rmarkdown                |  
| `sf`           | Spatial data handling for mapping           |  
| `tmap`         | Thematic mapping for geospatial data        |  
| `stringr`      | String manipulation                         |  
| `stats`        | Statistical functions and hypothesis tests  |  

### 📦 Installation  

1. Clone the repository:  
   ```bash
   git clone https://github.com/mivige/Airbnb.git
   cd Airbnb
   ```  
2. Install the required R packages:  
   ```R
   install.packages(c("tidyverse", "kableExtra", "sf", "tmap", "stringr", "stats"))
   ```  
3. Ensure the **data files** are in the `data/` directory.  

---

## 📝 License  

This project is licensed under the **MIT License**. Feel free to use, modify, or distribute the code as needed! 🎓  

---

## 👥 Team Members  

Developed with 📊, 🧠, and a hint of ✨ by:  

- **Michele Vincenzo Gentile**  
- **Finn Dicke**  
- **Angus Pelegrin**  

🏫 *University of the Balearic Islands (UIB)*  

---

🎉 If you enjoyed this project or found it helpful, feel free to give it a ⭐ on GitHub! Suggestions and feedback are always welcome. 😊  