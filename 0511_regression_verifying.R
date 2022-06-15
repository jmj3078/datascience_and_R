attach(mtcars)
plot(hp, mpg)
reg <- lm(mpg~ hp) # hp 증가할수록 mpg 작아짐
abline(reg, col= "green")

reg1 <- lm(mpg~ hp+wt)
summary(reg1)
# hp가 커질수록 wt가 커질수록 연비mpg는 낮아진다 

# 조절효과 항이 유의미한지 확인 x1:x2 넣는다
# 이 모형에서는 wt를 조절변수로 설정함
reg2 <- lm(mpg~ hp+wt+ hp:wt)
summary(reg2)

m<- mean(mtcars$wt)
s<- sd(mtcars$wt)

# 조절효과 그래프
install.packages("effects")
library(effects)
plot(effect(term= "hp:wt", mod = reg2, 
            xlevels= list(wt=c(m-s, m, m+s))),
     lines= list(multiline= TRUE, lwd=2, 
                 lty= c(3,2,1), 
                 col= c("red","blue","purple")))

reg3 <- lm(mpg~ hp+cyl+ hp:cyl)
summary(reg3)

plot(effect(term= "hp:cyl", mod = reg3, 
            xlevels= list(cyl= c(4,6,8))),
     lines= list(multiline= TRUE, lwd=2, 
                 lty= c(1,2,3), 
                 col= c("red","blue","purple")))

setwd('/Users/j-max/Documents/datascience_and_R')
life <- read.csv("life.csv")
attach(life)
reg4 <- lm(v69.6~ v29+v48+ v29:v48)
summary(reg4)
plot(effect(term= "v29:v48", mod = reg4, 
            xlevels= list(cyl= c(4,6,8))),
     lines= list(multiline= TRUE, lwd=2, 
                 lty= c(1,2,3), 
                 col= c("red","blue","purple")))
