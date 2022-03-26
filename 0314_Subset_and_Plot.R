library(dplyr)

x <- c(5,7,9,11,12,55)
mean(x)
sqrt(mean(x))
round(sqrt(mean(x)),2)
x %>%
  mean %>%
  sqrt %>%
  round(2) 

View(Orange)
table(Orange$Tree)
Oran.mean1 <- Orange %>%
  group_by(Tree) %>%
  summarize(age평균 = mean(circumference))
Oran.mean2 <- summarize(group_by(Orange, Tree),age평균 = mean(circumference))

Oran.mean2
Oran.mean1

#원하는 데이터 추출
subset(iris, select = c(Sepal.Length, Sepal.Width))
subset(iris, Species == "versicolor")
subset(iris, Petal.Width > 2.0)
subset(iris, Petal.Width > 2.0 & Petal.Length >6)
subset(iris, Petal.Width > 2.0 | Petal.Length >6)
subset(iris, Petal.Width > 2.0 | Petal.Length >6, 
       select = c(Sepal.Length, Sepal.Width))
#subset(조건,조건,조건,select변수(벡터형태))

a <- data.frame(id=c(1,2,3), math1=c(80,70,95))
b <- data.frame(id=c(1,2,3), math2=c(80,70,95))
a
b
merge(a,b, by = "id") #둘 다 id 라는 열 이름을 가지므로, 이렇게 적용
merge(a,b, by = "math1") #둘다 공통적으로 가진 열 이름을 설정해야 적용된다 

cbind(a,b) #열 추가, 열방향 결합
rbind(a,b) #에러, math1과 math2가 다르기때문에 합쳐지지 않는다.

split(iris, iris$Species) #Speciesr 값의 종류에 따른 데이터 분리
#$versicolor, $virginica로 구별
split(Orange, Orange$Tree) #TREE 값의 종류에 따라서 데이터들을 다 분리해준다

#내장데이터로 기본 그림 그리기, 그래프-hist, barplot, pie, boxplot, bubble
colors() #색 리스트
Orange
mean(Orange$age)
mean(Orange$circumference)
hist(Orange$age, col = "turquiose")
plot(Orange$age, Orange$circumference)
plot(Orange) #모든 변수들 끼리의 산점도

cars
plot(cars$speed, cars$dist)
plot(cars)

hist(cars$dist)
hist(cars$dist,
     main = "dist and frequency", #그래프 이름
     xlab = "dist", ylab = "frequency", #x, y축 이름 설정
     border = "blue", #테두리 색
     col = "gold", #막대기 색
     breaks = 20)

iris
table(iris$Species) #각 변수당 개수
table_Species<- table(iris$Species)
pie(table_Species) #알아서 열 정보당 행 값을 계산하여 넣어줌
pie(table_Species,
    main = "species of iris")

barplot(table_Species)
barplot(table_Species,
        main = "species of iris",
        xlab = "species",
        ylab = "number",
        col = c("red","blue","purple"))

iris1 <- iris[, c(1:4)]
boxplot(iris1)
boxplot(iris$Sepal.Length,
        iris$Sepal.Width,
        col = "yellow",
        names = c("Sepal Length", "Sepal Width"))
boxplot(Sepal.Length~ Species, #Sepal length 에 따른 ~ Species, 자동으로 xy이름도 정해준다
        data = iris,
        main = "length result",
        col = c("red","green","gold"))

x <- c(1:10)
y <- c(5:15)
median(x)
median(y)
boxplot(x,y) #median값을 중심으로 두고 얼마나 퍼져있는가 보여준다.

boxplot(circumference~ Tree, #나무 종류에 따른 둘레: ~으로 표시, 자동으로 해준다
        data = Orange,
        main = "circumference of Tree",
        col = "cyan")

x <- 1:10
y1 <- log(x)
y2 <- sqrt(x)

plot(x, y1,
     type = "l", col = "blue") # type 에 l을 넣으면 직선 그래프 만들엊미

plot(x, y2, col = "red") #기본값 : 산포도

lines(x, y2, lty = 5, col = "red") #선 그래프를 그리고, 넣는다(추가하는 느낌)

range(y1) #범위
range(y2) 

plot(x, y1, ylim = c(0,4),
     type = "l", 
     col = "green")

lines(x, y2, lty = 5, col = "blue") #선 추가

x = c(100, 200, 180, 150, 160)
y = c(220, 300, 280, 190, 240)
z = c(310, 330, 320, 290, 220)

plot(x, type = "o", col = "gold",
     ylim = c(0,400),
     axes = F, ann = F)

axis(1, at = 1:5, lab = c("A","B","C","D","E")) #축 설정
axis(2, ylim = c(0,400)) #축 설정
lines(y, type = "b", pch = 17, col = "red", lty = 5) #선 추가
lines(z, type = "b", pch = 11, col = "blue", lty = 5) #선 추가
title(main = "book page", col.main = "purple") #메인 타이틀 추가 
title(xlab= "book", ylab = "page", col.lab = "grey") #xy축 타이틀 추가
legend(3.5, 400, 
       c("Science", "English", "Math"),
       cex = 1.0, #주석 내 폰트 크기
       col = c("gold", "red", "blue"), #x, y, z 순서대로 ㅂ
       pch = c(21, 17, 5), #주석 내 점 모양
       lty = 1) #주석 내 선 모양
