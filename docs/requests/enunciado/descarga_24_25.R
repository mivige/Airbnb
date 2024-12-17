#install.packages("tidyverse")
library(tidyverse)
# Alternatively, install just rvest:
#install.packages("rvest")
library(rvest)
library(R.utils)
#https://data.insideairbnb.com/united-states/ny/albany/2024-01-06/visualisations/neighbourhoods.csv

# Albany 
files_data <- c("listings.csv.gz",
                       "calendar.csv.gz",
                       "reviews.csv.gz")
files_visualisations <- c("neighbourhoods.geojson","neighbourhoods.csv")
#https://data.insideairbnb.com/united-states/ny/albany/2024-01-06/data/listings.csv.gz
#https://data.insideairbnb.com/united-states/ny/albany/2024-01-06/visualisations/neighbourhoods.geojson
url1 <- "https://data.insideairbnb.com/united-states/ny/albany/"
url2 <- "https://data.insideairbnb.com/united-states/ny/albany/"
date_file=c("2024-09-05","2024-08-07","2024-07-06","2024-06-07","2024-05-06",
            "2024-04-08","2024-03-10","2024-02-14","2024-01-06","2023-12-06",
            "2023-11-27","2023-10-01")
area="albany"

create_dir <- function(dir) {
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
}

dir.create(paste0("data/",area))
dirs=paste0("data/",area,"/",date_file)
sapply(dirs,create_dir)


for (i in 1:length(date_file)) {
  for (j in 1:length(files_data)) {
    destfile=paste0("data/",area,"/",date_file[i],"/",files_data[j])
    if (!file.exists(destfile)){
    download.file(paste0(url1,date_file[i],"/data/",files_data[j]),
                  destfile)}
    #R.utils::gunzip(destfile, remove = FALSE)
  }
for (j in 1:length(files_visualisations)) {
  destfile=paste0("data/",area,"/",date_file[i],"/",files_visualisations[j])
  if (!file.exists(destfile)){  
  download.file(paste0(url1,date_file[i],"/visualisations/",
                         files_visualisations[j]),destfile)}
  
  }
}



# Valencia 
files_data <- c("listings.csv.gz",
                "calendar.csv.gz",
                "reviews.csv.gz")
files_visualisations <- c("neighbourhoods.geojson","neighbourhoods.csv")
url1 <- "https://data.insideairbnb.com/spain/vc/valencia/"
url2 <- "https://data.insideairbnb.com/spain/vc/valencia/"
date_file=c("2024-06-22","2024-03-24","2023-12-18")
area="valencia"

create_dir <- function(dir) {
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
}

dir.create(paste0("data/",area))
dirs=paste0("data/",area,"/",date_file)
sapply(dirs,create_dir)


for (i in 1:length(date_file)) {
  for (j in 1:length(files_data)) {
    destfile=paste0("data/",area,"/",date_file[i],"/",files_data[j])
    if (!file.exists(destfile)){
      download.file(paste0(url1,date_file[i],"/data/",files_data[j]),
                  destfile)}
    #R.utils::gunzip(destfile, remove = FALSE)
  }
  for (j in 1:length(files_visualisations)) {
    destfile=paste0("data/",area,"/",date_file[i],"/",files_visualisations[j])
    if (!file.exists(destfile)){
      download.file(paste0(url1,date_file[i],"/visualisations/",
                         files_visualisations[j]),destfile)}
    
  }
}



# Mallorca 
files_data <- c("listings.csv.gz",
                "calendar.csv.gz",
                "reviews.csv.gz")
files_visualisations <- c("neighbourhoods.geojson","neighbourhoods.csv")
url1 <- "https://data.insideairbnb.com/spain/islas-baleares/mallorca/"
url2 <- "https://data.insideairbnb.com/spain/islas-baleares/mallorca/"
date_file=c("2024-09-13","2024-06-19","2024-03-23","2023-12-17")
area="mallorca"

create_dir <- function(dir) {
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
}

dir.create(paste0("data/",area))
dirs=paste0("data/",area,"/",date_file)
sapply(dirs,create_dir)


for (i in 1:length(date_file)) {
  for (j in 1:length(files_data)) {
    destfile=paste0("data/",area,"/",date_file[i],"/",files_data[j])
    if (!file.exists(destfile)){
      download.file(paste0(url1,date_file[i],"/data/",files_data[j]),
                  destfile)}
    #R.utils::gunzip(destfile, remove = FALSE)
  }
  for (j in 1:length(files_visualisations)) {
    destfile=paste0("data/",area,"/",date_file[i],"/",files_visualisations[j])
    if (!file.exists(destfile)){
    download.file(paste0(url1,date_file[i],"/visualisations/",
                         files_visualisations[j]),destfile)}
    
  }
}

# Menorca 
files_data <- c("listings.csv.gz",
                "calendar.csv.gz",
                "reviews.csv.gz")
files_visualisations <- c("neighbourhoods.geojson","neighbourhoods.csv")
url1 <- "https://data.insideairbnb.com/spain/islas-baleares/menorca/"
url2 <- "https://data.insideairbnb.com/spain/islas-baleares/menorca/"
date_file=c("2024-06-30","2024-03-31","2023-12-30","2023-09-25")
area="menorca"

create_dir <- function(dir) {
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
}

dir.create(paste0("data/",area))
dirs=paste0("data/",area,"/",date_file)
sapply(dirs,create_dir)


for (i in 1:length(date_file)) {
  for (j in 1:length(files_data)) {
    destfile=paste0("data/",area,"/",date_file[i],"/",files_data[j])
    if (!file.exists(destfile)){
    download.file(paste0(url1,date_file[i],"/data/",files_data[j]),
                  destfile)}
    #R.utils::gunzip(destfile, remove = FALSE)
  }
  for (j in 1:length(files_visualisations)) {
    destfile=paste0("data/",area,"/",date_file[i],"/",files_visualisations[j])
    if (!file.exists(destfile)){
    download.file(paste0(url1,date_file[i],"/visualisations/",
                         files_visualisations[j]),destfile)}
    
  }
}

