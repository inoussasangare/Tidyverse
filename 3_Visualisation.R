#preparation de l'espace de travail
rm(list = ls())

setwd("~/Logiciel R/Tidyverse")
#les libraries
library(tidyverse)
library(munsell)
#intro
data(mpg, package = "ggplot2")
mpg
head(mpg)
?mpg
ggplot(data=mpg)+
  geom_point(aes(x= displ, y=hwy))
#exercice 1
ggplot(data=mpg)
?mpg
mpg
ggplot(data = mpg)+geom_point(mapping = aes(x = cyl, y=hwy))
ggplot(data = mpg)+geom_point(mapping = aes(x = class, y=drv))
#pour mapper une esthétique à varaiable 
ggplot(data=mpg)+geom_point(mapping = aes(x=displ, y=hwy, color=class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
?geom_point()
?aes
# Left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Right
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
?geom_point
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
#Exercice 2
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
?mpg
summary(mpg)
#vignette("ggplot2-specs")
colours()
library(munsell)
help(package="munsell")
mnsl_hues()
complement_slice("5R")
#facettes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(vars(drv), nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)
#exercice
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))+
  facet_grid(drv~cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#la geometrie
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
?geom_smooth
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(method ="loess", formula = y~x)
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = F)
#Exercice
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
#1
ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point(cex=4)+geom_smooth(se=F, lwd=2)
#2
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy),cex=4)+geom_smooth(mapping = aes(x=displ, y=hwy, group=drv),se=F, lwd=2)
#4
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy, color=drv),cex=4)+geom_smooth(mapping = aes(x=displ, y=hwy),se=F, lwd=2)
#3
ggplot(data=mpg,mapping = aes(x=displ, y=hwy, color=drv))+
  geom_point(cex=4)+geom_smooth(se=F, lwd=2)
#5
ggplot(data=mpg)+geom_point(mapping = aes(x=displ, y=hwy, color=drv))+
  geom_smooth(mapping=aes(x=displ, y=hwy, lty=drv),se=F)
#6
ggplot(data = mpg)+geom_point(mapping=aes(x=displ, y=hwy,fill=drv), pch=21, colour="white", cex=5)
?geom_point
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 4, color = "white") + 
  geom_point(aes(color = drv))
# Statical transformations ------------------------------------------------
data("diamonds")
diamonds
?diamonds
ggplot(data=diamonds)+geom_bar(mapping = aes(x=cut))
?geom_bar
ggplot(data=diamonds)+geom_bar(mapping = aes(x=cut))
ggplot(data=diamonds)+stat_count(mapping=aes(x=cut))
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
demo
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
?geom_bar
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )


# Position adjustements ---------------------------------------------------

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, fill= clarity))
#pour changer l'empillement
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, fill=clarity), position = "identity", alpha=1/5 )
ggplot(data = diamonds, mapping = aes(x=cut, colour=clarity))+
  geom_bar(fill=NA,position="identity")
ggplot(data = diamonds)+ geom_bar(mapping = aes(x=cut, fill= clarity), position = "fill")
ggplot(data = diamonds)+ geom_bar(mapping = aes(x=cut, fill= clarity), position = "dodge")
#pour faire spparaitre le surplomb
ggplot(data= mpg, mapping = aes(x=displ, y=hwy))+geom_point(position = "jitter")+
  geom_smooth(se=F, lwd=2)
?geom_jitter
ggplot(data = mpg)+
  geom_jitter(mapping = aes(x = displ, y=hwy))
#exercice
ggplot(data=mpg, mapping= aes(x=cty, y = hwy))+
  geom_point()
?geom_count
ggplot(mpg, aes(cty, hwy)) +
  geom_count()

# Coordinate system -------------------------------------------------------

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# Grammaire des graphiques ------------------------------------------------

