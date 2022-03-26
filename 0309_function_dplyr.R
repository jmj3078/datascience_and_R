#0309
#function
Y <- function(x){
  Y <- x+10
  return(Y)
}

Y(20)
Y(35)

multi <- function(x,y){
  multi <- x*y
  return(multi)
}

multi(2,5)
multi(5,5)

abc <- function(a,b,c){
  add <- a+b
  sub <- a-b
  return(c(add, sub))
}
# <- 대신 = 써도 무관하다.
abc(10,30,50)
abc(4,5,19)

BMI <- function(kg,m){
  BMI <- kg/(m^2)
  return(BMI)
}
BMI(90,1.88)

install.packages('dplyr')
library(dplyr)
search() #package 확인
x <- c(5,7,9,11,13,15,55)
mean(x)
sqrt(mean(x))
round(sqrt(mean(x)), 2)     

x %>% mean %>% sqrt %>% round(2) #괄호를 쓰지 않고 하이포 문산자로 연산

View(mtcars)
mtcars[mtcars$cyl ==6, ]
subset(mtcars, subset = cyl == 6) #부분집합 형성 #원하는 행만 추출, 내장함수
filter(mtcars, cyl == 6) #  조건에 따른 정렬

subset(mtcars, subset = cyl == 6 & am ==1)
subset(mtcars, subset = cyl == 6 | am ==1)
subset(mtcars, subset = mpg >= 25)

mtcars %>%
  filter(hp>150)
mtcars %>%
  filter(cyl ==6 | am ==1)
mtcars %>%
  filter(gear %in% c(4,5)) #gear값이 4, 5인 행을 모두 추출, dplyr

mtcars %>%
  filter(carb %in% c(1,2)) 

mtcars[, c(3,5)] #특정 열 추출
mtcars[, "cyl"] #특정 열을 벡터 형태로 추출함, 다르게 출력

mtcars_df <- mtcars %>%
  select(mpg, cyl) #mpg, cyl 열만 추출, dplyr
mtcars_df #dataframe 형식 유지

arrange(mtcars_df, cyl, mpg) #순서에 따라 오름차순 정렬 순서가 달라짐, dplyr
arrange(mtcars_df, mpg, cyl)
#sort는 벡터에만 사용하는 함수다
#특정 열 기준으로 group화 - group_by, summarize 함수 (dplyr)
mtcars$cyl
table(mtcars$cyl) #빈도분석
a <- mtcars %>%
  group_by(cyl) %>% #cyl에 따라 그룹 나누기
  summarize(mpg평균 = mean(mpg)) #cyl 그룹 나누고 mpg평균값 구하기

a
mean(mtcars$mpg)

View(iris)
table(iris$species) #빈도분석
mean(iris$Sepal.Length)
b <- iris %>%
  group_by(Species) %>%
  summarize(Sepal_length_mean = mean(Sepal.Length))

b
mean(b$Sepal_length_mean) #총 평균값과 당연히 같게 출력된다.
#mutate 함수,새로운 열 생성 - dplyr함수
women #무작위 여성 키 몸무게를 기록해둔 내용
mutate(women, h.cm = height*2.54, w.kg= weight*0.45) #열 추가

