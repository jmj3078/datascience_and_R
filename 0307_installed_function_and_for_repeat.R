library(dplyr)
plot(cars$speed, cars$dist)
abline(cars$speed, car$dist, col="red")

state <- data.frame(state.x77)
plot(state$HS.Grad, state$Income)
x1 <- lm(state$Income~ state$HS.Grad) #linear model, 회귀모델 선언
#독립변수 HS.Grad와 종속변수 state$Income 선언
#두 독립변수와 종속변수 간 상관간계를 분석하는 것이 회귀분석임.
abline(x1, col = "red")
state[-50] #50행 삭제
state[-c(1,3,5),] #1,3,5행 삭제, 모든 열 삭제
state[c(1,3,5),] #1,3,5행만 추출, 모든 열 

state[,-3] #3열 삭제
state[, c(1,3,5)] #1,3,5열 보여주기

names(state) #열 변수 이름
rownames(state) #모든 행의 이름 #행 : row, 열 : column
#matrix나 data.frame에서 행 열의 이름을 지정할때도 사용하는 함수다
rownames(state[24]) #24행의 이름 
colnames(state) #모든 열의 이름
colnames(state[3]) #3열의 이름

which.max(state$Income) #소득이 가장 높은 행 index 반환
state[2,"Income"]
which.min(state$Income) #소득이 가장 낮은 행 index 반환
state[24,"Income"]

order(state$Population) #오름차순
order(state$Population, decreasing = T) #내림차순 

#비교연산자 : True False, bool값
3>5
3<5
3==5

#논리연산자 : 
x <- c(1:10)
x
result1 <- 3<x & x<9 #True와 False로 구성된 vector반환
result1 
x[result1]

result2 <- 3<x | x<9
result2
x[result2]

matrix = matrix(1:20, ncol = 4, nrow = 5)
matrix
r1 = c(1,2,3,4,5)
r2 = c(4,5,6,7,8)
r3 <- data.frame(r1,r2)
r3
matrix>5 #형태가 유지된다
r3>3 #마찬가지로 형태가 유지된다
matrix[matrix>5] #vector 형태로 반환된다.
r3[r3>3] #마찬가지로 vector 형태로 반환된다
#조건문
a <- 10
b <- 9
if(a > 5 & b > 10){
  print(a+b)
}else{
  print(a-b)
}
#같은 의미

score <- 95
if(score >=90){
  grade <- "A"
}else if(score >= 80){
  grade <- "B"
}else if(score >= 70){
  grade <- "C"
}else{
  grade <- "D"
}
grade

for(i in matrix){
  print(i)
}

for(i in 1:10){
  if(i%%2==0){
    cat(i, "even\n")
  }else{
    cat(i, "odd\n")
  }
}
#문자 출역에는 print가 아닌 cat함수를 사용해야 한다

#while
i <- 10
while(i <= 20){
  i <- i+3
  print(i)
}

#repeat, break
i <- 1
repeat{
  print(i)
  if(i>=10){
    break
  }
  i <- i+1
} #break없으면 계속 반복되는 반복문(while에서 조건을 뺀 형태)

#function #함수 이름 <- function(입력인자) 
plus10 <- function(x){
  Y <- x + 10
  return(Y)
}

