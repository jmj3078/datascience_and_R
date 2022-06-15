#vector
a <- c(1, 2, 3)
b <- c(2, 3, 4)
a*b
a-b
a+b
a/b
a%%b

rm(a) #변수 삭제

a = 1:10
a = 1:13
rep(1:10,3)
seq(1,10,3)
seq(1,-10,-1)
rm(list = ls())

median(a)
var(a)
sd(a)

str(a)
str("jake")

c = paste(a,b)
str(c) #chr자료형으로 저장
c = c(a,b)
c #vector 이어붙이기
length(c)
c[1]
c[2]
c[1:2] #index는 1부터 시작
c[-2] #2번쨰 뺴고 출력
c[c(1,3)]

quantile(c) #각 1/4 2/4 3/4 4/4 
IQR(c) #Inter Quatile Range
diff(range(c)) #최대 최소 차이
range(c) #최소 최대 값

#list : dictionary
la <- list(name = "jake", age = 12, score =c(1,2,3))
la
la$name #key값 접근 : $활용, dataframe처럼 쓰면됨
la$age
la$score

#matrix
x1 <- matrix(1:20, nrow = 4, ncol = 5)
y1 <- matrix(21:40, nrow = 4, ncol = 5)

x1
y1


#행 방향으로 원소 채워넣기
y1 <- matrix(21:40, nrow = 4, ncol = 5, byrow = T)
y1

cbind(x1, y1) #열방향으로 이어붙이기
rbind(x1, y1) #혈방향으로 이어붙이기 
#간단하게 행이나 열을 추가할 수 있음
y1[,5] <- c("a","b","c","d") #값 대치
y1
str(y1) 
dim(y1) #matlab의 size와 똑같은 함수
dim(y1)[1] #이런식으로 접근 가능
#matrix는 한가지 자료형 밖에 담지 못하기 때문에, str가 섞이면 모두 str가 된다

x1[,2:4] #approaching
x1[4,]

score <- c(10, 20, 30, 40, 50)
name <- c("a","b","c","d","e")
cbind(score, name) #matrix형성

sum(x1) #전부 합한값
apply(x1, 1, sum) #각 행마다 함수 적용하기 : apply 함수
str(x1) #구조, 자료형
colMeans(x1) #행마다 평균
rowMeans(x1) #열마다 평균, 자료형은 vector > dataframe에서도 사용가능
#dataframe은 matrix의 상위호환같은 느낌이다

#dataframe
state.x77
str(state.x77)
state <- data.frame(state.x77)
str(state) #dataframe에는 다양한 자료형을 넣을 수 있고 각 행 열 이름, 열마다 이름도 넣을 수 있음

#dataframe생성
x1 <- c(1,2,3,4)
x2 <- c(90,80,70,60)
a <- data.frame(x1,x2) #x1, x2로 이뤄진 데이터프레임, x1과 x2가 열이 된다

#dataframe편집

btsname <-c("RM", "Jin", "Suga", "jhope", "jimin", "V", "JK")
btsyear <-c(1994,1992,1993,1994,1995,1995,1997)
btsposition <-c("rap", "vocal", "rap", "rap", "vocal", "vocal", "vocal")
bts <-data.frame(btsname, btsyear, btsposition)
bts

str(bts)
dim(bts)
age <- rep(2022, 7) - btsyear
bts$age <- age #요소추가, 행 추가
names(bts) #행 요소 이름
head(bts) #6행까지 출력

iris
View(iris)
names(iris)
dim(iris)

##############################################################################

#library dplyr 활용, subset 제작과 기본함수 작성
library(dplyr)
#가장 특징적 기능 : >%> 의 활용
x <- c(5,7,9,11,13,15,55)
mean(x)
sqrt(mean(x))
round(sqrt(mean(x)), 2)     

x %>% mean %>% sqrt %>% round(2)

#subset, filter를 활용한 데이터 그룹화
View(mtcars)
mtcars$cyl == 6 #이러면 True False 벡터가 출력된다

mtcars[mtcars$cyl == 6, ] #조건을 만족하는 모든 행 출력
mtcars[mtcars$cyl ==6 & mtcars$am == 1, ]
#subset(dataframe, bool)
subset(mtcars, cyl == 6 )
subset(mtcars, cyl == 6 & am == 1) #조건 2개

