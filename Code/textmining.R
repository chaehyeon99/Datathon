# required library
library(tm)
library(rJava)
library(KoNLP)
library(devtools)
#useNIADic()
library(wordcloud2)

text_o <- read.csv("information2.csv",header=T)

name <- c("아마추어축구부","고대바둑사랑","KUBT","KUCC","유스호스텔","고고쉼","원불교학생회",
          "SFC","CCC","뇌의주름","ENM","돌빛","고집","수호회","고전기타부","KUSEP","KUBC",
          "FC엘리제","관현악단","노래얼","백구회","농구연합회","한일문화연구회","그루터기",
          "운화회","한량회",'택견한울',"한국화회","TTP","소믈리에","호영회","크림슨","관악부",
          "ATP","고대농악회","JASS","서화회","궁도회","캘리쿠","팝콘","거의격월간몰라도되는데",
          "그림마당","호우회","LoGS","열두루달","ALC","고려대학교 합창단","한국사회연구회","ECS",
          "중국연구회","예술비평연구회","NewLearn","불아스","KUDT","한국근현대사연구회","TERRA",
          "국악연구회","미스디렉션","UNSA","극예술연구회","수레바퀴",'IVF',"로타랙트","젊은예수",
          "평화나비","예수전도단","KURC","호진회","KUSA","소울메이트","JOY","ENTHES","탁구사랑회",
          "고풋","LECA","사람과사람","철학마을","고대문학회")
performance <- c("JASS","TTP","고대농악회","고전기타부","관악부","관현악단","국악연구회","불아스",
                 "노래얼","크림슨","ATP","KUDT","LoGS","극예술연구회","미스디렉션","소울메이트","고려대학교 합창단")
society <- c("KURC","KUSA","KUSEP","고집","로타랙트","운화회","호우회","고고쉼")
self <- c("KUCC","팝콘","ALC","ECS","LECA","중국연구회","한일문화연구회")
habit <- c("고대바둑사랑","뇌의주름","소믈리에","유스호스텔","호진회","거의격월간몰라도되는데",
           "그림마당","돌빛","서화회","캘리쿠","한국화회","호영회")
study <- c("UNSA","고대문학회","NewLearn","사람과사람","수레바퀴","열두루달","예술비평연구회",
           "철학마을","평화나비","한국근현대사연구회","한국사회연구회","KURP","고란도란")
religion <- c("CCC","ENM","IVF","JOY","SFC","예수전도단","원불교학생회","젊은예수","불교학생회")
exercise <- c("ENTHES","FC엘리제","KUBC","KUBT","고풋","궁도회","농구연합회","백구회","수호회",
              "아마추어축구부","탁구사랑회","택견한울","한량회","KULAX")

text_o[,1] <- name

# 없는 동아리 추가

