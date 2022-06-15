#logistic 회귀분석
setwd('/Users/j-max/Documents/datascience_and_R')
life <- read.csv('life.csv')
attach(life)
View(life)
table(v2) #행복한가
life$happy <- life$v2
life$happy[life$happy == 1] <- 1
life$happy[life$happy == 2] <- 1
life$happy[life$happy == 3] <- 0
life$happy[life$happy == 4] <- 0

prop.table(table(life$happy))
#행복하다/행복하지 않다를 이항으로 나눔(1, 0)
log.reg1 <- glm(life$happy~ v14+v29+v86, family = binomial)
#이항 로지스틱 회귀 분석
summary(log.reg1)
exp(coef(log.reg1)) #개별 변수의 odds ratio(로그 해제)
# 소득 1단위 증가할 때, 행복할 odds ratio가 1.34배 증가
# exp(0.29325)= 1.34(v86의 오즈비)
# 회귀식 ln(p/1-p)= ax+ b(절편)+ error

# Pseudo R_squared와 p-values
install.packages("rcompanion")
library(rcompanion)
# Nagelkerke의 계산 방식에 따른 R-squared value 계산방식
nagelkerke(log.reg1)

table(v48)   # 신에 대한 믿수
prop.table(table(v48))
life$v48[life$v48 == 2] <- 0
table(v3) # 건강함
table(life$SQ1) # 소득수준
life$SQ1[life$SQ1 == 2] <- 0

log.reg2 <- glm(life$v48~ v3+SQ1+v86, family= binomial)

summary(log.reg2)
t.test(v86~ life$v48)  # ttest 확인
exp(coef(log.reg2))    # 오즈비를 구해라
nagelkerke(log.reg2)   # 모형이 적합한가 판단

healthy <- life$v3
life$healthy  <- healthy   # life 데이터에 열 추가
life$healthy[life$healthy == 1] <- 1   # 건강하다
life$healthy[life$healthy == 2] <- 1   # 건강하다
life$healthy[life$healthy == 3] <- 0   # 건강하지 않다
life$healthy[life$healthy == 4] <- 0   # 건강하지 않다 
prop.table(table(life$healthy))
log.reg3 <- glm(life$healthy~ v14+v29+v86, family= binomial)
#v14 : 자녀 수
#v29 : 정치 성향
#v86 : 소득 수준
summary(log.reg3)
exp(coef(log.reg3)) 
#v29 : 무의미
#자녀수/ 소득수준
#v14 : 자녀 1명 증가할 때 건강할 확률이 0.82배 곱해짐(건강할 확률이 낮아짐)
#v86 : 소득이 한단계 증가할 수록 건강할 확률이 1.27배 커짐(소득과 건강 비례함)


#연습문제 : 29, 40, 70 독립변수 v19 : 종속변수
war <- life$v19
life$war <- war
life$war[life$war == 1] <- 1
life$war[life$war == 2] <- 0
life$war[life$war == 77] <- NA

log.reg4 <- glm(life$war ~ v29+v40+v70, family= binomial)
summary(log.reg4)
#v40, v70 유의미
exp(coef(log.reg4))
#민주국가에 살 수록 전쟁에 나갈 확률 높음
#한국에 사는 것이 자랑스러울수록 전쟁에 나갈 확률 높음
#자랑스러움이 낮아질 때 전쟁에 나갈 확률 높음
nagelkerke(log.reg4) #R-squared
