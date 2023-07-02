#preparation de l'espace de travail
rm(list = ls())
setwd("~/Logiciel R/Tidyverse")
#les libraries
library(tidyverse)
library(nycflights13)
library(extraoperators)
#data
data("flights")
flights
?flights
View(flights)
#filtrer les données
filter(flights, month==1, day==1)
jan1 <- filter(flights, month==1, day==1)
(dec1 <- filter(flights, month==12, day==25))
#comparaison
filter(flights, month==1)
sqrt(2)^2==2
sqrt(2)
sqrt(2)^2
(sqrt(2))^2
sqrt(2)*sqrt(2)
near(sqrt(2)^2,2)
sqrt(2)
filter(flights, month==11|month==12)
dec <- filter(flights, month==11|month==12)
filter(flights, month==12)
filter(flights, month==11)
filter(flights, month %in% c(11,12))
filter(flights, month==xor(11,12))
?base::Logic
nov_dec <- filter(flights, month %in% c(11, 12))
filter(flights, month== !(11 & 12))
filter(flights, month==12) |> select(arr_delay)
#valeur manquantes
df <- tibble(x=c(1,NA,3))
filter(df, x %g% 1)
help(package="extraoperators")
filter(df, x>1)
filter(df, is.na(x) | x %g% 1)

# exercice ----------------------------------------------------------------

?flights
#1
filter(flights, arr_delay %ge% 120 )
flights |> select(arr_delay) |> filter(arr_delay %ge%120)
delyathan2 <- flights |> filter(arr_delay %ge% 120)
#2
houston <- flights |> filter(dest=="HOU"| dest=="IAH")
#3
data(airlines)
airlines
UAD <- flights |> filter(carrier=="UA"| carrier=="AA"| carrier=="DL")
#4
(summer <- flights |> filter(month == 7|month==8 |month ==9))
#5
ret <- flights |> filter(arr_delay%ge% 120  & dep_delay==0)
#6
retar_ratrap <- flights |> filter(dep_delay %ge% 60 & arr_delay %le% 30)
#7
minuit <- flights |> filter(dep_time %gele% c(000, 600))
#8
?dplyr::between()
#between( ) est un raccourci pour trouver une valeur comprise en a et b
between(1:12, 7,9)
#9
manq <- flights |> filter(is.na(dep_time))

# arrange -----------------------------------------------------------------

arrange <- flights |> arrange(year, month,day)
arrange(flights, desc(dep_delay))
df <- tibble(x=c(5,2,NA, 6, 10,11,15,18))
arrange(df,x)
arrange(df, desc(x))
#exercice
arran2 <- arrange(flights, is.na(dep_time))
arrange(df,desc(is.na(x)))
arrange(flights, dep_delay)

# select ------------------------------------------------------------------

select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
select(flights, contains("mon"))
num_range("x", 1:3)
colnames(flights)
?flights
flights2 <- rename(flights, tail_num=tailnum)
colnames(flights2)
flights |> select(time_hour, air_time, everything())

# exercice ----------------------------------------------------------------

#1
flights |> select(air_time, dep_time, dep_delay, arr_delay)
#2
flights |> select(air_time, air_time)
#3
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
?any_of
flights |> select(any_of(vars))
flights[, vars]
#4
select(flights, contains("TIME"))

# mutate ------------------------------------------------------------------

flights_sml <- flights |> select(year:day, ends_with("delay"), distance,
                                 air_time)

flights_sml |> mutate(gain=dep_delay-arr_delay, 
                      speed=distance/air_time*60)
flights_sml |> mutate(gain=dep_delay-arr_delay,
                      hours=air_time/60,
                      gain_per_hours=gain/hours)
flights_sml |> transmute(gain=dep_delay-arr_delay,
                         hours=air_time/60,
                         gain_per_hours=gain/hours)
flights |> transmute(dep_time, hour=dep_time%/% 100,
                     minute = dep_time%/% 100)
transmute(flights, 
          dep_time, 
          hour=dep_time %/% 100,
          minute = dep_time %% 100
)
(x <- 1:10)
lag(x)
lead(x)
x
cummean(x)
cumprod(x)
y <- c(1,2,2,NA, 4,3)
min_rank(y)
min_rank(desc(y))
row_number(y)


# Summarize ---------------------------------------------------------------

flights |> summarize(delay=mean(dep_delay, na.rm=T))
by_day <- flights |> group_by(year, month, day) 
summarise(by_day, delay=mean(dep_delay, na.rm=T))
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count=n(),dist=mean(distance, na.rm=T),
                   delay=mean(arr_delay, na.rm=T))

delay <- delay |> filter(count %g% 20 , dest !="HNL")
ggplot(data=delay, mapping = aes(x=dist, y= delay)) + 
  geom_point(aes(size=count), alpha=1/3) + 
  geom_smooth(se=F)
#entrainement
library(ggvis)
mtcars %>% ggvis(~mpg, ~wt) %>% layer_points()
#valeur manquantes
flights |> group_by(year, month, day) |> 
  summarise(mean = mean(dep_delay))
flights |> group_by(year, month, day) |> 
  summarise(mean = mean(dep_delay, na.rm = T))
(not_concelled <- flights |> 
    filter(!is.na(dep_delay), !is.na(arr_delay)))
not_concelled |> group_by(year, month, day) |> 
  summarise(mean=mean(dep_delay))

sum(!is.na(flights$dep_delay))
sum(is.na(flights$dep_delay))
delays <- not_concelled |> group_by(tailnum) |> 
  summarize(delay = mean(arr_delay))
ggplot(data=delays, mapping = aes(x=delay))+
  geom_freqpoly(binwidth = 10)
delays <- not_concelled |> group_by(tailnum) |> 
  summarise(delay=mean(arr_delay, na.rm=T),
            n=n())
ggplot(data=delays, mapping = aes(x = n, y = delay))+
  geom_point(alpha = 1/10)
delays |> filter(n %g% 25) |> ggplot(mapping = aes(x = n, y = delay))+
  geom_point(alpha=1/10)
#changement de données 
batting <- as_tibble(Lahman::Batting)
?Batting
batters <- batting |> group_by(playerID) |> 
  summarise(
    ba= sum(H, na.rm=T)/sum(AB, na.rm=T),
    ab=sum(AB, na.rm = T)
  )
batters |> filter(ab %g% 100) |> 
  ggplot(mapping = aes(x = ab, y = ba))+
  geom_point()+geom_smooth(se=F)
batters |> arrange(desc(ba))
not_concelled |> group_by(year, month, day) |> summarise(
  avg_delay1 = mean(arr_delay),
  avg_delay2 = mean(arr_delay[arr_delay %g% 0])
)
not_concelled |> group_by(dest) |> summarise(distance_sd = sd(distance)) |> arrange(desc(distance_sd))
not_concelled |> group_by(year, month, day) |>  
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )
not_concelled |> group_by(year, month, day) |> 
  summarize(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )
not_concelled |> group_by(year, month, day) |> 
  mutate(r=min_rank(desc(dep_time))) |> 
  filter(r %in% range(r))

x %in% 3
x %in% range(x)
min_rank(x)
min_rank(desc(x))
not_concelled |> group_by(dest) |> summarise(carriers = n_distinct(carrier)) |> 
  arrange(desc(carriers))
not_concelled |> count(tailnum, wt=distance)
not_concelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))
not_concelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_prop = mean(arr_delay > 60))
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))            
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))
