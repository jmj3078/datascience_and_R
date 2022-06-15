# 2차원 분포와 회귀선 
plot(mtcars$wt, mtcars$mpg)
line <- lm(mtcars$mpg~ mtcars$wt)   # Y축변수~ X축변수 
abline(line)   # 회귀선을 그려라 

# 3개의 변수로 3차원 공간에 산점도를 그려보자
install.packages("scatterplot3d")
library(scatterplot3d)
View(mtcars)
model_3d <- scatterplot3d(mtcars$wt, mtcars$hp, mtcars$mpg,
                          xlab = "weight", ylab = "horsepower", 
                          zlab = "miles per gallon",
                          pch=19, type = "h",
                          highlight.3d= T) # 색깔 설정

reg<- lm(mpg~ wt+disp, data= mtcars)  # mpg: 종속변수 
model_3d$plane3d(reg)    # 회귀평면(regression plane) 그려라 

setwd("/Users/j-max/Documents/datascience_and_R")
life <- read.csv(file= "life.csv")  # 데이터 불러오기
attach(life)

# 다중회귀분석
m.reg1 <- lm(v5~ v41+ life$v48+ v86)    # 종속~ 독립1+ 독립2 ....
summary(m.reg1)

# dummy variable(독립변수를 가변수 0, 1로 코딩)
life$v48[life$v48 == 2] <- 0   # 신을 안믿는다 0 믿는다 1
table(life$v48)   # 더미변수 0, 1로 코딩됨
# 전체회귀식 Y= 4.42+ 0.08X1+ 0.36X2+ 0.30X3 +error
# 회귀모형은 삶의 만족을 예측하는데 10.98% 설명력이 있다. 

m.reg2 <- lm(v5~ v14+ v15)     # 종속~ 독립1+ 독립2 ....
summary(m.reg2)
# Y= 3.88 -0.08*X1+ 0.49*X2 + error
# 26.9%의 설명력

m.reg3 <- lm(v74.3~ v78+ v79)     # 종속~ 독립1+ 독립2 ....
summary(m.reg3)
# 모형이 유의미하지 않을때에는 회귀식도 큰 의미는 없음

# 연습문제: 종속변수 정치적성향(v29)/ 독립변수 동성애v69.6 낙태 v69.7  (모형이 유의미한가? 독립변수가 유의미한가? 설명력)
install.packages("lm.beta")  # 표준화 회귀계수
library(lm.beta)
m.reg1 <- lm(v5~ v41+ v48+ v86) 
m.reg1 <- lm.beta(m.reg1)
summary(m.reg1)   # 표준화회귀계수를 포함한 테이블

m.reg2 <- lm(v5~ v14+ v15)     # 종속~ 독립1+ 독립2 ....
m.reg2 <- lm.beta(m.reg2)
summary(m.reg2)v

m.reg3 <- lm(v74.3~ v78+ v79)     # 종속~ 독립1+ 독립2 ....
m.reg3 <- lm.beta(m.reg3)
summary(m.reg3)

# 회귀모형 진단 (다중공선성)
install.packages("car")  # vif값<10 이면 큰 문제없다 
library(car)
vif(m.reg1)
vif(m.reg2)
vif(m.reg3)

install.packages("lmtest")  # Durbin Watson test
library(lmtest)
dwtest(m.reg1)    # p<0.05이므로 잔차의 독립성 기각
dwtest(m.reg2)
dwtest(m.reg3)

# 회귀모형 진단 (잔차의 등분산성, 산점도확인)
par(mfrow= c(2,2))  # 2x2 화면분할
plot(m.reg1)
plot(m.reg2)
plot(m.reg3)
par(mfrow= c(1,1))   # 화면분할 원위치 

r.reg1 <- residuals(m.reg1) #아주 엄격한 테스트임.
shapiro.test(r.reg1) #정규분포에 근사하는지 확인
hist(r.reg1) #histogram 통해 비교 가능
# p < 0.05
r.reg2 <- residuals(m.reg2)
shapiro.test(r.reg2)
hist(r.reg2)

r.reg3 <- residuals(m.reg3)
shapiro.test(r.reg3)
hist(r.reg3)
