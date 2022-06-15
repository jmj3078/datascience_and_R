install.packages("ggplot2")
install.packages("gmodels")
library(gmodels)
library(ggplot2)

getwd()
setwd("/Users/j-max/Documents/datascience_and_R")
life <- read.csv(file = "life.csv")
attach(life)
detach(life) #안쓸때는 때면 됨

attach(life)
table(v2)
table(v2, SQ1) #교차분석, 기본


#두 척도 모두 
#빈도수
#카이 제곱(기대치 비율)
#행을 기준으로 비율
#열을 기준으로 비율
#전체 기준 비율

CrossTable(v2, SQ1) #비율 포함 교차분석

#카이 스퀘어값 반환
#분포의 차이를 나타내는 value : p-value
#성별 행복도
chisq.test(v2, SQ1)
happy <- table(v2, SQ1)
barplot(happy)
barplot(happy, beside = T, names = c("male", "female"),
        col = topo.colors(4))
ggplot(life, aes(x= SQ1, group = v2, fill = v2))+
  geom_bar(position = "stack")

#성별 정치 관심도
table(v26)
mean(v26, na.rm = T)
table(v26, SQ1)
chisq.test(v26, SQ1)
pol <- table(v26, SQ1)
barplot(pol)
barplot(pol, beside = T, names = c("male","female"),
        col = heat.colors(4))
ggplot(life, aes(x=SQ1, group=v26, fill=v26))+
  geom_bar(position="stack")
ggplot(life, aes(x=v26, fill=SQ1))+
  geom_bar()+
  facet_grid(SQ1~.) #SQ1에 따라 분할


#전쟁 찬반에 따른 한국인 부심
table(v65)
v65[v65==77] <- NA
table(v79)
CrossTable(v70, v65)
chisq.test(v70, v65)
proud <- table(v70, v65)
barplot(proud)
barplot(proud, beside =T, names=c("No", "Yes"), col = cm.colors(4))
#결론 : 두 값은 연관 없음

#유신론자/무신론자 삶 행복도 
table(v48)  # 1 믿음 2 안믿음
table(v5)
mean(v5, na.rm = T)  # 삶의 만족도 평균(10이 가장높음)
mean(v5[v48==1], na.rm = T)  # 6.82
mean(v5[v48==2], na.rm = T)  # 6.36
#평균값이 차이가 난다. 단 분산을 고려하지 않음
t.test(v5~ v48) #분산까지 고려하여 일반화 할 수 있도록 한다

# 환경단체 기부(24번)에 따른 정치 성향(29번)
table(v24)  # 1 기부O 2 기부X
table(v29)
mean(v29, na.rm = T)  #정치성향(1진보 10보수)
mean(v29[v24==1], na.rm = T)  #6.82
mean(v29[v24==2], na.rm = T)  #5.392857
t.test(v29 ~ v24)
#기부를 한쪽과 안한 쪽이 0.3차이가 난다

#결혼상태가 삶의 만족도와 관계가 있는가?(anova)
table(v13)
v13[v13==2] <- NA
v13[v13==3] <- NA
v13[v13==4] <- NA

table(v5)
mean(v5, na.rm = T)
#삶의 만족도 평균
aov.v5_13 = aov(v5 ~ v13)
#삶의 만족도 - 결혼간 연관석 분석
summary(aov.v5_13)
#Pr(>F) : 0.788
#데이터 분포상에 차이가 있는 것으로 보여도, 
#분산이 크면 연관성이 작다고 볼 수 있다
ggplot(life, aes(x= v13, y= v5, group= v13))+
  geom_boxplot(fill="pink")
#문항별 행복도의 분포 시각화

ggplot(life, aes(x= v5, fill = v13))+
  geom_histogram()+
  facet_wrap(~v13)

#행복감 인식에 따른 소득수준
table(v2)    # 행복
table(v86)   # 주관적 소득수준(10이 고소득)
mean(v86, na.rm = T)   
c= aov(v86~ v2)
summary(c)
ggplot(life, aes(v2, v86, group= v2))+
  geom_boxplot(fill= "yellow") 
ggplot(life, aes(x=v86, fill= v2))+
  geom_histogram()+
  facet_wrap(~v2)

#주관적 계층의식에 따른 소득수준
table(v85)
table(v86)
mean(v86, na.rm = T)
d = aov(v86~ v85)
summary(d)
ggplot(life, aes(v85, v86, group= v85))+
  geom_boxplot(fill= "yellow") 
ggplot(life, aes(x=v85, fill =v86))+
  geom_histogram()+
  facet_wrap(~v2)

table(v5)
table(v86)
mean(v86,na.rm = T)
d = aov(v5 ~ v86)
summary(d)
ggplot(life, aes(v5, v86, group = v5))+
  geom_boxplot()
