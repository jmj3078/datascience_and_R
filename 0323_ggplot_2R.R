install.packages("ggplot2")
library("ggplot2")

economics

#시계열 그래프 : line graph주로 사용 
ggplot(economics, aes(date, pop))+
  geom_line(size = 2,
            lty = 1,
            color = "gold")+
  ggtitle("population by date")+
  ylab("population")+
  xlab("date")

#innate function 과 다리 선을 따로 따로 추가하는 구조가 아니다
ggplot(Orange, aes(age, circumference, color = Tree))+ 
  #color = Tree를 넣어서 Tree값에 따른 선들이 자동으로 추가되었다.
  geom_line(size = 2)+
  theme(panel.background = element_blank()) #배경 테마 추가

#연습- 그라데이션으로 표현됨
ggplot(economics, aes(date, pop, color = pce))+
  geom_line(size = 2)

#bar graph
ggplot(iris, aes(x= Species))+
  geom_bar(fill = "green")+
  ggtitle("species of iris") #기본값으로 count 수 들어감

mpg
table(mpg$manufacturer)
ggplot(mpg, aes(x = manufacturer))+
  geom_bar(fill = "salmon")+
  coord_flip() #가로방향으로 눞이기

class.type <- c(1,2,3,"crew")
passenger <- c(325,285, 706, 885)
total <- data.frame(class.type, passenger)
total
#ggplot 사용은 dataframe 형식에만 적용 가능

#r이 자동으로 개수를 새서 합산한 값을 bar graph로 만든 경우 :
#내가 넣은 숫자, 즉 y축 저옵를 가지고 반환할떄는 stat = "identity"추가해야됨
ggplot(total, aes(x=class.type, y=passenger))+
    geom_bar(stat = 'identity',
             fill = 'dark green')+
    coord_flip()

#PIE GRAPH
ggplot(total, aes(x = "class.type", y = passenger, fill = class.type))+
  #fill =  class.type을 넣지 않으면 색이 추가되지 않는다
  #x에 따옴표를 넣지 않으면 다른 형태로 출력됨(bar graph를 말 그대로 pie로 만든것ㄷ)
  geom_bar(width = 1,
           stat = "identity")+
  coord_polar("y")+ #pie 형태로 bar graph를 변환
  ggtitle("Passengers by Class")+
  geom_text(aes(label = paste0(round(passenger/22.01, 2), "%")), #%로 표현
            position = position_stack(vjust = 0.5)) #text숫자를 중앙에 넣기 위함

#죽은 사람들을 추가
class.type <- c(1,2,3,"crew", 1,2,3,"crew")
num <- c(122,167,528,673,203,118,178,212)
survived <- c("d","d","d","d","s","s","s","s")
survive.by.class <- data.frame(class.type, num, survived)
survive.by.class

#기본값 : 합쳐서 표현
ggplot(survive.by.class, aes(x = class.type, y = num, fill = survived))+
  geom_bar(stat = "identity")+
  ggtitle("Pessengers by Class")

#bar나눠서 표현
ggplot(survive.by.class, aes(x = class.type, y = num, fill = survived))+
  geom_bar(stat = "identity",
           position = position_dodge())+
  ggtitle("Pessengers by Class")

#기본 내장 그래프와의 비교
state <- data.frame(state.x77)
View(state)
barplot(state$Income)
barplot(state$Murder)
barplot(head(state$Income), col = "dark green")

rownames(state)

state$Name <- rownames(state) #이름 행 추가
View(state)

ggplot(state, 
       aes(x= Name, y= Income))+
  geom_bar(stat= "identity",
           fill= "darkgreen")+
  ggtitle("미국 주별 소득")+
  coord_flip() #너무 많으니까...

state5 <- state[c(2,4,6,8,10),c(2,9)] 

ggplot(state5,   # 데이터만 바꿔주기  
       aes(x= Name, y= Income))+
  geom_bar(stat= "identity",
           fill= "yellow")+
  geom_text(aes(label= Income))+   # 값을 막대에 표시해줘 
  ggtitle("미국 주별 소득")

#col 이름과 row 이름을 활용하여 데이터 추출해오기
big3 <- state[c("California","New York","Texas"), c("Income", "Name")]
big3

#ㅌaxis 함수와 names.arg의 비교
barplot(big3$Income, col = "brown")
axis(1, at=1:3, lab = c("Cal", "NY", "Tex")) 

barplot(big3$Income, col = "brown",
        names.arg = c("Cal", "NY", "Tex")) 

#ggplot에서 fill, color 의 차이
View(iris)
ggplot(iris, aes(x=Petal.Length, fill=Species))+
  geom_histogram(position="identity", #막대 중첩 - 히스토그램
                 binwidth = 0.3, #히스토그램 구간, 막대 넓이
                 alpha = 0.6) #막대그래프 투명도 조절

ggplot(iris, aes(x=Petal.Length, color=Species))+
  geom_histogram(position="identity",
                 binwidth = 0.3,
                 alpha = 0.6)

ggplot(Orange, aes(age, circumference))+
  geom_point(size =2)

ggplot(Orange, aes(age, circumference, color = Tree))+
  geom_point(size =2)

ggplot(Orange, aes(age, circumference))+
  geom_line(size = 2)

ggplot(Orange, aes(age, circumference, color = Tree))+
  geom_line(size = 2)

ggplot(Orangem aes())
