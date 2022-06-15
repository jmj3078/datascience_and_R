setwd("/Users/j-max/Documents/R")

install.packages("rJava")
library("rJava")
install.packages("remotes")
remotes::install_github("mrchypark/multilinguer")

library(multilinguer)
install_jdk()

install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")

install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")

remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts = c("--no-multiarch"))


library(stringr)    # 깔려있음
install.packages("KoNLP")  # 깔려있음
library(KoNLP)  # 한국어 형태소 분석하기 위한 패키지 
install.packages("NLP")    # 깔려있음
library(NLP)
install.packages("tm")     # 깔려있음
library(tm)
search()        # "package:KoNLP"   깔려있나 확인하기
useNIADic()     # 사전을 쓸게
useSejongDic()  # 사전을 쓸게

install.packages("ggplot2")
library("ggplot2")
install.packages("dplyr")
library("dplyr")

txt <- readLines("DesignThinking.txt", encoding ="UTF-8")
head(txt)

noun1 <- extractNoun(txt)
str(noun1)
noun2 <- Filter(function(x) {nchar(x)>=2}, noun1) #파이선 filter와 사용법 똑같다
str(noun2)

#gsub("찾는 단어", "바꿀 단어", 데이터)
noun2 <- gsub("산업혁명", "", noun2)
noun2
noun2 <- gsub("해결력에는", "", noun2)
noun2
noun2 <- gsub("해결력을", "해결력", noun2)

table(noun2)
sort(table(noun2))
word <- sort(table(noun2), decreasing = T)[1:40]
word
str(word)
barplot(word, names.arg = names(word),
        main = "frequency of word",
        ylab = "frequency",
        col = "pink")

word.wc <- as.data.frame(word)
word.wc 

ggplot(word.wc, aes(noun2, Freq))+
  geom_bar(stat = "identity",
           fill = "purple")+
  coord_flip()+
  geom_text(aes(label = Freq), hjust = 1)

install.packages("extrafont") 

#ggplot 폰트변경
library(extrafont) 
font_import()
theme_set(theme_grey(base_family='Apple SD Gothic Neo'))

install.packages("wordcloud")
library(wordcloud)      # 그림그려주기
library(RColorBrewer)   # 팔레트 기능 

display.brewer.all()    # 모든 팔레트를 보여줘 

pal <- brewer.pal(9,"YlGn")      # n가지 색, 팔레트이름 
wordcloud(words= word.wc$noun2,  # 단어
          freq= word.wc$Freq,    # 빈도
          min.freq= 2,           # 최소 2단어 이상
          max.words= 200,        # 최대 200단어
          random.order= F,       # 랜덤분포
          rot.per= 0.2,      # 글자방향
          scale= c(6,0.2),   # 글자크기    
          colors= pal)    # 팔레트 설정

red <- brewer.pal(7,"YlOrRd")

wordcloud(words= word.wc$noun2,
         freq= word.wc$Freq,
         min.freq= 2,
         max.words= 200,
         random.order= F,
         rot.per= 0.1,
         scale= c(5,0.3),
         colors= red)

blue <- brewer.pal(6,"Blues")
wordcloud(words= word.wc$noun2,
          freq= word.wc$Freq,
          min.freq= 2,
          max.words= 200,
          random.order= F,
          rot.per= 0.1,
          scale= c(5,0.3),
          colors= blue)
