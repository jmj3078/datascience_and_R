#중간퀴즈 
#1
candidate <- c("OSH", "PYS")
gangnam <- c(120, 80)
nowon <- c(110,100)
result <- c("elected", "failed")

mayer <-data.frame(candidate, gangnam, nowon, result)

#2
toeic <- 850
if(toeic >= 900){
  gift <- "galaxy21"
}else if(toeic >= 850){
  gift <- "earpods"
}else if(toeic >= 800){
  gift <- "pizza"
}else{
  gift <- "nothing"
}
gift

#3
x <- c(29,27,28,26,27)
y <- c(23,22,26,28,29)
plot(x, type = "o", col ="red",
     ylim = c(20,40), axes = F, ann = F)
axis(1, at = 1:5, lab=c("5월","6월","7월","8월","9월"))
lines(y, type="b", pch = 17, col = "blue", lty =5)

title(main = "지난 5개월간 대선 주자 지지율 추이")
legend(3,40, 
       c("윤석열","이재명"),
       cex =1.0,
       col = c("red, blue"), 
       pch = 21, 
       lty = 1)

install.packages("ggplot2")
library("ggplot2")

#4
ggplot(mtcars, aes(gear, mpg, group = gear, fill = gear))+
  geom_boxplot()

mtcars
sample <- mtcars[c("Merc 230", "Honda Civic","Toyota Corolla"), ]
sample$carname <- rownames(mtcars[c("Merc 230", "Honda Civic","Toyota Corolla"), ])
ggplot(sample, aes(x=carname, y= hp))+
  geom_bar(stat = "identity",
           fill = "purple",
           width = 0.5)

car_cyl <- split(mtcars, mtcars$cyl)
car_cyl
mean(car_cyl$`4`$mpg)
mean(car_cyl$`6`$mpg)
mean(car_cyl$`8`$mpg)

Orange
Orange$age[c(10, 15, 20)] <- NA
mean(Orange$age, na.rm = T)