#filter L dplyr package에 있는 subset함수, %>% 을 지원한다
filter(mtcars, cyl == 6) #  조건에 따른 정렬
mtcars%>%filter(cyl%in%c(4,6)) #vector안에 있는 값들 중 같은게 있는 행 추출
mtcars%>%filter(cyl == 6 | am == 1) #subset과 사용법은 똑같다. in빼고
mtcars%>%filter(cyl ==6 | am == 1)

#select: 행 추출
mtcars%>%select(cyl, am)
mtcars[c("cyl","am")] #이와 동일

#arrange: 오름차순으로 조건별로 정렬
arrange(mtcars, cyl, mpg) #오름차순으로 주어진 순으로 정렬
mtcars%>%arrange(cyl, mpg)

women
#mutate : 행 추가 
mutate(women, h.cm = height*2.54, w.kg= weight*0.45) 

a <- mtcars %>%
  group_by(cyl) %>% #cyl에 따라 그룹 나누기
  summarize(mpg평균 = mean(mpg)) #cyl 그룹 나누고 mpg평균값 구하기

b <- mtcars %>%
  group_by(cyl) %>% 
  summarize(hp평균 = mean(hp))
a
b

#group_by 와 summarize의 동시사용
Oran.mean1 <- Orange %>%
  group_by(Tree) %>% #Tree로 그룹화
  summarize(age평균 = mean(circumference)) #group화된 Tree를 age평균으로 요약
Oran.mean2 <- summarize(group_by(Orange, Tree),age평균 = mean(circumference))

Oran.mean1
Oran.mean2

#table : 빈도수 정리
titanic <- data.frame(Titanic)
table(titanic$Class) #Class별 빈도수

a <- data.frame(id=c(1,2,3), math1=c(80,70,95))
b <- data.frame(id=c(1,2,3), math2=c(80,70,95))

#두 벡터의 병합, 이어붙이기가 아닌 병합
merge(a,b, by = "id") #둘 다 id 라는 열 이름을 가지므로, 이렇게 적용
merge(a,b, by = "math1") #둘다 공통적으로 가진 열 이름을 설정해야 적용된다 

cbind(a,b) #열 추가, 열방향 결합
rbind(a,b) #에러, math1과 math2가 다르기때문에 합쳐지지 않는다.

split(iris, iris$Species) 
#Speciesr 값의 종류에 따른 데이터 분리!!
split(Orange, Orange$Tree) 
#TREE 값의 종류에 따라서 데이터들을 다 분리해준다
margin.table(Titanic, margin = 1)
margin.table(Titanic, margin = 2)
margin.table(Titanic, margin = "Class") 
#각 행의 유형별 합을 보여주는 margin.table, 열, 전체에도 사용 가능하다
#위처럼 데이터 값이 빈도 그 자체인 경우에 사용하면 전체 합을 구할 수 있다!!!(중요)
prop.table(Titanic, margin = 1) 
prop.table(Titanic, margin = 2)

##############################################################################

#plots - 기본함수들 활용

head.state = head(state)
sample.state = sample(state, 10)
#plot 이 붙은 함수 : 새로운 plot 작성
#다른 함수 : 기존 plot 에 하나씩 더해주는 역할
plot(state$Income, state$Murder)
abline(state$Income, state$Murder) #추세선 추가
barplot(state$Income, state$Murder)
barplot(head.state$Income, head.state$Murder)
hist(head.state$Income) #히스토그램
boxplot(state$Income, state$Murder)

##############################################################################
#plot
#generic 함수, 데이터 형태에 따라 다양한 형태의 그래프 출력
#다양한 옵션 존재, 점 종류, 색, 선 종류, 색, 테두리 종류 등등등...

titanic <- data.frame(Titanic)
plot(titanic$Class)
plot(titanic$Sex)
plot(titanic$Class, titanic$Sex) #bar graph 출력

View(state) #Frequency가 데이터가 아니라면 이런 식으로 점 그래프가 나온다
plot(state$Income, state$Life.Exp) #점 그래프 출력
plot(iris$Species, iris$Sepal.Length) #boxplot 출력
install.packages("data.tree")
install.pakcages("DiagrammeR")
library(data.tree)
data(acme, package = "data.tree")
acme
plot(acme) #다이어그램 마인드맵 출력

