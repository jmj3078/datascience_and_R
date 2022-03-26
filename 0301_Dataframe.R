#dataframe기초
x1 <- c(1,2,3,4)
x2 <- c(90,80,70,60)
a <- data.frame(x1,x2) #x1, x2로 이뤄진 데이터프레임, x1과 x2가 열이 된다
a
str(a) #변수 a의 구조
dim(a) #4행 2열 구조

colSums(a) #열 총합
colMeans(a) #열 평균
rowSums(a) #행 총합
rowMeans(a) #행 평균

name <- c("유민","윤주","일범","효준") 
age <- c(19,22,20,25)  
major <- c("문헌","문헌","융합","사회") 

#r.class라는 데이터프레임 생성(r은 변수에 .사용가능)
r.class <- data.frame(name, age, major)
r.class
str(r.class)
View(r.class) #새 창으로 보여줌
r.class[2, ] #2행 모든 정보
r.class[,"major" ] #모든 행, major 열
r.class$major #r.class 데이터의 major 변수(벡터)

#열 추가
r.class$toeic <- c(900,910,920,930) #새 열 추가
r.class
#transform함수의 활용

#열 삭제
r.class$age <- NULL
r.class

#rbind를 통한 행 추가
sw <- (list("승원","글경",950)) #추가하고 싶은 리스트(행)
r.class <- rbind(r.class, sw)
r.class

#이름, 혈액형 데이터프레임
name <- c("윤혁","지운","재홍","채윤","수민","대우")  # 문자벡터
bloodtype <- c("a","b","o","ab","o","a")  # 문자벡터 
BT <- data.frame(name, bloodtype) 

str(BT)
table(BT) #bloodtype을 활용한 빈도표 형성

#변수 추가(열)
BT$major <-c("컬쳐","경영","데융","문헌","수학","글경")
BT

#BTS데이터프레임
btsname <-c("RM", "Jin", "Suga", "jhope", "jimin", "V", "JK")
btsyear <-c(1994,1992,1993,1994,1995,1995,1997)
btsposition <-c("rap", "vocal", "rap", "rap", "vocal", "vocal", "vocal")
bts <-data.frame(btsname, btsyear, btsposition)
bts
str(bts)

#변수추가 : 벡터의 계산활용
bts$age <- 2022-bts$btsyear   
bts

# R에 내장된 데이터
View(cars)
str(cars)   # 구조: 데이터프레임
dim(cars) #행렬 구조
names(cars)  # 각 변수의 이름?? 
mean(cars$speed) #speed 행에서의 평균
mean(cars$dist) #dist 행에서의 평균
hist(cars$speed) #히스토그램
plot(cars$speed, cars$dist) # 산점도 그래프(x축, y축)
abline(cars$speed, cars$dist, col="red")  # 데이터에 기반한 직선(회귀선)

state.x77   # 내장데이터, 매트릭스, 미주에 대한 다양한 정보
View(state.x77)  #state.x77를 별도의 탭에서 보여줘
dim(state.x77)  # 몇행 몇열?
head(state.x77) # 6행까지 출력
names(state.x77)  # 매트릭스라 NULL출력 df로 변환해줘야 함
# dataframe의 요소들(speed, dist등) 이름을 출력하는 역할이다.
class(state.x77)  # 데이터 형태 출력, matrix, array라고 나온다.

state <- data.frame(state.x77) #matrix를 data.frame으로 변환
View(state)
dim(state)
head(state)
names(state) #dataframe으로 바뀌었기에 열에 해당되는 변수 이름이 출력됨
class(state) #데이터 형태 : data.frame

colMeans(state) #각 행의 평균
rowMeans(state) #각 열의 평균
mean(state$Income) #모든 주의 소득 평균
max(state$Income) #소득이 가장 높은 주의 소득(소득의 최대값)
min(state$Income)
str(state)
#HS.Grad에 따른 Income의 변화 확인
plot(state$HS.Grad, state$Income)
abline(state$HS.Grad, state$Income, col="red")

