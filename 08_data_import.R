#preparation de l'espace de travail
rm(list = ls())
setwd("~/Logiciel R/Tidyverse")
#library
pacman::p_load(tidyverse)
# Reading data from a file ------------------------------------------------

#import data
#students <- read_csv("https://pos.it/r4ds-students-csv")
#write_csv(students, "students.csv")
students <- read_csv("students.csv")
students
#specify na value
students <- read_csv("students.csv", na = c("N/A",""))
students
#rename column
students |> 
  rename(
    student_id = `Student ID`,
    full_name = `Full Name`
  )
#to change column name automatics in snake case
students <- read_csv("students.csv", na = c("N/A",""))
students |> janitor::clean_names()
#tranform meal_plan column to factor
students |> janitor::clean_names() |> 
  mutate(meal_plan = factor(meal_plan)
         )
students
students |> janitor::clean_names() |> 
  mutate(meal_plan = factor(meal_plan),
         age = parse_number(if_else(age == "five", "5", age))
  )
#argument of read_csv
read_csv(
  "a,b,c
  1,2,3
  4,5,6"
)

read_csv(
  "The first line of metadata
  The second line of metadata
  x,y,z
  1,2,3",
  skip = 2
)
read_csv(
  "# A comment I want to skip
  x,y,z
  1,2,3",
  comment = "#"
)

read_csv(
  "1,2,3
  4,5,6",
  col_names = FALSE
)

read_csv(
  "1,2,3
  4,5,6",
  col_names = c("x", "y", "z")
)

# Exercice ----------------------------------------------------------------

read_csv("a,b\n 1,2,3\n4,5,6", skip = 1, col_names = c("a","b","c"))
read_csv("a,b,c\n1,2\n1,2,3,4")
read_csv("a,b\n\"1")
read_csv("a,b\n1,2\na,b")
read_csv("a,b\n1,3")


# controlling column types ------------------------------------------------
read_csv("
  logical,numeric,date,string
  TRUE,1,2021-01-15,abc
  false,4.5,2021-02-15,def
  T,Inf,2021-02-16,ghi
")

simple_csv <- "
  x
  10
  .
  20
  30"
read_csv(simple_csv)
df <- read_csv(
  simple_csv, 
  col_types = list(x = col_double())
)
problems(df)
read_csv(simple_csv, na = ".")
another_csv <- "
x,y,z
1,2,3"

read_csv(
  another_csv, 
  col_types = cols(.default = col_character())
)

#only character column
read_csv(
  "x,y,z
  1,2,3",
  col_types = cols_only(x = col_character())
)



# Reading data from multiple files ----------------------------------------

sales_files <- c(
  "https://pos.it/r4ds-01-sales",
  "https://pos.it/r4ds-02-sales",
  "https://pos.it/r4ds-03-sales"
)
read_csv(sales_files, id = "file")

sales_files <- list.files("data", pattern = "sales\\.csv$", full.names = TRUE)
sales_files
#> [1] "data/01-sales.csv" "data/02-sales.csv" "data/03-sales.csv"
# write a file ------------------------------------------------------------

write_csv(students, "students2.csv")
write_rds(students, "students.rds")
read_rds("students.rds")
library(arrow)
write_parquet(students, "students.parquet")
read_parquet("students.parquet")


# saisie des données ------------------------------------------------------

tibble(
  x = c(1, 2, 5), 
  y = c("h", "m", "g"),
  z = c(0.08, 0.83, 0.60)
)
tribble(
  ~x, ~y, ~z,
  "h", 1, 0.08,
  "m", 2, 0.83,
  "g", 5, 0.60,
)