# * type
# type="p" : 점 모양 그래프(기본값)
# type="l" : 선 모양 그래프, 꺽은선 그래프
# type="b" : 점과 선 모양 그래프
# type="c" : "b"에서 점을 생략한 모양
# type="o" : 점과 선을 중첩해서 그린 그래프
# type="h" : 각 점에서 x축 까지의 수직선 그래프
# type="s" : 왼쪽값을 기초로 계단모양으로 연결한 그래프
# type="S" : 오른쪽 값을 기초로 계단모양으로 연결한 그래프
# type="n" : 축 만 그리고 그래프는 그리지 않는다.
# 
# * lty
# lty=0 or lty="blank" : 투명선
# lty=1 or lty="solid" : 실선
# lty=2 or lty="dashed" : 대쉬선
# lty=3 or lty="dotted" : 점선
# lty=4 or lty="dotdash" : 점선과 대쉬선
# lty=5 or lty="longdash" : 긴 대쉬선
# lty=6 or lty="twodash" : 2개의 대쉬선

##############################################################################
#bar plot
barplot(state$Population, col= "red")la
barplot(state$Population, col= "red", horiz = T)
barplot(state$Population, 
        name = "population by State", #제목
        sub = "by JMJ", #부제
        xlab = "state", #x lable
        ylab = "population", #y lable
        col = c("gold","blue","purple"), #이런식으로 
        border = "blue", #테두리 색
        ) #위 처럼 옵션을 넣어줄 수 있다
rownames(state)
#axis, line, text, abline 등은 모두 추가로 현재 작업중인 plot에 들어가는 녀석들
#axis에 이름을 배당하는 것 보다는 names.arg가 훨씬 보기 좋게 넣어준다

axis(1, at = 1:50, lab = rownames(state)) 
axis(2, ylim = 1:20000) #다양한 옵션이 있으니 도음말을 보고 적절히 활용하자

survive_by_class <- margin.table(Titanic, margin = c(4,1))
barplot(survive_by_class, 
        col = c("gold", "blue"), 
        legend.text = T, #주석
        names.arg = c("1st","2nd","3rd","crew")) #argument당 이름 배당

##############################################################################

#histogram, pie chart : 자동으로 빈도를 측정하여 계산한다
#도수 분포표의 경우 table 또는 margin table 을 통해 빈도를 계산한 도수분포표를 만들어줘야한다

hist(cars$dist) #자동으로 빈도분석
View(titanic) #frequency가 따로 요소로 저장되어있는 형태, 자동 분석 X
hist(titanic$Class) #에러 발생 - table margin table로 분포표 생성
hist(margin.table(Titanic, margin = 1)) #이런식으로 해도 된다
hist(state$Income)

table(iris$Species) #각 변수당 개수
table_Species<- table(iris$Species)
pie(table_Species) #알아서 열 정보당 행 값을 계산하여 넣어줌
pie(table_Species,
    main = "species of iris") 

pie(margin.table(Titanic, margin = 1)) #numeric이 아닌 녀석들은 이렇게!!
pie(table(titanic$Class)) #에러는 나오지 않지만 원하던 결과가 아니다.

class  <- margin.table(Titanic, margin = 1)
class

age <- margin.table(Titanic, margin = 3)
age

sex <- margin.table(Titanic, margin = 2)
sex

survived <- margin.table(Titanic, margin = 4)
survived

pie(class)
pie(class, 
    labels = c(325, 285, 706, 885), #labeling
    main = "Titanic Pessengers") #main title

text(0.5, 0.2, "1st")
text(0.2, 0.6, "2nd")
text(-0.5, 0.1, "3rd")
text(0.1, -0.3, "crew") #text추가 

#boxplot : 도수분포가 아닌 때 사용
#중압값을 기준으로 다른 값들이 얼마나 멀리 떨어져있는지 보여준다
#numeric 값에만 사용할 수 있다
boxplot(iris$Sepal.Length,
        iris$Sepal.Width,
        col = "yellow",
        names = c("Sepal Length", "Sepal Width"))

boxplot(state$Population, state$Income, state$Murder,
        col = c("yellow", "red", "blue"),
        names = c("population", "income", "murder"))

