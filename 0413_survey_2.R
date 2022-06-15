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

table(v44) #종교 질문에 대한 빈도분석

life$religion <- v44
life$religion[life$religion == 3] <- 4
life$religion[life$religion == 4] <- 4
life$religion[life$religion == 5] <- 4
life$religion[life$religion == 8] <- 4
#소수 인원으로 나온 종교를 전부 다 "기타"항목으로 병합
religion
relig <- table(life$religion)
round(prop.table(relig),2)
#각 보기 별 비율

pie(relig)
barplot(relig,
        names = c("none","catholic","church","temple","others"),
        col = rainbow(5))

#민주주의 국가에 사는 것에 대한 중요성 / 민주주의 수준
table(v40)
table(v41)
boxplot(v40, v41)

#성별
table(SQ1)
gender <- table(SQ1)
barplot(gender, names = c("male", "female"))

#연령대
table(SQ3
mean(SQ3)
range(SQ3)
boxplot(SQ3)

life$SQ3.1[life$SQ3 >= 20 & life$SQ3 < 30] <- "20대"
life$SQ3.1[life$SQ3 >= 30 & life$SQ3 < 40] <- "30대"
life$SQ3.1[life$SQ3 >= 40 & life$SQ3 < 50] <- "40대"
life$SQ3.1[life$SQ3 >= 50 & life$SQ3 < 60] <- "50대"
life$SQ3.1[life$SQ3 >= 60 & life$SQ3 < 70] <- "60대"
life$SQ3.1[life$SQ3 >= 70] <- "70대 이상"


life$SQ3.1
table(life$SQ3.1)
age <- table(life$SQ3.1)
barplot(age)

write.csv(life, file = "life_1.csv")
getwd()

