if(!require('tidyverse')) install.packages('tidyverse')
library(tidyverse)
install.packages('dplyr')
install.packages('tidyr') 
install.package('stringr')


library(readr)
knitr::opts_chunk$set(echo = TRUE)
download.file("https://raw.githubusercontent.com/kflisikowski/ds/master/netflix-dataset.csv?raw=true", destfile ="dane.csv",mode="wb")
dane<-read.csv(file="dane.csv",encoding ="UTF-8",header=TRUE,sep = ",")
attach(dane)







