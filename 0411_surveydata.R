getwd()
setwd("/Users/j-max/Documents/datascience_and_R")

life <- read.csv(file = "life.csv")
View(life)
dim(life)
is.na(life)
sum(is.na(life)) #결손값 수

#빈도분석, v1.1에서 1 2 3 4 수 계산
table(life$v1.1)
v1.1 <- table(life$v1.1)

#property : 비율
round(prop.table(v1.1),2)

table(life$v2) 
mean(life$v2, na.rm = T) #결손값 무시
#결과 : 1.95 ~ 2(적당히 행복)이 평균적이구나.

attach(life)
#life만 사용 : $없이 접근가능
table(v5)
table(v5, useNA = "ifany") #NA 빈도까지 출력
mean(v5, na.rm = T)
boxplot(v5)

table(v13) #혼인상태
table(v14) #자녀수
v14[v14>3] <- 4 #자녀가 4~7명인 경우를 모두 3명으로...
table(v14) #"4명 이상"으로 만든것