boxplot(Income ~Murder, #x에 따른 y의 값을 보여달라
        data = state)

boxplot(Sepal.Length ~Species,
        data = iris,
        col = "yellow",
        main = "Length by Species")

colors() #그래프에 넣을 수 있는 색 리스트

##############################################################################

#bubble chart
symbols(state$HS.Grad, state$Income, #x축 : 고졸비율  #y축 : 소득
        circles = state$Population, #원의 크기 : 인구
        inches = 0.7, #표준 원의 크기
        fg = "black", #원 테두리 색
        bg = "gold", #원 채우는 색
        lwd = 1, #테두리 두께
        xlab = "고졸 비율", #x label
        ylab = "1인당 소득", # y label
        main = "고졸 비율과 소득") #main label

text(state$HS.Grad, state$Income,
     rownames(state),
     cex = 0.9,
     col = "blue",)
#행의 이름(rowname)을 그대로 이름으로 사용하면 된다.

#plot 화면 분할하기
plot(1:20)
plot(20:1)g
par(mfrow=c(2,1)) #가로 2 세로 1의 그래프 프레임 생성
plot(1:20)
plot(20:1) #par 이후의 그래프는 이렇게 만들어짐
par(mfrow=c(1,3))
plot(1:20)
plot(20:1)
plot(5:1)
par(mfrow=c(1,1)) #원래대로 

##############################################################################
#ggplot을 활용한 데이터시각화
ggplot(data= iris, aes(x축 = , y축= )) + geom_something( )
#  geom_bar( )막대 그래프 - color, fill, alpha, width(막대너비)
#  geom_point( ) 점그래프 - color, alpha, pch(shape), size
#  geom_histpgram( ) 히스토그램 - color, fill, alpha, binwidth(데이터 구간과 막대너비)
#  geom_bar, coord_polar( )  파이 그래프 
#  geom_boxplot( ) 박스 플랏 - color, fill, alpha, width(막대너비)
#  geom_line( )선 그래프 - color, alpha, linetype(lty), size(굵기)
#  geom_text( )텍스트 삽입 - aes(label= )
#  geom_smooth() 또는 stat_smooth, lm (선형 회귀선), se=F
#  geom_hline() 수평라인 #xintercept = x절편값
#  geom_vline() 수직라인 #yintercept = y절편값

#  group= : 그룹핑할 변수
#  fill= : (막대, 박스플랏 등) 색을 칠해라
#  alpha(“red”, 0.5) : 그래프의 투명도
#  color= : (막대, 원) 테두리에 색을 넣어라
#  binwidth= : 막대의 넓이 지정
#  coord_flip : 수평방향 그래프를 만들어라
#  position_dodge : 막대의 위치를 개별적으로 나타내라
#  position_fill : x축 해당 데이터의 상대적인 비율을 나타내라 
#  stat_identity : y축의 빈도를 막대그래프로 나타내라

install.packages("ggplot2")
library("ggplot2")
Orange
colnames(Orange)
ggplot(Orange, aes(age, circumference))+
  geom_point(color = "red")+ #산점도, 색 붉은색
  stat_smooth(method = "lm", color = "gold", se = F)+
  geom_smooth(color = "red", se= F) #se = F : 범위 제거
#stat smooth와 geom smooth는 두랃 추세전이지만 다른 함수다

ggplot(Orange,
       aes(Tree, circumference, color = Tree))+ 
  #여기에 color를 넣으면 나무에 따라 색 정해줌
  geom_point() 

ggplot(data=mtcars, mapping = aes(x=hp, y=mpg, color=as.factor(cyl))) + 
  geom_point() +
  geom_smooth()
# data = mapping = x= y= a
# 숫자형 자료인 cyl 을 as.factor로 factor 변환시킴

# geom_bar와 stat 옵션
# geom_bar 함수에는 stat = "identity" 별도 표기하는 이유
# ggplot은 stat 알고리즘으로 데이터를 분석하여 그래프로 나타낸다.
# args()를 사용하여 기본값으로 지정된 stat이 뭔지 알 수 있다
# 때에 따라 stat = "identity"등을 통해 stat을 지정해야 우리가 원하는 그래프를 그릴 수 있다
args(geom_histogram) 

