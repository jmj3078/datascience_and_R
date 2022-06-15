#surveydata: 빈도분석
getwd()
setwd("/Users/j-max/Documents/datascience_and_R")
life <- read.csv('life.csv')
View(life)
dim(life)
sum(is.na(life)) #결손값 수 확인
#빈도분석: 단순빈도분석은 table
table_v1.1 <- table(life$v1.1)
table_v1.1

#property, 비율보기 : prop.table()
round(prop.table(table_v1.1), 2)

#평균계산 : 평균적인 값 확인
table(life$v2)
mean(life$v2, na.rm=T)

attach(life)
table(v5)
table(v5, useNA = 'ifany') #NA빈도까지 출력
mean(v5, na.rm = T) #NA무시하고 평균값 계산
boxplot(v5) 
prop_v5 <- prop.table(table(v5))
prop_v5
#빈도분석 시각화 : barplot, piechart, boxplot사용!
pie(prop_v5)
barplot(prop_v5,
        names= c(1:10))

##################################################
#_test, 교차분석
#두 개별 분포의 독립성을 확인
install.packages("ggplot2")
install.packages("gmodels")
library(ggplot2)
library(gmodels)

table(v2)
table(v2, SQ1) #교차분석 기본 : table사용
#단순히 빈도수만 제공

CrossTable(v2, SQ1)
#빈도수
#카이 제곱 값
#행 기준 비율(확률)
#열 기준 비율(확률)
#전체 기준 비율(확률)

chisq.test(v2, SQ1)
#카이 스퀘어값, 자유도, p-value 반환
#p-value < 0.05일떄 두 분포는 독립하지 않다

#예제1) 성별과 행복도 교차분석
happy <- table(v2, SQ1)
barplot(happy)
barplot(happy, beside = T, names= c('male','female'),
        col = topo.colors(4))
#성별에 대한 행복도 분포 barplot으로 표현
ggplot(life, aes(SQ1, group=v2, fill=v2))+
  geom_bar(position="stack")
#ggplot을 활용한 시각화,
#group=행복도에 대한 성별 비율

#예제2) 성별과 정치 관심도 교차분석
table(v26) #정치 관심도
mean(v26, na.rm = T)
table(v26, SQ1)
chisq.test(v26, SQ1) #p < 0.05, 둘은 독립하지 않다
pol <- table(v26, SQ1)
barplot(pol)
barplot(pol, beside=T, names= c('male', 'female'),
        col = topo.colors(4))
ggplot(life, aes(SQ1, group=v26, fill=v26))+
  geom_bar(position = "dodge")
ggplot(life, aes(v26, group=SQ1, fill=SQ1))+
  geom_bar(position = "stack")+
  facet_grid(SQ1~.) #SQ1에 대한 분할

#예제3) 전쟁 찬반유무 / 한국인에 대한 자부심 
table(v65)
#1:no, 2:yes
v65[v65 == 77] <- NA
table(v79)
v65
CrossTable(v70, v65)
chisq.test(v70, v65) #p>0.05, 두 분포는 독립
proud <- table(v70, v65)
barplot(proud, beside=T, names= c('disagree', 'agree'),
        col = topo.colors(4))

############################################
#t,test : 분산과 평균값의 차이를 고려하는것
#예제1) 유신론자/무신론자에 대한 행복도차이
table(v48)
table(v5)
mean(v5, na.rm = T)
mean(v5[v48==1], na.rm=T)
mean(v5[v48==2], na.rm=T)
t.test(v5~ v48) 
#v48에 대한 v5의 평균값의 차이를(그룹화)
#분산까지 고려해 일반화하는 것

#예제2) 환경단체 기부유무/ 따른 정치 성향
table(v24)  # 1 기부O 2 기부X
table(v29)
mean(v29, na.rm = T)  #정치성향(1진보 10보수)
mean(v29[v24==1], na.rm = T)  #6.82
mean(v29[v24==2], na.rm = T)  #5.392857
t.test(v29 ~ v24)

############################################
#ANOVA test : 두 변수간의 연관성 분석
#예제1)
table(v5) #삶의 만족도 평균
mean(v5, na.rm=T)
aov.v5_13 = aov(v5 ~ v13)
#삶의 만족도와 행복도간의 연관성분석
summary(aov.v5_13)
#Pr(>F) : 0.788
#데이터 분포상 차이가 있어 보여도
#분산이 크면 연관성이 작다고 볼 수 있음
ggplot(life, aes(x=v13, y=v5, group=v13))+
  geom_boxplot(fill="pink")
