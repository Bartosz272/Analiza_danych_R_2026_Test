##ROBIE TESTY CZY DZIAŁA


if(!require('tidyverse')) install.packages('tidyverse')
library(tidyverse)
install.packages('dplyr')
install.packages('tidyr') 



library(readr)
knitr::opts_chunk$set(echo = TRUE)
download.file("https://raw.githubusercontent.com/kflisikowski/ds/master/netflix-dataset.csv?raw=true", destfile ="dane.csv",mode="wb")
dane<-read.csv(file="dane.csv",encoding ="UTF-8",header=TRUE,sep = ",")
attach(dane)


##CHALLENGE 1

dane %>%
  filter(str_detect(Director, "Woody Allen") & Series.or.Movie == "Movie") %>%
  arrange(Release.Date) %>%
  select(Title, Release.Date, Director) %>%
  head(10)






