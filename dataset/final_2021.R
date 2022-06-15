getwd()
setwd("Documents/datascience_and_R/")
life<- read.csv("life.csv")
#question 1
install.packages('dplyr')
library(dplyr)
attach(life)
table(v9.1)
gender <- life %>%
  group_by(v9.1) %>% 
  summarise(평균= mean(v39.9, na.rm= T))
gender

#question2
v72
new72 <- v72
new72[new72==1|new72==2|new72==6|new72==7] <- 1
new72[new72==4] <- 2
new72[new72==3|new72==5] <- 3
table(new72)

#question3
install.packages("ggplot2")
install.packages("gmodels")
library(ggplot2)
library(gmodels)
table(v70, SQ1)
CrossTable(v70, SQ1)
chisq.test(v70, SQ1)
#p value > 0.05 두 분포는 독립이다.
#남성과 여성의 한국인 자부심 정도가 같다.

#question4
aov.v47_v32 = aov(v47 ~ v32)
summary(aov.v47_v32)
#Pr(>F) : 0.487, 경제적 가치관 크게 다르지 않다
means <- life%>% group_by(v47) %>% summarise(평균= mean(v32, na.rm=T))
means
#평균 : 3.52, 3.60, 3.40

#question5
info <- life[, 208:213]
info
install.packages("corrplot")
library(corrplot)
info <- na.omit(info)

round(cor(info),2) #상관계수 행렬

cor.test(v74.3, v74.5)
#p value < 0,05상관관게 존재
plot(v74.3, v74.5, pch=21, panel=panel.smooth)

#question 6
mreg <- lm(v69.7~ SQ1 + SQ3 + v52, data = life)
summary(mreg)
#다중회귀분석 식:
#Y= 5.631270+ 0.123811X1 - 0.042111X2 - 0.088444X3 + error
#설명력 : 8.929%

#question 7
install.packages("car")
library(carData)
library(car)
vif(mreg) #각 독립변수의 vif값 < 5, 문제 없음

#question 8 
v19
v19[v19==1] <- 1
v19[v19==2] <- 0
v19[v19==77] <- NA
v19

log.reg <- glm(v19~ v29+v40+v70, family = binomial)
summary(log.reg) 
#유효한 변수 : v40, v70
