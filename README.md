2021 KU Datathon_CircleLens
================
제 2회 2021 고려대학교 스마트캠퍼스 데이터톤 5조 CircleLens '동아리 추천 시스템' 

***
<h2> #1. 프로젝트 소개 </h2> 

 - Background
 <p>수 많은 동아리 중에서 나에게 딱 맞는 동아리를 찾고 싶다!! </p>
 
 
  	주제 선정 배경 : 고려대학교 학생들을 대상으로 현재 교내 동아리 만족도에 대한 설문조사 수행 
			-결과 1. 학생들은 동아리를 대학생활의 중요한 요소라고 생각하지만 실질적인 만족도는 예상보다 낮고, 학생들의 절반 이상이 적극적으로 활동하지 못한 경험이 있다
			-결과 2. 학생들은 '나에게 맞는 동아리'를 찾지 못해서 동아리 활동에서 만족할 수 없었고, 
			-결과 3. 그 이유는 '동아리에 대한 정보'를 지인이나 학교 커뮤니티 등 단편적인 경로에서 얻기 때문이라고 한다. 
			
			----> 어려운 동아리 박람회 자료보다 더 직관적으로! 
			----> 동아리 이름으로 바로바로 검색해서 찾아볼 수 있도록! 
			----> 중복자료, 특정 분야 동아리만 있는 커뮤니티 홍보게시판보다 더 다양하게! 
			
			"사용자에게 딱 맞는 동아리를 추천해주는 동아리 검색 플랫폼이 필요하다!!"
			
			
 - 프로젝트 목적 및 효과
 	<p>(1) 흩어져 있는 동아리에 대한 정보를 수집하여 하나의 플랫폼으로 정리한다.</p>
	<p>(2) 원하는 동아리 탐색을 빠르게 할 수 있도록 돕는다.</p>
	<p>(3) 평점, 동아리 특성 등 사용자 개인의 선호에 맞는 동아리를 추천한다.</p>
	

