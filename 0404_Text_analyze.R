setwd("/Users/j-max/Documents/datascience_and_R")
#사용 디렉토리 설정

install.packages("rJava")
library("rJava")
install.packages("remotes")
remotes::install_github("mrchypark/multilinguer")

library(multilinguer)
install_jdk()

install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval",
                   "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", 
                   "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", 
                   "rversions"), type = "binary")

remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts = c("--no-multiarch"))

library(stringr)    
install.packages("NLP")    
library(NLP)
install.packages("tm")     
library(tm)
search()        
useNIADic()     

getwd() #사용중인 디렉토리 확인

article <- readLines("article.txt", encoding = "UTF-8")
length(article) #문장길이
paste(readLines("article.txt"), collapse = "")

article <- gsub(pattern = ",", replace = "", article)
article <- tolower(article) #모두 소문자 처리
#toupper : 대문자처리
article <- gsub(pattern = "sk", replace = "theSK", article)
article <- gsub(pattern = "sk hynix", replace = "skhynix", article)
article <- gsub(pattern = "sk telecom", replace = "sktelecome", article)

stopwords() #텍스트 내의 불용어 목록 - tm library 
article <- removeWords(article, stopwords()) #불용어 제거
article <- stripWhitespace(article) #과도한 공백 제거
class(article) 
head(article)

#####Word Cloud#####
install.packages("wordcloud")
library(RColorBrewer)
library(wordcloud)
display.brewer.all()

blue <- brewer.pal(8, "GnBu")
blue #색 값이 벡터로 저장되어있음

dev.new(width = 1000, height = 1000)
wordcloud(words = article,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = 0.2,
          scale = c(3,0.5),
          colors = blue)

display.brewer.pal(10, "GnBu")
display.brewer.pal(10, "PuBu")
display.brewer.pal(10, "Set3")

set3 = brewer.pal(10, "Set3")

dev.new(width = 1000, height = 1000)
wordcloud(words = article,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = 0.2,
          scale = c(4,0.5),
          colors = set3)

####################

animal <- readLines("animal.txt", encoding = "UTF-8")
head(animal, n = 11)
#text이기 때문에 공백 매우 많음
length(animal) #문장 개수 분석, 2886개의 문장
paste(readLines("animal.txt"), collapse = "")
#한줄로 만들기
animal <- paste(readLines("animal.txt"), collapse = "")
animal <- gsub(pattern = ",", replace = "", animal)
animal <- gsub(pattern = "mr. pilkington", replace = "mr.pilkington", animal)
animal <- gsub(pattern = "animal farm", replace = "animalfarm", animal)
animal <- gsub(pattern = "comrades", replace = "comrade", animal)
#gsub(patternm replace row)
#쉼표 제거

class(animal) #chr 형태로 변경
animal <- tolower(animal)

animal <- removeWords(animal, stopwords())
animal <- stripWhitespace(animal)

PuBu <- brewer.pal(10, "PuBu")
Paired <- brewer.pal(10, "Paired")

#오류 방지: 새로운 창을 만들고 그 위에
#워드클라우드 생성
dev.new(width = 1000, height = 1000)
wordcloud(words = animal,
          min.freq = 2,
          max.freq = 200,
          random.order = F,
          rot.per = 0.2,
          scale = c(3,0.5),
          colors = PuBu)
