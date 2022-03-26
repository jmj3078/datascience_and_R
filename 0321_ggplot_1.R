install.packages("ggplot2")
library(ggplot2)

state <- data.frame(state.x77)
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
#고졸 비율이 높을 수록 평균 소득이 높아지는 경향이 보인다.

text(state$HS.Grad, state$Income,
     rownames(state),
     cex = 0.9,
     col = "blue",)
#행의 이름(rowname)을 그대로 이름으로 사용하면 된다.

#plot 화면 분할하기
plot(1:20)
plot(20:1)
par(mfrow=c(2,1)) #가로 2 세로 1의 그래프 프레임 생성
plot(1:20)
plot(20:1) #par 이후의 그래프는 이렇게 만들어짐
par(mfrow=c(1,3))
plot(1:20)
plot(20:1)
plot(5:1)

par(mfrow=c(2,2))

barplot(1:5, col = "blue")
barplot(1:5, col = "yellow")
barplot(1:5, col = "orange")
barplot(1:5, col = "red")

par(mfrow=c(1,1))

#ggplot2를 활용한 다양한 데이터 분석
#산점도 - ggplot의 기본 형태.
search()
Orange #Orange 데이터
ggplot(Orange, aes(age, circumference)) #x추그 y축은 그냥 dataframe의 이름만 넣으면 된다
+ geom_point(color = "red") #산점도 표시
#추세선 추가
ggplot(Orange,
       aes(age, circumference))+
  geom_point()+ #산점도
  stat_smooth(method = "lm") #추세선
#색 옵션
ggplot(Orange,
       aes(Tree, circumference, color = Tree))+ #여기에 color를 넣으면 나무에 따라 색 정해줌
  geom_point() 
#bar graph
ggplot(Orange,
       aes(Tree, circumference))+
  geom_bar(stat = 'identity',
           fill = 'orange',
           color = 'black') #color 는 bar태두리에 들어가게 된다

cars
ggplot(cars, aes(speed, dist))+
  geom_point()+
  stat_smooth(method = "lm") #추세선

ggplot(cars, aes(x = dist)) + 
  geom_histogram(fill = "skyblue") #기본함수 히스토그램보다 더 잘 나옴

#ggplot에서만 구현 가능한 그래프 : 
#species에 따라 색을 구별하여 분포를 나타내는것
ggplot(iris, aes(x = Petal.Length, fill = Species))+
  geom_histogram(position = 'identity',
                 binwidth = 0.6,
                 alpha = 0.5)

#원그래프(pie chart)

election <- c("윤석열", "이재명", "심상정")
freq <- c(48.56, 47.83, 2.5)
election_20th <- data.frame(election, freq)
election_20th
ggplot(election_20th, aes(x = "election", y = "freq", fill = election))+
  geom_bar(stat = "identity")+
  coord_polar("y")+
  geom_text(aes(label = paste(freq, "%")), #paste0과 paste 차이 : 공백 차이
            position = position_stack(vjust=0.5)) #text위치 : 부채꼴 중간

palette1 <-c("윤석열" = "red",
             "이재명" = "blue",
             "심상정" = "yellow")

ggplot(election_20th, aes(x = "election", y = "freq", fill = election))+
  geom_bar(stat = "identity")+
  coord_polar("y")+
  scale_fill_manual(values = palatte1)+
  geom_text(aes(label = paste(freq, "%")), #paste0과 paste 차이 : 공백 차이
            position = position_stack(vjust=0.5)) #text위치 : 부채꼴 중간


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

#linear graph
View(economics) #ggplot2 내장 데이터

ggplot(economics, aes(x= date, y=unemploy))+
  geom_line() #시계열 실업율 그래프

ggplot(economics, aes(x= date, y=unemploy))+
  geom_line(size = 1,
            lty = 1,
            color = "red")+
  ggtitle("unemplyment population")+
  geom_hline(yintercept = mean(economics$unemploy),
             lty =3) 
#y절편값이 unemploy의 평균값으로 highline으로 삽입, linetype : 점선

  