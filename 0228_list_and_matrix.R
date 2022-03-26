x <- c(1,3,5,7,9)
x[1]
x[4]
x[6] #error
x[1:3] #1번쨰 부터 3번째까지

x1 <- c(2,4,6,8,10)
x1[-2] #2번째 원소 제외하고 출력
x1[-c(3:4)] #3~4번쨰 원소 제외하고 출력

bookpage <- c(300,250,330,270,280,310,275,290)
hist(bookpage)  # 히스토그램 
mean(bookpage) #평균값 
median(bookpage) #중간값
summary(bookpage)  # 데이터 요약

quantile(bookpage)  # 1/4 지점, 1/2지점, 3/4지점 값
IQR(bookpage) # Inter Quatile Range: Q3- Q1  
var(bookpage)  #분산
sd(bookpage)   # 표준편차 standard deviation 
range(bookpage)  # 최소값/ 최대값 - 벡터로 반환
diff(range(bookpage))  # 최소값 최대값의 차이 

diff(c(1,2)) #벡터값, 바로 뒤에 요소 - 현재 요소 값을 반환

x <- c(3,6,4,8,2,9,7)
sort(x)  # x 변수를 오름차순 정렬
sort(x, decreasing=T)  # 내림차순 정렬 
sort(x, decreasing=F)  # 오름차순 정렬 

# list 형태
x <- list("Tom", 20, c(850, 890))  # list형성, 벡터와는 다르다
x
x[2]  # 2번째 원소 접근
x[3]

x <- list(name= "Tom", age= 20, toeic= c(850, 890)) #딕셔너리처럼 형성 가능
x
x$name  # x에서 "name"이라는 key값을 가진 값 반환
x$age
x$toeic

# matrix(행열) 
x1 <- matrix(1:20, nrow=4, ncol=5) # 1부터20까지, 4행5열 
x1 #기본값 : 1행 채운 뒤 2행으로 진행
x2 <- matrix(1:20, nrow=4, ncol=5, byrow = T) #행 방향으로
#byrow = False/ True 옵션
x2

x <- 1:4
y <- 5:8

n1 <- cbind(x,y) #열방향 xy 합체
n1
n2 <- rbind(x,y) #행방향 xy 합체
n2

x1[2,3]   # 2행3열
x1[1,]    # 1행 모든 숫자
x1[,4]    # 4열 모든 숫자 
x1[2,1:3]  # 2행, 1부터 3열
x1[1,c(2,4)] # 1행, 2열과 4열   
x1[,c(2,4)]   # 2열 4열에 있는 모든 행 

#score matrix 형성, 학생들의 시험성적
score <- matrix(c(100,80,75,77,83,90,70,60,95,88,98,82),nrow=4, ncol=3)
score
rownames(score) <- c("세현","규리","나영","민정")
colnames(score) <- c("math","eng","coding")
score

str(score) #전체적 구조
dim(score) #행,렬 (차원)

score["나영", "coding"]
score["민정",]
score[,"coding"]

#grade matrix형성, 학생들의 평점
grade <- matrix(c("a","b","c","a","a","d"), nrow = 2, ncol = 3)
grade

rownames(grade) <- c("세현","규리")
colnames(grade) <- c("math", "eng", "coding")
grade

#seq을 활용한 matrix 형성
seq(10,100,10)
score <- matrix(seq(10,100,10), nrow = 5, ncol =2)
rownames(score) <- c(1:5)
colnames(score) <- c("소연", "은유")
score

#cbind를 통한 matrix 형성
Soyeon <- c(10,20,30,40,50)
Ohnyu <- c(60,70,80,90,100)
score <- cbind(Soyeon, Ohnyu)
score

#apply 함수
score
apply(score, 1, sum) #각 행의 sum
apply(score, 1, mean) #각 행의 mean
apply(score, 2, sum) #각 열의 sum
apply(score, 2, mean) #각 열의 mean
