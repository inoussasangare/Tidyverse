#preparation de l'espace de travail
rm(list = ls())
setwd("~/Logiciel R/Tidyverse")
#principe de base du codage
1/200*30
(59+73+2)/3
sin(pi/2)
x <- 3*4
#object name
x
this_is_a_really_long_name <- 2.5
this_is_a_really_long_name
# vectors
r_rock <- 2^3
seq(1,10)
#ecercice
#1 i en leiu et place de l
library(tidyverse)

data(mpg)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
diamonds
filter(diamonds, carat > 3)
#3 help keyboard shorcut
