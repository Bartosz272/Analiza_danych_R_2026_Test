
library(tidyverse)

library(readr)
knitr::opts_chunk$set(echo = TRUE)
download.file("https://raw.githubusercontent.com/kflisikowski/ds/master/netflix-dataset.csv?raw=true", destfile ="dane.csv",mode="wb")
dane<-read.csv(file="dane.csv",encoding ="UTF-8",header=TRUE,sep = ",")
attach(dane)

dane %>%
  transmute(
    Release = Release.Date %>% as.Date(format = '%m/%d/%y')
    ,Netflix.Release = Netflix.Release.Date %>% as.Date(format = '%m/%d/%y')
  )

dane %>%
  filter(Director == "Woody Allen") %>%
  select(Title,Director,Release.Date) %>%
  rank(Release.Date)%>%
  head(10)

#**CHALLENGE 5:** Jakie są średnie oceny filmów wyprodukowanych w poszczególnych dekadach (tzn. lata 60, 70, 80, 90 etc.)?

library(dplyr)
library(lubridate)
library(date)

dane %>%
  transmute(
    Release = Release.Date %>% as.Date(format = '%m/%d/%y')
    ,Netflix.Release = Netflix.Release.Date %>% as.Date(format = '%m/%d/%y')
  )%>%
  dane_new = dane %>% 
  filter(Series.or.Movie == "Movie")%>% 
  select(Title,Director,Release.Date,IMDb.Score)%>% 
  group_by(year = (Release.Date)$year) %>%
  summarise(avg_Score = mean(IMDb.Score),.groups = "drop")


View(dane_new)


# Challenge 5: średnie oceny IMDb według dekad
dane_new <- dane %>%
  filter(Series.or.Movie == "Movie") %>%
  mutate(
    Release = as.Date(Release.Date, format = "%d/%M/%Y"),
    rok     = year(Release),
    dekada  = floor(rok/10)
  ) %>%
  group_by(dekada) %>%
  summarise(
    avg_Score = mean(IMDb.Score, na.rm = TRUE),
    n_filmow  = n(),
    .groups   = "drop"
  ) %>%
  arrange(dekada)

View(dane_new)