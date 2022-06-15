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
                      zoom = 11, 
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

