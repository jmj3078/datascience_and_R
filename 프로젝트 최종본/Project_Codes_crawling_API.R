install.packages("tidyverse")
install.packages("data.table")
install.packages("magrittr")
install.packages("ggplot2")
install.packages("gridExtra")
install.packages("jsonlite")
install.packages("httr")
install.packages("KoNLP")

library(tidyverse)
library(data.table)
library(magrittr)
library(ggplot2)
library(gridExtra)
library(jsonlite)
library(httr)
library(KoNLP)

search_api <- 'http://losi-api.nanet.go.kr/searchTotal'
view_api <- 'http://losi-api.nanet.go.kr/searchView'
my_key <- 'f36140c66fead822722e23e8fde4c6a33ee7fc5323e31b19c3834c5068b29e79'

#key값이 필요함.. 발급받으면 됨
#요청하는 쿼리에 맞춰서 진행
res <- POST(url=search_api,
            accept_json(),
            body = list(
              authKey = my_key,
              searchTerm = '한국문헌정보학회지',
              SearchSort='year',
              sortType='desc',
              startYear = 2017,
              endYear = 2021,
              printRowCnt = 3000
            ),
            encode='form'
)
View(res)
#텍스트형태로 변환후 JSON형태를 데이터프레임으로 변경
res %>%
  content(as='text', encoding = 'UTF-8') %>% 
  fromJSON() -> datafromapi

datafromapi %<>% data.frame()
View(datafromapi)
#dataframe화
datalis <-  datafromapi[[1]] %>% data.frame()

#원하는 내용만 빼오기 
datalis %<>% select(lodID,title,pubYear,divFlag)


datalis %>% head()

#요청하는 쿼리에 맞춰서 입력해준다
res2<- POST(url=view_api,
            accept_json(),
            body = list(
              authKey = my_key,
              lodID = datalis[1,1],
              divFlag = datalis[1,4]
            ),
            encode='form'
)

res2 %>%
  content(as='text', encoding = 'UTF-8') %>% 
  fromJSON() -> viewfromapi

viewfromapi %<>% data.frame()
data_abst <- viewfromapi[[1]] %>% data.frame


data_abst %<>% select(lodID,title,pubYear,abst) 

data_abst %>% head()

data_abst %<>% na.omit()
data_abst[261,4] %>% extractNoun()


temp<-NULL

# for(i in 1:dim(datalis)[1]){
#   res2<- POST(url=view_api,
#             accept_json(),
#             body = list(
#               authKey = my_key,
#               lodID = datalis[i,1],
#               divFlag = datalis[i,4]
#             ),
#             encode='form'
#             )
#   res2 %>%
#   content(as='text', encoding = 'UTF-8') %>% 
#   fromJSON() -> viewfromapi
#   
## %<>% 좋은 방법이니까 기억해두자
#   viewfromapi %<>% data.frame()
#   
#   if(i==1){
#     data_abst <- viewfromapi[[1]] %>% data.frame
#     data_abst %<>% select(lodID,title,pubYear,abst)
# 
#   }
#   else{
#     temp <- viewfromapi[[1]] %>% data.frame
#     temp %<>% select(lodID,title,pubYear,abst)
#     
#     data_abst %<>% rbind(.,temp)
#     temp<-NULL
#   }
#   
#   
# }