text_o <- rbind(text_o, c("KURP","KURP는 종교철학 동아리입니다. 신과 종교, 철학에 대한 다양한 탐구와 학술적 논의와 토론을 통해 
                      각 종교와 철학이 가진 생각들을 공유하고자 합니다. 또한 단순히 학문에서 그칠 것이 아니라 종교철학을 통해 
                      모람과 학우분들이 대학생활 및 진로 등을 설계하는 데 도움이 되고자 합니다.",
                      "KURP는 대학생들에게는 다소 어렵게 다가올 수 있는 종교철학이라는 분야를 보다 알기 쉽고 접근하기 
                      쉽게 만들어 고려대학교 학우분들과 나아가서는 우리의 공동체가 종교철학을 즐겁게 향유할 수 있게 하려는 
                      목표를 가지고 있습니다. 이를 위해서 우리는 그룹별 모임 및 세미나 등의 활동을 통해 
                      종교철학을 이야기할 수 있는 장을 만들고 있습니다.",
                      "개강과 종강 시기 총회를 개최하며, 팀별 정기회의에서 팀별로 회의와 토론을 온/오프라인으로 진행합니다. 
                      또한 종교철학 토론회를 개최하고자 합니다.",""))

text_o <- rbind(text_o, c("고란도란","고란도란은 '고려대+도란도란'의 합성어로 고대 학생들이 도란도란 자신의 생각을 
                      얘기하는 동아리라는 뜻입니다. 고란도란은 승리만을 위한 토론을 지양하고 학내 구성원들이 
                      성별, 전공, 나이, 정치적 신념에 관계없이 자신의 생각을 자유롭게 나눌 수 있는 토론을 지향하고 있습니다.",
                      "형식을 갖춘 토론이 중심이지만 가벼운 주제로 쉽게 이야기할 수 있는 즉석토론, 찬/반 외에 다양한 입장이 
                      있는 모서리토론, 원탁토론 등도 진행합니다. 이를 통해 고란도란은 회원들에게 '어떻게 해야 
                      토론을 이길 수 있는가'보다 '하나의 사건을 어떻게 바라보아야 하는가'에 대한 고민을 하게 합니다. 
                      따라서 '각자의 성장'이 아닌 '서로의 성장'을 토론을 통해 도모합니다.",
                      "1분 스피치, 연세대 토론 동아리 YDT와 교류 토론전 진행, 신입기수 토론대회 예/결선 진행 예정",""))

text_o <- rbind(text_o, c("불교학생회","저희 불교학생회는 불교에 관심을 가지고 있는 학우들이 모여 불교에 대해 알아가고 
                      부처님의 가르침을 배우며 실천해 나가는 동아리 입니다.",
                      "국적과 나이를 가리지 않으며, 불교의 가르침을 통해 자신을 성찰하여 동아리 일원 모두가 주체적인 
                      삶을 살도록 하는 것이 목표입니다. 단지 종교적인 것뿐 아니라, 철학으로, 학문으로 , 실용으로 또는 
                      단순한 호기심으로 불교를 바랍괴도 합니다. 그 과정에서 학업, 진로, 인간관계 등 모든 일상 속에서 
                      지친 몸과 마음을 회복하고 자신의 마음을 바라볼 수 있는 능력을 향상시키는 것 또한 목표입니다. 
                      매주 법회 때 스님과 함께 명상, 참선을 하며 몸과 마음을 단정하게 할 수 있는 것도 
                      저희 동아리의 특징입니다.",
                      "1. 정기법회 : 격주 화요일마다 지도법사님의 지도 아래 법회를 진행합니다. 지도법사님의 법문과 
                      함께 일상생활에서 벗어나 힐링해보세요 
                      2. 연등제 : 매년 부처님 오신날, 서울 시내 모든 대학의 불교학생회가 참여하는 
                      장엄한 연등행렬에 참여합니다!
                      3. 연화제 : 불교학생회 활동 중 돌아가신 선배님들을 기립니다.
                      4. 연합법회 : 연세대학교, 경희대학교 등 다른 학교와 법회도 하고, 
                      뒤풀이도 하면서 친목을 다집니다!,
                      5. 템플스테이 : 마음 맞는 법우들과 함께 국내의 이름난 사찰을 방문해 템플스테이를 하면서 
                      심신의 안정과 수련을 도모합니다.",""))

text_o <- rbind(text_o, c("KULAX","고려대학교 중앙 여자 라크로스 동아리입니다.",
                      "KULAX는 다양한 전공을 가진 팀원과 함께 경기를 뛰면서 팀워크 쌓고 친목을 도모합니다. 
                      비교적 신설 동아리임에도 불구하고, 꾸준히 정기 연습에 참여하는 졸업생 멤버들이 있을 만큼 
                      돈독한 팀워크를 자랑합니다. 라크로스는 북미 지역에서 즐겨 하는 국민 스포츠로 시작하여, 
                      전 세계적으로 인기를 얻고 있지만 아직 한국에서는 생소한 스포츠입니다. 
                      저희는 라크로스라는 스포츠를 더 많은 고려대 학생들에게 소개하면서, 여학우들이 팀 스포츠를 
                      즐길 수 있는 기회를 마련하고자 하는 목표를 갖고 있습니다. 또한, 대학 내에서 흔하게 찾아볼 수 
                      있는 각종 남자 스포츠 팀에 비해 상대적으로 찾기 힘들고, 주목받기 어려운 여자 스포츠 팀으로서 
                      긍지와 책임감을 갖고 동아리 활동을 하고 있습니다. 추후 고연전 경기에 여자 스포츠팀 종목으로 들어가는 
                      것이 장기적인 목표이며, 금전적 어려움 없이 세계 각국에서 진행되는 라크로스 경기에도 마음껏 
                      참여할 수 있도록 팀을 탄탄하게 만들고자 합니다. 더불어, 한국라크로스협회 주최의 대회 등에 
                      참가하여 다른 팀들과의 경쟁에서 고려대를 대표하여 좋은 성적을 내고, 
                      궁극적으로 국내 라크로스의 저변을 늘려가는 데에 기여하고자 합니다.",
                      "1. 학기 초 신입모집 트라이아웃 2. 신입부원을 위한 룰 클리닉 진행 
                      3. 비정기 연습, 개인 연습 진행 그밖에 대학 리그나 인도어리그를 통해 팀워크를 다지고 
                      경기 경험을 쌓고 있습니다.",""))


wc <- function(class){
  # 특정 그룹 지정
  text <- text_o[text_o[,1] %in% class,]
  
  # 문자열 병합
  text <- paste(text[,2],text[,3],text[,4],text[,5])
  
  text1 <- VCorpus(VectorSource(text))
  
  # 불필요한 공백 제거
  for (i in seq_along(text1)){
    text1[[i]]$content <- paste(text1[[i]]$content, collapse=" ")
  }
  
  # 문장 부호 제거
  text <- tm_map(text1, removePunctuation)
  
  #숫자 제거
  text <- tm_map(text, removeNumbers)
  
  #특수문자 제거
  for (i in seq_along(text)){
    text[[i]]$content <- gsub("’", "", text[[i]]$content)
    text[[i]]$content <- gsub("‘", "", text[[i]]$content)
    text[[i]]$content <- gsub("·", " ", text[[i]]$content)
    text[[i]]$content <- gsub("ᆞ", " ", text[[i]]$content)
    text[[i]]$content <- gsub("!", "", text[[i]]$content)
  }
  
  # 한글 어근 추출
  for (i in seq_along(text)){
    nouns <- extractNoun(text[[i]]$content)
    nouns <- nouns[nchar(nouns) > 1]
    text[[i]]$content <- paste(nouns, collapse=" ")
  }
  
  # 불용어 제거
  for (i in seq_along(text)){
    text[[i]]$content <- gsub("동아리","",text[[i]]$content)
    text[[i]]$content <- gsub("대학교","",text[[i]]$content)
    text[[i]]$content <- gsub("사람들","",text[[i]]$content)
    text[[i]]$content <- gsub("목요일","",text[[i]]$content)
    text[[i]]$content <- gsub("화요일","",text[[i]]$content)
    text[[i]]$content <- gsub("있습니","",text[[i]]$content)
    text[[i]]$content <- gsub("프로그램","",text[[i]]$content)
    text[[i]]$content <- gsub("고삐풀린광고단","",text[[i]]$content)
    text[[i]]$content <- gsub("불편함","",text[[i]]$content)
  }
  
  # 단어문서행렬
  text_tdm <- TermDocumentMatrix(text, control=list(tokenize="scan",wordLength=c(2,Inf))) # 단어 길이 2 이상
  
  #wordfreq
  wordFreq <- slam::row_sums(text_tdm)
  wordFreq <- sort(wordFreq, decreasing=TRUE)
  
  # wordcloud
  wordcount <- data.frame(wordFreq)
  wordcount["name"] <- rownames(wordcount)
  wordcount["freq"] <- wordcount["wordFreq"]
  wordcount <- wordcount[wordcount["freq"]>=2,2:3]
  wordcount
  wordcloud2(data=wordcount,fontFamily = '나눔바른고딕',shape="circle")
}

# 키워드 대분류 별 wordcloud 생성
wc(performance)
wc(society)
wc(self)
wc(habit)
wc(study)
wc(religion)
wc(exercise)

### 중간 과정 확인을 위한 코드 ex. 운동
'''
# 특정 그룹 지정 
text <- text[text[,1] %in% exercise,]

# 문자열 병합
text <- paste(text[,2],text[,3],text[,4],text[,5])


text1 <- VCorpus(VectorSource(text))
inspect(text1)
str(text1[[4]])
text1[[4]]$content

# 불필요한 공백 제거
for (i in seq_along(text1)){
  text1[[i]]$content <- paste(text1[[i]]$content, collapse=" ")
}

# 문장 부호 제거
text <- tm_map(text1, removePunctuation)
text[[4]]$content

#숫자 제거
text <- tm_map(text, removeNumbers)
text[[4]]$content

#특수문자 제거
for (i in seq_along(text)){
  text[[i]]$content <- gsub("’", "", text[[i]]$content)
  text[[i]]$content <- gsub("‘", "", text[[i]]$content)
  text[[i]]$content <- gsub("·", " ", text[[i]]$content)
  text[[i]]$content <- gsub("ᆞ", " ", text[[i]]$content)
  text[[i]]$content <- gsub("!", "", text[[i]]$content)
}
text[[4]]$content


# 한글 어근 추출
for (i in seq_along(text)){
  nouns <- extractNoun(text[[i]]$content)
  nouns <- nouns[nchar(nouns) > 1]
  text[[i]]$content <- paste(nouns, collapse=" ")
}
inspect(text)
text[[4]]$content

# 불용어 제거
for (i in seq_along(text)){
  text[[i]]$content <- gsub("동아리","",text[[i]]$content)
  text[[i]]$content <- gsub("대학교","",text[[i]]$content)
  text[[i]]$content <- gsub("사람들","",text[[i]]$content)
  text[[i]]$content <- gsub("목요일","",text[[i]]$content)
  text[[i]]$content <- gsub("화요일","",text[[i]]$content)
  text[[i]]$content <- gsub("있습니","",text[[i]]$content)
  text[[i]]$content <- gsub("프로그램","",text[[i]]$content)
  text[[i]]$content <- gsub("고삐풀린광고단","",text[[i]]$content)
  text[[i]]$content <- gsub("불편함","",text[[i]]$content)
}
text[[4]]$content

text_tdm <- TermDocumentMatrix(text, control=list(tokenize="scan",wordLength=c(2,Inf))) # 단어 길이 2 이상
inspect(text_tdm)

#wordfreq
wordFreq <- slam::row_sums(text_tdm)
wordFreq <- sort(wordFreq, decreasing=TRUE)
wordFreq[1:10]

#barplot
barplot(wordFreq[1:10], las=2, ylim=c(0,max(wordFreq)),main="Frequency of words")

# wordcloud
wordcount <- data.frame(wordFreq)
wordcount["name"] <- rownames(wordcount)
wordcount["freq"] <- wordcount["wordFreq"]
wordcount <- wordcount[1:45,2:3]
wordcount
wordcloud2(data=wordcount,fontFamily = '나눔바른고딕',shape="circle")
'''
