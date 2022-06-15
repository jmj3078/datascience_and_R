getwd()
setwd("/Users/j-max/Documents/datascience_and_R")
life <- read.csv(file = "life.csv")
attach(life)

#상관관계 분석 : corelation test
plot(v5, v15)
cor.test(v5, v15) 
#정적 상관관계 있음을 확인

#산점도 그래프 그리되, 카테고리별 분류, group과 유사
pairs(iris[1:4], pch=21, bg = c("red","green","blue"))
pairs(iris[1:4], pch= 21,
      bg = c("red", "green", "blue")[unclass(iris$Species)])
# pch 21~25일때 bg설정 가능, 기억해 둘것

install.packages("corrplot")
#상관관계 package
library(corrplot)
econ <- life[, 85:90]
#경제질문 30번~35번 문항에 대한 답
View(econ)
sum(is.na(econ)) #총 결손값 크기
econ <- na.omit(econ) #결손값 제거 

cor(econ) #상관계수 행렬 : 30~35사이의 상관계수
#상관계수가 클 수록 상관관계가 있음을 알 수 있음
round(cor(econ), 2)
plot(econ) #산점도 행렬
pairs(econ, panel = panel.smooth) #추세선 추가
#상관관계가 있을 수록 감소하거나 증가하는 추세선을 보임

cor_mtx = cor(econ)
corrplot(cor_mtx) #상관관계 heatmap으로 표현,
#여러가지 수치에 대한 상관관계를 시각화 하기 가장 편함
corrplot(cor_mtx, method = "number",
         type = "lower",
         tl.srt = 45)
#그래프 기울이기

install.packages("psych")
library(psych)
#피어슨 상관계수를 통한 상관관계 해석, p값 제공
corr.test(econ, use = "complete", #결측값 제거
          method = "pearson",
          adjust = "none")

sci <- life[, c(181,182,186)]
sum(is.na(sci))
sci <- na.omit(sci)
sci_mtx <- cor(sci)
sci_mtx #상관계수 r
corrplot(sci_mtx) #상관관계 시각화
corrplot(sci_mtx,
         mthod = "number",
         type = "lower",
         tl.srt = 45)

#상관계수 p값 통한 상관관계 분석
#0.05보다 작으면 0으로 출력(상관관계 높음)
corr.test(sci,
          use= "complete",
          method= "pearson")

#회귀분석
reg1 <- lm(v29~ v86, data = life)
reg1 <- lm(v29~ v86 ) #종속변수~ 독립변수
summary(reg1)
#R^2 : 회귀선의 설명력, 두 변수간의 관계성이 높다. 설명력이 높다.
#Y 절편/ 회귀 계수(기울기), P value 
#결정계수 : R-squared - 설명력, adjusted가 보통의 경우 활용됨
#p값이 작기 때문에 유의미하다 (p < 0.05) - 귀무가설 반박 가능
plot(v86, v29)
abline(reg1, col="red")

reg2 <- lm(v5~ v86)
summary(reg2)
plot(v86, v5)
abline(reg2, col = "red")
#회귀식 y = 0.319x + 5.01 + error
#Adjusted R-squared:  0.09514, 9.5%의 설명력을 가진 모델

reg3 <- lm(v41~ v29)
summary(reg3)
plot(v29, v41)
abline(reg3, col="red")

reg4 <- lm(v30 ~ v15)
summary(reg4)
plot(v15, v30)
abline(reg4, col= "red")

#이분변수로 측정된 경우(예, 아니오) 
#0과 1으로 변수를 변환하여 진행
plot(v48, v5)
v48[v48 == 2] <- 0
reg5 <- lm(v5 ~ v48)
summary(reg5)
abline(reg5, col="red")
