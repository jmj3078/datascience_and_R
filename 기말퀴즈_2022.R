setwd("/Users/j-max/Documents/datascience_and_R/")
youth <- read.csv("youth_survey.csv")
View(youth)
attach(youth)
#question 1
youth$exercise <- Q68
youth$exercise[Q68_1 == 1] <- 1 
youth$exercise[Q68_1 == 2] <- 2
youth$exercise[Q68_1 == 3] <- 3
youth$exercise[Q68_1 == 4] <- 4
youth$exercise[Q68_1 == 5] <- 5
youth$exercise[Q68_1 == 6] <- 6
youth$exercise[Q68_1 == 7] <- 7
youth$exercise[Q68 == 2] <- 0

table(youth$exercise)

#question 2
install.packages("gmodels")
library(gmodels)
chisq.test(DQ1, Q34)
#p value < 0.05 
#남녀 분포와 창업의사 분포는 독립하지 않다(상관관계 있음)
table(DQ1, Q34)
CrossTable(DQ1, Q34)
#실제 창업을 한 남자 비율 : (전체기준) 0.034
#실제 창업을 한 여자 비율 : (전체기준) 0.028

#question 
install.packages("ggplot2")
library("ggplot2")

ggplot(youth, aes(x=Q28, y=Q45, group=Q28))+
  geom_boxplot()

aggregate(Q45~Q28, youth, mean)
#그룹별 평균
aov.Q28_Q45 = aov(Q28 ~ Q45)
summary(aov.Q28_Q45)
#청년수당 지급에 대한 의견에 따라 소득수준의 평균값 비교
#p-value 0.587 , 신뢰도 낮음
#F value < 1. 세 그룹간의 평균에 큰 차이 없다

#question 4
cor.test(DQ3, Q66)
#p-value < 0.05, 상관관계 존재
#상관계수 : -0.05916474, 부적상관관계
#부모의 소득이 높을수록 본인의 체형이 마르다고 생각함

#question 5
mreg1 <- lm(Q73 ~ Q61 + Q67A1 + youth$exercise, 
            data = youth)
summary(mreg1)
#설명력 : 6.04%

#Q61 : 상관게수 0.076896, p-value  =  0.00107 상관관계 있음
#신체적으로 건강하다고 느낄수록 행복한 삶을 위한 조건이 있다고 여긴다(정적상관관계)
#Q67A : 상관게수 0.193151, p-value  = 2e-16 높은 상관관계
#즐거운 기분임을 자주 느낄수록 행복한 삶을 위한 조건이 있다고 여긴다(정적상관관계)
#Q61 : 상관게수 0.018065, p-value  = 0.03764 상관관계 있음
#운동을 자주 할수록 행복한 삶을 위한 조건이 있다고 여긴다(정적상관관계)

#회귀식 : 
#Y = 2.259458 + 0.076896*X1 + 0.193151*X2 + 0.018065*X3 + error

#question 6
Q70[Q70 == 2] <- 0
table(Q70)
log.reg <- glm(Q70 ~ Q66 + Q69 + DQ3,
               family = binomial)
summary(log.reg)
#Q69, 외모의 중요성이 유효한 독립변수 (p<0.05)
#외모를 중요하게 여길 수록 성형수술 확률이 높다

#question7
install.packages("ggmap")
library(ggmap)
register_google(key="AIzaSyA5x0d6cLHBXNGA9SSgoYpjvaM0jy-kNNE")

park_name <- c("잠실 롯데월드","용인 에버렌드","홍천 비발디파크")
park <- geocode(enc2utf8(park_name))
park
df_park <- data.frame(name = park_name,
                      lon = park$lon,
                      lat = park$lat)
df_park

cn <- c(mean(df_park$lon), mean(df_park$lat))
cn

map <- get_googlemap(center= cn,
                     maptype= "roadmap",
                     zoom = 10,
                     markers = park)
park_map <- ggmap(map)
park_map + geom_text(data=df_park,
                     aes(x=lon, y=lat),
                     label= df_park$name,
                     size = 5,
                     col = "red")

