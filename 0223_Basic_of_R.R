search()
install.packages("ggplot2")
library(ggplot2) #package >> library

a <- c(1,2,3,4,5) #array 
mean(a) #mean value 

1+1
22+24
123-23
33*3
5/2
5%%2
3**4

round(1.4)
round(1.22324, digits = 3)
ceiling(2.3) #올림
floor(3.6) #내림
trunc(5.12) #반올림
abs(10)
abs(-10)

log(100)
log(8, base = 3)
log2(8)
log10(100)

a <- 100
b <- 120
a - b
a + b

vec_a <- c(1,2,3,4) #vector list
vec_b <- c(1,2,3,4,5) #vector list
vec_a * a #python처럼 vector값을 곱하는 형태로 진행된다
vec_b * b 
vec_a - a
vec_b - b

vec_a + vec_b #error, vector 길이 차이

#변수 삭제 : rm(), rm(list = Is())
#Is() : 모든 저장된 변수를 불러오는 함수
mean(vec_a) #평균값
max(vec_a)
min(vec_a)
range(vec_a) #R에선 0이 아니라 1부터 시작한다... 개불편;;
median(vec_a) #중앙값

var(vec_a) #분산
sd(vec_a) #표준편차
sqrt(var(vec_a)) #제곱근

#True False / 
10 == 10
3 <= 8
5 < 4
5 == 8

var <- 1:200
str(var) #구조 
length(var) #길이

#sequence
seq(1,10,2) # 1 to 10, gap = 2
seq(0.1,1.0,0.2)
seq(3,30,3)
seq(-1, -100, -5) #간격이 더해지는 것으로 처리되기 때문에 음수로 적어야함

#repeat
rep(1, times = 10) #x를 10번 반복
rep(1:3, times = 3)
rep(1:5, times = 3)
rep(c(1,3,5), times = 3)
rep(seq(1,10,2), times = 3)
rep(1:3, each = 3) #x를 각각 3번 반복, 모든 벡터에 똑같이 적용된다
rep(seq(1,10,2), each = 3)


#sampling (random한 샘플 추출)
sample(1:10, 4)
sample(30:50, 5)

x1 <- ("hello world!")
x2 <- (c("1","2"))
x3 <- c(3,4,5)

str(x1)
str(x2)
str(x3)

paste(x1,x2) 
paste(x1,x3) #원소들이 c나 rep으로 묶여있으면 순서대로 각각 대치하여 붙인다
paste(x2, x1)
paste(x3, x1)