#문항별 행복도 분포 시각화 

ggplot(life, aes(x=v5, fill=v13))+
  geom_histogram()+
  facet_wrap(~v13) #v13에 따라 분할
#histogram의 치우침차이 확인
#예제2)
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

########################################
#상관관계 분석 : correlation test
plot(v5, v15)
cor.test(v5, v15)
#p value < 0.05이면 상관관계 존재
#상관계수 : cor

#기본 제공 pair plot사용한 상관관계 시각화
#iris의 모든 column들 간의 상관관계 시각화
pairs(iris[1:4], pch=21, bg = c("red","green","blue"))
pairs(iris[1:4], pch= 21,
      bg = c("red", "green", "blue")[unclass(iris$Species)])
# pch 21~25일때 bg설정 가능, 기억해 둘것

#corrplot사용하여 시각화 및 상관관계 분석
install.packages("corrplot")
library(corrplot)
econ <- life[, 85:90]
#경제질문 30~35번 문항
View(econ)
sum(is.na(econ))
econ <- na.omit(econ) 
#결손값 제거, na.omit:결손값 존재 row삭제

cor(econ)#상관계수 행렬 반환
round(cor(econ), 2)
plot(econ)#산점도 행렬
pairs(econ, pch=21,
      bg = rainbow(5),
      panel = panel.smooth)
#추세선 추가 : panel= panel.smooth

cor_mtx = cor(econ) #상관계수 행렬
corrplot(cor_mtx) #상관계수 heatmap
corrplot(cor_mtx, method='number',
         type='lower',
         tl.srt=45) #상관게수 숫자

########################################
#상관관계 분석 = pearson 상관계수
install.packages("psych")
library(psych)
corr.test(econ, use="complete", #결측값제거
          method = "pearson",
          adjust = "none")
#0,05보다 작으면 0으로 출력, 상관관계 높음

########################################
#회귀분석 : 모델링
reg1 <- lm(v29 ~ v86, data = life)
#종속변수 ~ 독립변수
summary(reg1)
#R^2 : 회귀선의 설명력, 두 변수간의 관계성이 높다. 설명력이 높다.
#Y 절편/ 회귀 계수(기울기), P value 
#결정계수 : R-squared - 설명력, adjusted가 보통의 경우 활용됨
#p값이 작기 때문에 유의미하다 (p < 0.05)
plot(v86, v29)
abline(reg1, col="red")
#reg1 을 사용해 abline그을 수 있음

#이분변수로 측정된 경우(예, 아니오) 
#0과 1으로 변수를 변환하여 진행
plot(v48, v5)
v48[v48 == 2] <- 0
reg5 <- lm(v5 ~ v48)
summary(reg5)
abline(reg5, col="red")

plot(mtcars$wt, mtcars$mpg)
line <- lm(mtcars$mpg~ mtcars$wt)   
# Y축변수~ X축변수(lm : 회귀분석)
abline(line, col="red")

########################################
#다중회귀 분석, 3차원 공간 산점도
install.packages("scatterplot3d")
library(scatterplot3d)
View(mtcars)
model_3d <- scatterplot3d(
  mtcars$wt, mtcars$hp, mtcars$mpg,
  xlab = "weight",
  ylab = "horsepower",
  zlab = "miles per gallon",
  pch = 19, type = "h",
  highlight.3d = T) #수직선 추가
)
#종속변수 mpg, 독립변수 wt, disp
reg3d <- lm(mpg~ wt + disp, data=mtcars)
model_3d$plane3d(reg3d)
#회귀평면 그리기
summary(reg3d) 
#회귀분석 결과 반환

#예제1)
mreg1 <- lm(v5 ~ v41+v48+v86)
summary(mreg1)
#회귀식 : y= 4.42351 + 0,079x1 + 0.357x2+ 0.303x3 + error
#설명력 : 11%(multiple- R squared)
#p-value: 0.05보다 낮음(유효)

#예제2)
m.reg2 <- lm(v5~ v14+ v15)     
# 종속~ 독립1+ 독립2 ....
summary(m.reg2)
# Y= 3.88 -0.08*X1+ 0.49*X2 + error
# 27.1%의 설명력