# 실행결과에서 stat = "bin"을 확인 가능
# function (mapping = NULL, data = NULL, stat = "bin", position = "stack", 
#           ..., binwidth = NULL, bins = NULL, na.rm = FALSE, show.legend = NA, 
#           inherit.aes = TRUE) 

args(geom_bar) #stat = "count"로 표현됨
# geom_bar() 함수는 x변수에 해당하는 값을 기준으로 빈도수를 카운트하여 
# count 변수를 만들어내고, 이를 y축으로 하여 그래프를 그리기 때문이다.
# 우리가 원하는 값을 y축 값으로 하여 그래프를 그리기 위해서는
# 아래와 같이 AES 매핑에 x변수와 y변수를 각각 name과 value로 표시하고,
# geom_bar()에 stat="identity"라고 STAT을 별도로 명기하면 된다.

ggplot(Orange, aes(Tree, circumference))+
  geom_bar(stat = 'identity', fill = 3)#color 는 bar태두리에 들어가게 된다

#histogram과 position 옵션 :
#POSITION에는 dodge, fill, identity, jitter, stack이 있고
#bar graph와 histogram의 기본 형은 stack이다

ggplot(cars, aes(dist)) + #histogram : 오직 하나의 x값 또는 y값만 가질 수 있음
  geom_histogram(fill = "skyblue") #기본함수 히스토그램보다 더 잘 나옴

ggplot(iris, aes(Petal.Length, fill = Species))+
  geom_histogram(binwidth = 0.6,
                 alpha = 0.5) #position 없음 : 기본 stack이 되어서 나온다

ggplot(iris, aes(Petal.Length, fill = Species))+
  geom_histogram(position = 'identity',
                 binwidth = 0.6,
                 alpha = 0.5) #position : identity : 겹쳐서 표현된다

ggplot(iris, aes(Petal.Length, fill = Species))+
  geom_histogram(position = 'dodge', 
                 binwidth = 0.6,
                 alpha = 0.5) #position : dodge - 겹치지 않게 표현된다

ggplot(iris, aes(Petal.Length, fill = Species))+
  geom_histogram(position = 'jitter',
                 binwidth = 0.6,
                 alpha = 0.5) #position : jitter : 입체감

ggplot(iris, aes(Petal.Length, fill = Species))+
  geom_histogram(position = 'identity',
                 binwidth = 0.6,
                 alpha = 0.5) #position : identity : 겹쳐서 표현된다

ggplot(data=mtcars, aes(x=cyl, fill=as.factor(am))) +
  geom_bar()

ggplot(data=mtcars, aes(x=cyl, fill=as.factor(am))) +
  geom_bar(position = "dodge")
#이런 식으로 활용하면 된다
#
#coordination = 그래프의 축 형태 변경
#coordinate : 축의 형태 변경
#coord_flip : x y 축 변경
#coord_polar : 극좌표계 사용
#coord_trans : 변수 변환 (log 등등)

#coord_polar을 활용한 pie plot 만들기
election <- c("윤석열", "이재명", "심상정")
freq <- c(48.56, 47.83, 2.5)
election_20th <- data.frame(election, freq)
election_20th
ggplot(election_20th, aes(x = "election", y = "freq", fill = election))+
  geom_bar(stat = "identity")+ #stat = identity가 필요한 이유 꼭 기억!
  coord_polar("y")+ #coord_polar : 극 좌표계 사용
  geom_text(aes(label = paste0(freq, "%")), #paste0과 paste 차이 : 공백 차이
            position = position_stack(vjust=0.5)) #text위치 : 부채꼴 중간

palette1 <-c("윤석열" = "red",
             "이재명" = "blue",
             "심상정" = "yellow")

ggplot(election_20th, aes(x = "election", y = "freq", fill = election))+
  #" "를 씌우면 numeric 자료형이 문자열로 바뀌며 stat 함수의 사용에 변화가 생긴다
  geom_bar(stat = "identity")+ #position을 사용하여 다양한 표현 가능
  coord_polar("y")+ 
  scale_fill_manual(values = palette1)+ #자동으로 체워주는 fill 에, 수동 색 지정
  geom_text(aes(label = paste0(freq, "%")), #paste0과 paste 차이 : 공백 차이
            position = position_stack(vjust=0.5)) #text위치 : 부채꼴 중간

