#preparation de l'espace de travail
rm(list = ls())
setwd("~/Logiciel R/Tidyverse")
#library
pacman::p_load(tidyverse, stats)

#create tibbles
vignette("tibble")
?iris
data(iris)
iris
as_tibble(iris)
tb_iris <- as_tibble(iris)
tibble(x=1:5, 
       y = 1,
       z = x^2 + y)
tb <- tibble(`:)`= "smile",
             ` ` = "space",
             `2000`="number")
tb
tribble(
  ~x, ~y, ~z,
  #--|--|---
  "a", 2, 3.6,
  "b", 1, 8.5
)
tibble(iris)
iris
str(iris)
tibble(
  a= lubridate::now() + runif(1e3) * 86400,
  b= lubridate::today()+ runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
e = sample(letters, 1e3, replace = T)
)
?runif
runif(1e3)
nycflights13::flights |> print(n = 10, width = Inf)
package?tibble
help(package="tibble")
nycflights13::flights |> 
  View()
# extrection des sousensembles
(df <- tibble(
  x = runif(5),
  y = rnorm(5)
))
df$x
df[["x"]]
df[[1]]
df |> .$x
df |> .[["x"]]
?pipe
#interagir avec du code ancien
class(as.data.frame(tb))