#########################################
#표준화 회귀계수 - lm.beta
install.packages("lm.beta")
library(lm.beta)
m.reg1 <- lm(v5~ v41+ v48+ v86) 
m.reg1 <- lm.beta(m.reg1)
summary(m.reg1)
#Standardized 회귀계수 추가
m.reg2 <- lm(v5~ v14+ v15)     # 종속~ 독립1+ 독립2 ....
m.reg2 <- lm.beta(m.reg2)
summary(m.reg2)

m.reg3 <- lm(v74.3~ v78+ v79)     # 종속~ 독립1+ 독립2 ....
m.reg3 <- lm.beta(m.reg3)
summary(m.reg3)
#########################################
#회귀모형 진단 (다중공신성) : vif<5 이면 문제 X
install.packages("car")
library(car)
vif(m.reg1)
vif(m.reg2)
vif(m.reg3)

#회귀모형 진단 (Durbin Watson test)
install.packages("imtest")
library(imtest)
dwtest(m.reg1)
dwtest(m.reg2)
dwtest(m.reg3)

# 회귀모형 진단
# (잔차의 등분산성, 산점도확인)
par(mfrow = c(2,2)) #2X2화면분할
plot(m.reg1)
plot(m.reg2)
plot(m.reg3)
par(mfrow=c(1,1))

#residual test, 엄격한 진단
r.reg1 <- residuals(m.reg1)  
summary(r.reg1)

#shapiro test, 정규분포 근사 확인
shapiro.test(r.reg1) #p < 0.05
#histpgram그려서 눈으로 확인
hist(r.reg1) 

r.reg2 <- residuals(m.reg2)
summary(r.reg2)
shapiro.test(r.reg2) #p < 0.05
hist(r.reg2)

r.reg3 <- residuals(m.reg3)
shapiro.test(r.reg3)
hist(r.reg3)
#########################################
#losistic 회귀분석 : 이항으로 나눔
table(v2) #행복한가
life$happy <- life$v2
life$happy[life$happy == 1] <- 1
life$happy[life$happy == 2] <- 1
life$happy[life$happy == 3] <- 0
life$happy[life$happy == 4] <- 0

prop.table(table(life$happy))
#행복하다/행복하지 않다를 이항으로 나눔(1, 0)
log.reg1 <- glm(life$happy~ v14+v29+v86, 
                family = binomial)
#이항 로지스틱 회귀 분석
summary(log.reg1)
exp(coef(log.reg1)) 
# 개별 변수의 odds ratio(로그 해제)
# 소득 1단위 증가할 때, 행복할 odds ratio가 1.34배 증가
# exp(0.29325)= 1.34(v86의 오즈비)
# 회귀식 ln(p/1-p)= ax+ b(절편)+ error
#########################################
# Pseudo R_squared와 p-values
install.packages("rcompanion")
library(rcompanion)
#Nagelkerke의 계산 방식에 따른 
#R-squared value 계산방식!
#logistic 회귀모델 유효성 검사
nagelkerke(log.reg1)

#예제1)
table(v48)   # 신에 대한 믿수
prop.table(table(v48))
life$v48[life$v48 == 2] <- 0
table(v3) # 건강함
table(life$SQ1) # 소득수준
life$SQ1[life$SQ1 == 2] <- 0

#예제2)
log.reg2 <- glm(life$v48~ v3+SQ1+v86, 
                family= binomial)

summary(log.reg2)
t.test(v86~ v48)  # ttest 확인
exp(coef(log.reg2))    # odds 비율 
nagelkerke(log.reg2)   # 모형이 적합한가판단

#예제3)
war <- life$v19
life$war <- war
life$war[life$war == 1] <- 1
life$war[life$war == 2] <- 0
life$war[life$war == 77] <- NA

log.reg4 <- glm(life$war ~ v29 + v40 + v70,
                family= "binomial")
summary(log.reg4) #v40, v70 유의미
exp(coef(log.reg4)) #odds 비율
nagelkerke(log.reg4) #회귀모델 유효성
#########################################
#조절효과
attach(mtcars)
plot(hp, mpg)
reg <- lm(mpg~ hp)
abline(reg, col= "red")

