#preparation de l'espace de travail
rm(list = ls())
setwd("~/Logiciel R/Tidyverse")
#library
pacman::p_load(tidyverse)
#visulaisation
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
data(diamonds)
?diamonds
diamonds |> count(cut)
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
diamonds |> count(cut_width(carat, 0.5))

