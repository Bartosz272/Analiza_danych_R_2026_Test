##CHALLENGE 4:** Jakie są najpopularniejsze tagi dla produkcji dostępnych w języku polskim?
  
  
if(!require('tidyverse')) install.packages('tidyverse')
library(tidyverse)
install.packages('dplyr')
install.packages('tidyr') 


library(readr)
knitr::opts_chunk$set(echo = TRUE)
download.file("https://raw.githubusercontent.com/kflisikowski/ds/master/netflix-dataset.csv?raw=true", destfile ="dane.csv",mode="wb")
dane<-read.csv(file="dane.csv",encoding ="UTF-8",header=TRUE,sep = ",")
attach(dane)


dane %>%
  filter(str_detect(Languages, "Polish")) %>%
  separate_rows(Tags, sep = ",\\s*") %>%
  count(Tags, sort = TRUE) %>%
  head(10)