mreg1 <- lm(mpg~ hp + wt)
summary(mreg1) #둘다 유효
#hp 커질수록 wt 커질수록 mpg 낮아짐
#조절효과 항이 유의미한지 확인 ~ hp:wt
reg2 <- lm(mpg ~ hp + wt + hp:wt)
summary(reg2)

#조절효과 그래프 시각화
#무조건 복붙해서 쓰자.
install.packages("effects")
install.packages("nloptr")
library(effects)
m <- mean(mtcars$wt) #기댓값
s <- sd(mtcars$wt) #표준편차

plot(effect(term= "hp:wt", mod=reg2,
     xlevels = list(wt=c(m-s, m, m+s))),
     lines= list(multiline = TRUE, lwd=2,
                 lty = c(3,2,1),
                 col = c("red","blue","purple")))

reg3 <- lm(mpg~ hp+cyl+ hp:cyl)
summary(reg3)
plot(effect(term= "hp:cyl", mod = reg3, 
            xlevels= list(cyl= c(4,6,8))),
     lines= list(multiline= TRUE, lwd=2, 
                 lty= c(1,2,3), 
                 col= c("red","blue","purple")))

#life
attach(life)
reg4 <- lm(v69.6~ v29+v48+ v29:v48)
summary(reg4)
plot(effect(term= "v29:v48", mod = reg4, 
            xlevels= list(cyl= c(4,6,8))),
     lines= list(multiline= TRUE, lwd=2, 
                 lty= c(1,2,3), 
                 col= c("red","blue","purple")))
#########################################
#ggmap
install.packages("installr")
library(installr)
check.for.updates.R()
install.R()
version

install.packages("ggmap")
library(ggmap)
register_google(key="AIzaSyA5x0d6cLHBXNGA9SSgoYpjvaM0jy-kNNE")
skk <- geocode(enc2utf8("명륜4가"))
skk

cn  <- as.numeric(skk)  # skk를 숫자 벡터로 바꿔줘
cn   # 정확한 위도 경도 출력
map1 <- get_googlemap(center = cn, 
                      maptype = "roadmap", 
                      markers = skk)
ggmap(map1)  # map을 지도에서 보여줘 

# n개의 장소 지도에 표시하기(데이터프레임)
court5 <- c("서울중앙법원", "서울동부법원", "서울서부법원", "서울남부법원", "서울북부법원")
court  <- geocode(enc2utf8(court5))  # 5개법원 지도화
court
df_court <- data.frame(name= court5, 
                       lon= court$lon, lat= court$lat)

df_court   # 5개 법원 데이터 프레임. 위도경도
cn2 <- c(mean(df_court$lon), mean(df_court$lat))   # 지도의 중심점 (5개 법원의 위도 경도 평균치)

map2 <- get_googlemap(center = cn2, 
                      maptype = "roadmap", zoom = 11,
                      markers = court)
ggmap(map2)  # 지도에 5개 법원 마크로 표시해라
court_map <- ggmap(map2)
court_map + geom_text(data=df_court, 
                      aes(x= lon, y= lat),
                      label= court5, 
                      size=5)  # 폰트크기

setwd("/Users/j-max/Documents/datascience_and_R")
skk_map  <- read.csv("skk_map.csv", header = TRUE, fileEncoding = "CP949", encoding = "UTF-8")
skk_map
place1  <- geocode(enc2utf8(skk_map$place))
place1
df   <- data.frame(name= skk_map$place, 
                   lon= place1$lon, lat= place1$lat)
df  # 4개장소의 위도 경도 데이터 프레임 형태로 저장

# 지도의 중심점 설정(4개장소의 위도 경도 평균값)
cn3 <- c(mean(df$lon), mean(df$lat))   
cn3

# 지도 가져오기, 지도의 형태, 확대크기, 지도크기, 마커위치
map3 <- get_googlemap(center = cn3, 
                      maptype = "roadmap", 
                      zoom = 10, 
                      markers = place1)
ggmap(map3)  # 4개장소 마커 표시해라
hotpl <- ggmap(map3)
# 장소 텍스트 표시
hotpl + geom_text(data= df, aes(x= lon, y= lat),
                  label= df$name, size=6) 

# 서울 인구 지도에 표시하기
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("maptools")
install.packages("rgdal")
install.packages("gpclib") 

