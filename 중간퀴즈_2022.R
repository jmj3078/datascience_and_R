#Question 1
title <- c("오징어게임","지옥")
production_cost <- c(250,200)
episode <- c(9,6)
director <- c("황동혁","연상호")

drama <- data.frame(title, production_cost, episode, director)
drama

drama$production_cost_by_episode <- production_cost / episode
drama

#Question 2
state <- data.frame(state.x77)

state$incomelevel <- NA
state$incomelevel
state$incomelevel[state$Income >= 4500] <- "high"
state$incomelevel[state$Income >= 4000 & state$Income < 4500] <- "mid"
state$incomelevel[state$Income < 4000] <-"low"

#빈도분석
table(state$incomelevel)
freq_incomelevel <- table(state$incomelevel)

#boxplot
boxplot(Income ~incomelevel,
        data = state,
        col = c("red","blue","gold"),
        main = "Income distribution by 3 level")

#Question 3
install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)

View(mpg)
cars <- filter(mpg, mpg$year >= 2000)

model.cty_mean <- cars %>%
  group_by(model) %>% 
  summarize(cty_mean = mean(cty)) 

my_model.cty_mean <- model.cty_mean[c(23,5,37,29), ]

ggplot(my_model.cty_mean, aes(model, cty_mean))+
  geom_bar(stat = 'identity')

#Question 4
install.packages("treemap")
library(treemap)
data(GNI2014)
View(GNI2014)

europe.GNI2014 <- GNI2014[GNI2014$continent == "Europe", ]  
europe.GNI2014

treemap(europe.GNI2014,
        index = c("iso3"),
        vSize = "population",
        vColor = "GNI",
        type = "value")

#Question 5
View(airquality)

a <- airquality %>%
  group_by(Month) %>% 
  summarize(ozone_mean = mean(Ozone, na.rm = T))

a

may <- airquality[airquality$Month == 5, ]
june <- airquality[airquality$Month == 6, ]
july <- airquality[airquality$Month == 7, ]
aug <- airquality[airquality$Month == 8, ]
sep <- airquality[airquality$Month == 9, ]

may$Ozone[is.na(may$Ozone)] <- a[1, 2]
june$Ozone[is.na(june$Ozone)] <- a[2, 2]
july$Ozone[is.na(july$Ozone)] <- a[3, 2]
aug$Ozone[is.na(aug$Ozone)] <- a[4, 2]
sep$Ozone[is.na(sep$Ozone)] <- a[5, 2]

airquality2 <- rbind(may,june,july,aug,sep)
airquality2

plot()

