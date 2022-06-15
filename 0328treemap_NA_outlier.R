install.packages("treemap")
library(treemap)
data(GNI2014)
View(GNI2014)
head(GNI2014)

treemap(GNI2014,
        index = c("continent", "iso3"),
        vSize = "population",
        vColor = "GNI",
        type = "value",
        bg.labels = "yellow")

state <- data.frame(state.x77)
state <- data.frame(state, Name = rownames(state))
state$Name <- rownames(state) #위와 동일
state

treemap(state,
        index = c("Name"),
        vSize = "Area",
        vColor = "Murder",
        type = "value",
        title = "the US murder and Area")

treemap(state,
        index = c("Name"),
        vSize = "Income",
        vColor = "Murder",
        type = "value",
        title = "the US murder and Income")

#NA결손값을 포함한 데이터 
y <- c(1,2,3,4, NA, 5, NA, 7)
y1 <- as.vector(na.omit(y)) 
#vector의 형태로 NA를 제거하고 새로 만들어줘

mean(y, na.rm = T)
var(y, na.rm = T)
sd(y, na.rm = T)
#NA없이 계산
y[is.na(y)] <- 3.6 #NA에 평균값을 넣어 바꾼다.
#is na : NA인덱스 반환
women
women[1,2] <- NA
women[10,1] <- NA
women[13,2] <- NA
women

colSums(is.na(women)) #각 열에 결측값 개수
rowSums(is.na(women)) #각 행에 결측값 개수

airquality
dim(airquality)
airq <- na.omit(airquality) #NA있는 행을 전부 삭제
dim(airq)
hist(airq$Ozone)

#이상치 : outlier의 값의 제거.
#혼자서 너무 튀는 값을 가지고 있는 값을 제거
iris
hist(iris$Sepal.Width)
mean(iris$Sepal.Width)
boxplot(iris$Sepal.Width)
#이상치를 확인할 수 있다
median(iris$Sepal.Width)
boxplot.stats(iris$Sepal.Width)
#boxplot의 stat들을 반환, 리스트로 반환한다
out.value <- boxplot.stats(iris$Sepal.Width)$out
#outlier값 저장
iris$Sepal.Width[iris$Sepal.width %in% out.value] <- NA
#outlier값을 NA로 변환
iris.new <- iris.new[complete.cases(iris.new), ]
#complete.cases() : NA가 아닌 녀석들만 반환

boxplot(iris.new$Sepal.Width)
hist(iris.new$Sepal.Width)

mtcars
boxplot(mtcars$wt)
boxplot.stats(mtcars$wt)
mtcars$wt <- ifelse(mtcars$wt > 5.25, NA, mtcars$wt)
mtcars$wt
boxplot(mtcars$wt)

a <- c(3, 1, 10, 8, 9)
order(a) #정렬된 인덱스 반환
order(a, decreasing = T) #정렬된 인덱스 반환
sort(a)
sort(a, decreasing = T)

View(state)
sort(state$Income)
order(state$Income)
which.max(state$Income)
which.min(state$Income)
rownames(state[2, ])
rownames(state[24,])


