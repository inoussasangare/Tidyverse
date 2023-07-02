#preparation de l'espace de travail
rm(list = ls())
getwd()
setwd("~/Logiciel R/Tidyverse")
#les libraries
library(tidyverse)


# données d'allongement ---------------------------------------------------
billboard
billboard |> pivot_longer(
  cols = starts_with("wk"),
  names_to = "week",
  values_to = "rank"
)
billboard |> pivot_longer(
  cols = starts_with("wk"),
  names_to = "week",
  values_to = "rank",
  values_drop_na = TRUE
)
billboard_longer <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE) |>
  mutate(week = parse_number(week))
billboard_longer
# figure

billboard_longer |>
  ggplot(aes(x = week, y = rank, group = track)) +
  geom_line(alpha = 0.25) +
  scale_y_reverse()
df <- tribble(
  ~id, ~bp1, ~bp2,
  "A", 100, 120,
  "B", 140, 115,
  "C", 120, 125
)
df |>
  pivot_longer(
    cols = bp1:bp2,
    names_to = "measurement",
    values_to = "value"
  )