- 프로젝트의 주요 기능
	<p>(1) 동아리 탐색 기능<br/>
		- 키워드를 이용한 동아리 탐색 <br/>
		- 검색 시 동아리 키워드 기반 유사 동아리 추천(Contents-based Recommendation <br/>
		- 검색 시 동아리 선호도 기반 유사 동아리 추천(Item-based Collaborative Filtering)<br/>
		- 키워드별 2021 고려대학교 동아리 트랜드</p>
	
	<p>(2) 사용자 개인 맞춤 추천 기능 <br/>
		- 사용자 선호도 기반 동아리 추천(Latent Factor Collaborative Filtering) <br/>
		- 개인 특성 & 동아리 정보 기반 동아리 추천(머신러닝 분류 알고리즘) </p>

- ## 사용한 분석 기법

```
📈  추천시스템 : Contents-based Filtering , Item-based Collaborative Filtering, Latent Factor Collaborative Filtering(SVD, SVD++, NMF)를 사용했습니다.
🌏  Wordcloud : 메타 데이터에서 얻어진 태그들을 분석하여 중요도나 인기도 등을 고려하여 시각적으로 늘어 놓는 기법입니다.
🔍  머신러닝 분류 알고리즘 : 로지스틱회귀, 의사결정나무, KNN분류, 앙상블모델 사용 특히 Catboost 모델로 분류합니다.
⏰  ANOVA : 3개 이상의 다수의 집단을 비교할 때 사용하는 분산분석으로, 동아리 분과별 속성 평균 차이 비교를 할 때 사용하였습니다. 
🐼  Pandas : 파이썬의 대표적인 데이터 분석 도구로 데이터 분석을 위해 만들어 졌습니다.
🧮  Numpy : 파이썬의 수치계산 도구 입니다.
📊  matplotlib : 파이썬의 대표적인 데이터 시각화 도구 입니다.
📊  seaborn : matplotlib 을 사용하기 쉽게 추상화 해 놓은 고수준 시각화 도구로 기본 통계 연산을 제공합니다.
📊  plotly : 고수준, 저수준 시각화 기능을 제공하며 인터랙티브한 시각화가 가능합니다.
📊  cufflinks : plotly와 pandas를 강력하게 이어주는 생산적인 도구 입니다.

```
	

*보러가기: [프로토타입 구현 결과](https://github.com/hbkimhbkim/Portfolio_ML/blob/master/bankchurn/)*
      
***
<h2> #2. 데이터 수집 과정 및 EDA </h2>



- Summary

  	<p>(1) 동아리 탐색 키워드 데이터 <br/>
	   - 수집 출처 : 2021 고려대학교 중앙동아리 소개집<br/>

![image](https://user-images.githubusercontent.com/76843676/129167795-65395fbb-4d51-4939-b9b0-16dd5e4730ee.png)
	   
      * 매출 추정 과정<br/>
          프로세스 : 상권설정 --> 상권정보 추출, 입력 --> 매출, 수익성 분석 --> 우량입지 추출 / 관리

          주요 상권 정보 변수들 : 경쟁자 매출, 잠재 고객 분석-세대수, 세대특성, 거주 형태, 소비지출형태, 유동인구
                                대중교통, 횡단보도등 접근성(접근성, 가시성), 기타 주변환경

          모델링 : 1. 기본모델 - 고객수 x 객단가 = 매출(매장 앞 유동 인구 수 중 매장 방문/구매 고객의 비율)
                              - 시장규모 x 시장 점유율 = 매출
                  2. 회귀 모형 모델 - 과거 데이터가 있는 경우 적용 가능(인구 밀집 or 상권 밀집, 또는 소득 등에 따라서
                    지역을 그룹화한 후 각각의 그룹에 맞는 모형을 선택하여 추정)

     - BLD 모형
     
      * 푸드트럭 특화 모형<br/>
          영업장소 특성을 반영하여 아침, 점심, 저녁에 따른 이동 영업<br/>
          아침 : 1인 가구 / 점심 : 서울시 특화 산업단지 / 저녁 : 전통 재래시장

  	<p>(5). Review <br/>
    	- 매출 데이터가 없어서 정확한 모형을 만들기 어려움

*보러가기: [푸드트럭 위치추천](https://github.com/hbkimhbkim/Portfolio_ML/tree/master/foodtruck)*

***
<h2> #3. Project - 감자과자 시장분석</h2>

- Background
 <p>Text Mining(크롤링, 상관분석, 연관규칙...) --> 감자과자 시장분석</p>

- Summary

	<p>(1). Data Collection</br>
    	- 수집대상 : 오리온-포카칩 / 농심-수미칩 / 해테 - 허니버터칩 / 롯데 - 레이즈 감자칩 / PB-이마트 노브랜드 감자칩 <br/> 
    	- 수집 방법 : R을 통한 크롤링<br/>
    	- 수집 출처 : 네이버 블로그, 트위터, 페이스북</p>
    
	<p>(2). Data Preprocessing <br/>
    	- 형태소 저장 <br/>
    	- 불필요한 단어 제거 </p>
    
  	<p>(3). Model & Algorithms <br/>
	- Wordcloud : 빈도분석의 시각화를 위해<br>
    	- 상관관계 : network graph를 통해 시각화<br>
    	- graphical lasso : 추가 변수의 효과를 제어하고, 두 변수간  의 효과를 알기 위해 사용 <br>
    	- 연관규칙 : support, confidence, lift(by apriori 알고리즘)<br>
    	- 시계열 분석 : 검색 추세 분석
    
  	<p>(4). Report
    	- jupyter notebook with R로 작성

  	<p>(5). Review <br/>
    	- Feedback : 크롤링, 연관규칙, 가우시안 그래프 모델 등 다양한 분석방법을 활용할 수 있어서 좋았다 <br/>
    	- Futuer Research : 코드가 깔끔하지 않고, 명확한 결론을 내리지 못했다. 감성사전을 통해 감성분석을 하는게 필요해보인다.
		
*보러가기: [감자과자시장분석](https://github.com/hbkimhbkim/Portfolio_ML/tree/master/potatosnack)*

***
<h2> #4. Project - 2018 러시아 월드컵 결과 예측</h2>

- Background
 <p>Kaggle Predicting the winner of the 2018 FIFA World Cup 참고하여 진행</p>

- Summary

	<p>(1). Data Collection</br>
    	- 수집대상 : 피파랭킹 / 공식경기기록 / 월드컵  <br/> 
	- 수집 출처 : kaggle</p>
    
	<p>(2). Data Preprocessing <br/>
    	- 형태소 저장 <br/>
    	- 불필요한 단어 제거 </p>
    
  	<p>(3). Model & Algorithms <br/>
	- Wordcloud : 빈도분석의 시각화를 위해<br>
    	- 상관관계 : network graph를 통해 시각화<br>
    	- graphical lasso : 추가 변수의 효과를 제어하고, 두 변수간  의 효과를 알기 위해 사용 <br>
    	- 연관규칙 : support, confidence, lift(by apriori 알고리즘)<br>
    	- 시계열 분석 : 검색 추세 분석
    
  	<p>(4). Report
    	- jupyter notebook with R로 작성

  	<p>(5). Review <br/>
    	- Feedback : 크롤링, 연관규칙, 가우시안 그래프 모델 등 다양한 분석방법을 활용할 수 있어서 좋았다 <br/>
    	- Futuer Research : 코드가 깔끔하지 않고, 명확한 결론을 내리지 못했다. 감성사전을 통해 감성분석을 하는게 필요해보인다.
		
*보러가기: [감자과자시장분석](https://github.com/hbkimhbkim/Portfolio_ML/tree/master/potatosnack)*
