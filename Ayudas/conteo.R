library(stringr)
library(tidyverse)
reviews <- read.csv("../data/albany/2024-01-06/reviews.csv")

reviews = reviews %>% mutate(N_words=str_count(comments, boundary("word")))
reviews %>% select(N_words) %>% summary(N=n(),mean=mean,median=median,sd=sd)
reviews %>% select(N_words) %>% ggplot(aes(N_words)) + geom_histogram(bins=100)
+ theme_minimal() + labs(title="Albany",x="Number of words",y="Frequency")

