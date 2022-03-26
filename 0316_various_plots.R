library(dplyr)

#n열을 중심으로 누적테이블을 만들어라!! - frequency를 축적
#더 복습해서 알아두자
View(Titanic) 
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
    labels = c(325, 285, 706, 885),
    main = "Titanic Pessengers")

text(0.5, 0.2, "1st")
text(0.2, 0.6, "2nd")
text(-0.5, 0.1, "3rd")
text(0.1, -0.3, "crew")

barplot(class)
barplot(sex)
barplot(age)
barplot(survived)
barplot(class, xlab= "Ferry class", 
        ylab = "Frequency",
        main = "Pessengers by class") #새로 막대 그래프

barplot(class, horiz = T,
        xlab = "frequency",
        ylab = "Ferry class",
        main = "pessengers by class") # 가로 막대 그래프

survive_by_class <- margin.table(Titanic, margin = c(4,1))
survive_by_class #2차원 테이블 형성 / class에 따른 생존자 누적

barplot(survive_by_class) #no 가 막대 하부, yes 가 막대 상부
                         #이건 내장속성.
barplot(survive_by_class,
        col = c("black","green"),
        legend.text = T,
        names.arg = c("1st","2nd","3rd","crew"))

barplot(survive_by_class,
        col = c("black","green"),
        beside = T,
        legend.text = T,
        names.arg = c("1st","2nd","3rd","crew"))

barplot(survive_by_class,
        col = c("gold","magenta"),
        legend.text = T,
        names.arg = c("1st","2nd","3rd","crew"),
        horiz = T)

state <- data.frame(state.x77)
View(state)
barplot(state$Income)
barplot(state$Murder)
head(state$Income) #맨 위에 있는 6행만 가지고 막대그래프 그리기
head_name = head(row.names(state))

barplot(head(state$Income), col = "brown")
axis(1, at= 1:6, lab = head_name) #축을 따로 추가해주기

barplot(head(state$Income), col = "brown", names = head_name)
#names arguments 를 써서 처음부터 넣어주기

barplot(head(state$Murder), col = rainbow(6), names = head_name)

order(state$Population, decreasing = "T")
#인구수 별로 내림차순 정렬,
rownames(state[c(5,32,43,38),]
#가장 높은 주 4개 추출
pop <- state[c(5,32,43,38),] 
row.names(pop)

barplot(pop$Population, col= "skyblue")
axis(1, at= 1:4, lab = row.names(pop))
