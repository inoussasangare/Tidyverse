#preparation de l'espace de travail
rm(list = ls())
setwd("~/Logiciel R/Tidyverse")
#les libraries
library(tidyverse)
library(nycflights13)
not_cancelled <- flights |> filter(!is.na(arr_delay))
flights |> filter(month==12)
not_cancelled |> group_by(year, month, day) |> 
  summarise(mean=mean(dep_delay))