#coord_flip활용
ggplot(state, aes(x = state.name, y = Income))+
  geom_bar(stat = "identity",
           width = 0.5,
           fill = "red")+
  coord_flip()

#boxplot
ggplot(iris, aes(x= Species, y= Sepal.Length))+
  geom_boxplot(fill="mintcream")+
  ggtitle("Sepal length by Species")

View(mpg)
ggplot(mpg, aes(x= drv, y= hwy))+
  geom_boxplot(fill = "linen")+
  ggtitle("고속도로 연비 by drv")

ggplot(mpg, aes(x= trans, y = hwy))+
  geom_boxplot(fill = "orange")+
  ggtitle("Hwy by Trans")

# 축 눈금 변경 : scale_x_continuous() 함수의 breaks 및 labels 옵션
# breaks 옵션은 축 눈금의 위치와 값을 조정하고, 
# labels 옵션은 각각의 눈금에 해당하는 문자명을 조정한다.

# 데이터 변환 : scale_y_sqrt() 함수 등
# log10, reverse, sqrt 등의 scale함수로 데이터를 변환하여 그래프를 그릴수 있다.

# 범례별 색 수동 지정, 이름, 크기, 모양 등 설정
# RColorBrewer::display.brewer.all() - 지원하는 색상 조합 제공
# sclae_color_brewer(palette = "")이런식으로 활용해 제공하는 색 조합을 골라 사용 가능

# scale_color_manual() 함수, 그리고 막대 그래프에는 scale_fill_manual() - 
# 자동으로 설정되는 그래프의 색을 수동으로 설정해준다, 위에서 한번 씀
# scale_color_manual(values = c("Green","Red"), 
#  name = "Transmission",
#  labels = c("Auto","Manual")) ##범례 변경, 범례 색 설정과 함꼐 할 수 있다
# scale_shape_manual(values=c(15, 17)) #범례의 형태 변경(점)
# scale_size_manual(values=c(15, 17)) #범례의 크기 변경(점, 선)

#theme : 8개의 테마 존재
theme_bw()
theme_classic()
theme_dark()
theme_gray()
theme_light()
theme_linedraw()
theme_void()
#일괄적용 : theme_set(theme_classic()) 이런식으로 설정. 기본값으로 설정된다
#수동적용 : 
# theme()에 일일이 적어주기
# 1) element_text() : 텍스트 설정(범례, 축, 제목 등)
# 2) element_line() : 라인 설정(color(색상), size(크기), linetype(종류), lineend(끝모양) 등)
# 3) element_rect : 테두리와 배경(fill(배경색상), color(테두리색상), 두께(size), 종류(linetype) 등)
# 4) element_blank() : 어떤 테마 요소에 아무것도 설정하지 않음

#labeling: 측 및 그래프 이름 설정
ggtitle()
xlab()
ylab()

#축, 그래프, 제목의 수동설정
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point(color = "red",
             size = 2,
             shape = 2) + 
  ggtitle("HP과 MPG의 관계3") + 
  xlab("HP(마력)") + 
  ylab("MPG(연비)") + 
  theme(plot.title = element_text(size=20, 
                                  color="red", 
                                  hjust=0.5), 
        axis.title.x = element_text(size=25, 
                                    color="blue", 
                                    hjust=1), 
        axis.title.y = element_text(size=15,
                                    color="green",
                                    hjust=0))

#이런식으로 설정 가능하다
#linear graph

View(economics) #ggplot2 내장 데이터

ggplot(economics, aes(x= date, y=unemploy))+
  geom_line() #시계열 실업율 그래프

ggplot(economics, aes(x= date, y=unemploy))+
  geom_line(size = 0.5)+
  ggtitle("unemplyment population")+
  geom_hline(yintercept = mean(economics$unemploy),
             lty = 2)

#y절편값이 unemploy의 평균값으로 highline으로 삽입, linetype : 점선

ggplot(economics, aes(x=date, y=pop))+
  geom_line(size = 2,
            lty = 1,
            color = "gold")+
  ggtitle("population by date")+
  ylab("population")+
  xlab("date")