library(ggplot2)
library(raster)
library(rgeos)
library(maptools)
library(rgdal)
library(gpclib)
search()
# 서울 인구/ 구별 id 데이터
seoul_pop  <- read.csv("seoul_pop.csv", fileEncoding = "euc-kr")
head(seoul_pop)   
#지리 정보 데이터셋(시군구 좌표) 불러오기
map <- shapefile("sig.shp") 
# spTransform 함수로 좌표변환 해줘야
map <- spTransform(map, CRSobj = CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))
map
# fortify함수를 이용하여 map을 data frame으로 변환
new_map <- fortify(map, region = 'SIG_CD')
View(new_map)
str(new_map)  # id값이 문자로 되있음
new_map$id <- as.numeric(new_map$id)   # id 숫자형으로 변환
# 서울id: 11740 이하
seoul_map <- new_map[new_map$id <= 11740,]
View(seoul_map)
# 시각화하려는 서울인구 데이터와 merge
P_merge <- merge(seoul_map, seoul_pop, by='id')
View(P_merge)

# 서울시 지도
ggplot() + 
  geom_polygon(data = P_merge, 
               aes(x=long.x, y=lat.x, group=group), 
               fill = 'linen', color='black')
ggplot() + 
  geom_polygon(data= P_merge, 
               aes(x=long.x, y=lat.x, 
                   color= "white",  # 경계선
                   group= group, fill = sum))  # sum 인구

# 지도+ 구별인구
ggplot() + 
  geom_polygon(data= P_merge, 
               aes(x=long.x, y=lat.x, 
                   group= group, fill = sum))+
  geom_text(data = seoul_pop, 
            aes(x= long, y= lat, 
                label = paste(X, sum, sep= "\n")))+
  scale_fill_gradient(low = "#FFDFD3", 
                      high = "#00CC99", 
                      space = "Lab", 
                      guide = "colourbar")+
  labs(fill = "population")

#서울에 있는 학교 marking
school  <- read.csv("school_map.csv", fileEncoding = "euc-kr")
View(school)
school_hs <- school[school$초중고 == "고등학교", ]
seoul_hs <- school_hs[school$시도교육청=="서울특별시교육청", ]
View(seoul_hs)

#지도 중심점 결정
cn4 <- c(mean(seoul_hs$경도, na.rm = T), mean(seoul_hs$위도, na.rm=T))   
cn4

map4 <- get_googlemap(center = cn4,
                      maptype = "roadmap",
                      zoom = 11)
ggmap(map4)
#서울 고등학교 표시
table(seoul_hs$설립형태)
ggmap(map4) + 
  geom_point(data= seoul_hs, 
             aes(x=경도, y=위도, color = 설립형태),
             size= 3)

ggmap(map4) + 
  geom_point(data= seoul_hs, 
             aes(x= 경도, y= 위도, color= 교육지원청),
             size= 4)

# 설립연도가 1910년 이하인 전국 학교 시각화
hist(school$설립년도)
traditional <- school[school$설립년도 < 1910, ]
# 지도의 중심점 설정(위도 경도 평균값)
cn1 <- c(mean(traditional$경도), mean(traditional$위도))   
cn1

# 지도 가져오기, 지도의 형태, zoom값
map1 <- get_googlemap(center = cn1, 
                      maptype = "roadmap", 
                      zoom = 8)
ggmap(map1)  

ggmap(map1) + 
  geom_point(data= traditional, 
             aes(x= 경도, y= 위도, 
                 color= 초중고),
             size= 3)+
  geom_text(data= traditional, 
            aes(x= 경도, y= 위도),
            label= traditional$name,  # 학교이름 붙이기
            size= 3)

#부산 내 초등학교 분포
busan_el = school[school$초중고 == "초등학교" & school$시도교육청 == "부산광역시교육청", ]
busan_el$설립년도
cn_p <- c(mean(busan_el$경도), mean(busan_el$위도))
map_busan <- get_googlemap(center= cn_p,
                           maptype = "roadmap",
                           zoom = 11)
ggmap(map_busan)+
  geom_point(data= busan_el,
             aes(x= 경도, y= 위도, color = 설립년도),
             size = 3)+
  geom_text(data = busan_el,
            aes(x=경도, y=위도),
            label = busan_el$name,
            size = 3)
