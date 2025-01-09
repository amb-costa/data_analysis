# sin readr, read_csv no funciona
# sin dplyr, la canalizacion no funciona
install.packages("tidyverse")
library(tidyverse)
library(readr)
library(dplyr)

firstmonth <- read_csv("data_analysis/finalproject_1/divvy_trips/202401-divvy-tripdata.csv")

firstmonth %>%
  filter(end_station_name=="Kingsbury St & Kinzie St")
  