ggplot(Orange, aes(age, circumference, color = Tree))+ 
  #color = Tree를 넣어서 범례를 지정해줬다.
  geom_line(size = 2,
            show.legend = T)+
  scale_color_manual(values = c("red", "blue", "yellow", "green", "pink"),
                     name = "Tree subject",
                     labels = c("a","b","c","d","e"))+
  scale_shape_manual(values = c(1,2,3,4,5))+
  theme_minimal()

#이런식으로 범례를 활용할 수 도 있다
ggplot(Orange, aes(age, circumference, color = Tree)) + 
  geom_line(aes(lty=Tree, color=Tree)) 

ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point(aes(shape=as.factor(am), size=as.factor(am), color=as.factor(am))) + 
  scale_shape_manual(values = c(15, 17)) + 
  scale_size_manual(values = c(4,5))

#colorbrewer의 활용,
RColorBrewer::display.brewer.all()

ggplot(Orange, aes(age, circumference, color = Tree)) + 
  geom_line(size =2,
            show.legend = T)+
  scale_color_brewer(palette("Accent"))

#############################################################################3
#Treemap
install.packages("treemap")
library(treemap)
data(GNI2014)
View(GNI2014)
treemap(GNI2014,
        index = c("continent", "iso3"), #continent, iso를 index로
        vSize = "population", #크기 결정 : 인구수
        vColor = "GNI", #색의 진하기 : GNI로 결정
        type = "value",
        bg.labels = "yellow") #두번쨰 index 뒤에 노란색 배경 추가*가시성

state <- data.frame(state.x77)
state <- data.frame(state, Name = rownames(state))  
#이름 열 추가
state$Name <- rownames(state)
state

treemap(state,
        index = c("Name"),
        vSize = "Area",
        vColor = "Murder",
        type = "value",
        title = "the US murder and Area")

#결손값, NA 제거 및 다루기
y <- c(1,2,3,4,NA,5,NA,7)

na.omit(y)
y1 <- as.vector(na.omit(y))
y1

mean(y, na.rm = T)
var(y, na.rm = T)
sd(y, na.rm = T)

women
women1 <- women
women1[c(1,10,13),1] <- NA
women1 

is.na(women1) #is.na >주어진 데이터의 NA 있는곳에 T 반환
women1[is.na(women1)] #접근가능

colSums(is.na(women1)) #각 열에 있는 총 NA수
rowSums(is.na(women1)) #각 행에 있는 총 NA수

airquality
dim(airquality)
airq <- na.omit(airquality) #NA 값 가지고 있는 행 모두 삭제
#NA를 중간값으로 대체하는 방법도 있다! 
#통계에서 잘 사용하는 방법이다. 기억해두자
View(airq)

dim(airq)
hist(airq$Ozone, col = "blue", 
     xlab = "Ozone", 
     main = "Ozone of each state")

#Outlier값 제거. 이상치 제거

iris
hist(iris$Sepal.Width)
boxplot(iris$Sepal.Width)

median(iris$Sepal.Width)
boxplot.stats(iris$Sepal.Width)
#boxplot의 stat반환

out.value <- boxplot.stats(iris$Sepal.Width)$out
#%in% 연산자 : 
k = 3
a = c(1,2,3,4,5)
a%in%k 
a == k
#하나만 비교할땐 둘다 같은걸 반환하지만
iris$Sepal.Width == out.value
#벡터값을 비교하면 오류가 나므로 %in%을 사용한다

iris.new <- iris 
iris.new$Sepal.Width[iris$Sepal.Width %in% out.value] <- NA
#이상치 값을 NA로 치환
dim(iris.new)
complete.cases(iris.new)
#NA가 아닌 행만 bool형태로 반환
iris.new <- iris.new[complete.cases(iris.new), ]
dim(iris.new) #개의 행 제거

boxplot(iris.new$Sepal.Width) #이상치 제거
hist(iris.new$Sepal.Width)

mtcars
boxplot(mtcars$wt)
boxplot.stats(mtcars$wt)
out.mtcars <- boxplot.stats(mtcars$wt)$out
out.mtcars
mtcars1 <- mtcars
mtcars1$wt <- ifelse(mtcars1$wt >= 5.25, NA, mtcars1$wt) 
#직접 법위 설정하여 제거
dim(mtcars1)
dim(mtcars)

boxplot(mtcars1$wt)
boxplot.stats(mtcars1$wt)
