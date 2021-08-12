2021 KU Datathon_CircleLens
================
제 2회 2021 고려대학교 스마트캠퍼스 데이터톤 5조 CircleLens '동아리 추천 시스템' 

***
<h2> #1. 프로젝트 소개 </h2> 
 <p>고려대학교 동아리 추천 시스템 개발 프로젝트 </p>
 
 - 주제 선정 배경 
 
```
 고려대학교 학생들을 대상으로 현재 교내 동아리 만족도에 대한 설문조사 수행 
	-결과 1. 학생들은 동아리를 대학생활의 중요한 요소라고 생각하지만 실질적인 만족도는 예상보다 낮고, 학생들의 절반 이상이 적극적으로 활동하지 못한 경험이 있다
	-결과 2. 학생들은 '나에게 맞는 동아리'를 찾지 못해서 동아리 활동에서 만족할 수 없었고, 
	-결과 3. 그 이유는 '동아리에 대한 정보'를 지인이나 학교 커뮤니티 등 단편적인 경로에서 얻기 때문이라고 한다. 
			
	----> 어려운 동아리 박람회 자료보다 더 직관적으로! 
	----> 동아리 이름으로 바로바로 검색해서 찾아볼 수 있도록! 
	----> 중복자료, 특정 분야 동아리만 있는 커뮤니티 홍보게시판보다 더 다양하게! 
```			
	
*"사용자에게 딱 맞는 동아리를 추천해주는 동아리 검색 플랫폼이 필요하다!!"*

			
			
	
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

- 사용한 분석 기법

```
📈  추천시스템 : Contents-based Filtering , Item-based Collaborative Filtering, Latent Factor Collaborative Filtering(SVD, SVD++, NMF)를 사용했습니다.
🌏  텍스트마이닝 : 텍스트에 나타나는 단어를 분해(정제)하고, 특정 단어의 출현빈도, 동시출현 빈도를 파악하여 단어들 간의 관계를 분석하는 방법이며 워드클라우드 형태로 시각화했다.
🔍  머신러닝 분류 알고리즘 : 로지스틱회귀, 의사결정나무, KNN분류, 앙상블모델 사용 특히 Catboost 모델로 분류합니다.
⏰  ANOVA : 3개 이상의 다수의 집단을 비교할 때 사용하는 분산분석으로, 동아리 분과별 속성 평균 차이 비교를 할 때 사용하였습니다. 
🐼  Pandas : 파이썬의 대표적인 데이터 분석 도구로 데이터 분석을 위해 만들어 졌습니다.
🧮  Numpy : 파이썬의 수치계산 도구 입니다.
📊  matplotlib : 파이썬의 대표적인 데이터 시각화 도구 입니다.
📊  seaborn : matplotlib 을 사용하기 쉽게 추상화 해 놓은 고수준 시각화 도구로 기본 통계 연산을 제공합니다.
📊  plotly : 고수준, 저수준 시각화 기능을 제공하며 인터랙티브한 시각화가 가능합니다.
📊  Visual Studio Code: 프로젝트의 프로토타입 구현을 위한 웹 개발 도구입니다. 

```
	

*보러가기: [웹 프로토타입](https://github.com/hbkimhbkim/Portfolio_ML/blob/master/bankchurn/)*
      
***

<h2> #2. 데이터 수집 과정 및 EDA </h2>

- Background
 <p> 동아리 연합회와의 협업으로 데이터수집, Text Mining, ANOVA, python 데이터 시각화 --> 전처리 및 EDA 진행 </p> <br/>
 
*보러가기: [사용한 데이터](https://github.com/chaehyeon99/Datathon/blob/main/%EC%82%AC%EC%9A%A9%ED%95%9C%20%EB%8D%B0%EC%9D%B4%ED%84%B0/)*

- Summary


  	<p>(1) 동아리 탐색 키워드 데이터 <br/>
	   - 수집 출처 : 2021 고려대학교 중앙동아리 소개집 <br/>
	   - 키워드를 이용한 동아리 탐색기능, 검색 시 동아리 키워드 기반 유사동아리 추천 알고리즘에 사용<br/>
	   
	   - 파일명 : 동아리 정보 DB (가상).xlsx 

	<p>(2) 동아리 선호 평점 데이터 <br/>
	   - 수집 출처 : 직접 입력<br/>
	   - 사용자 동아리 선호도 기반 동아리 추천에 사용 <br/>	
	   
	   - 파일명 : ratings.csv	

	<p>(3) 동아리 특징 설문 데이터 <br/>
	   - 수집 출처 : 고려대학교 동아리 연합회 협업 -> 각 분과 대표자들을 통해 설문조사 시행<br/>
	   - 개인 특성 & 동아리 정보 기반 동아리 추천(머신러닝 분류 알고리즘), 동아리 특성 시각화에 사용<br/>
	[EDA 및 시각화 code](https://github.com/chaehyeon99/Datathon/blob/main/Code/%EC%84%A4%EB%AC%B8%EC%A1%B0%EC%82%AC%20%EB%8D%B0%EC%9D%B4%ED%84%B0%20EDA.ipynb/) <br/>
	
	   - 파일명 : practice.csv practice2.csv practice3.csv 
		
		
	<p>(4) 2021 KU 중앙동아리 소개집 원본 데이터 <br/>
	   - 수집 출처 : 고려대학교 동아리 연합회 제공 <br/>
	   - NLP 및 텍스트 마이닝에 사용 <br/>
	   
	   - 파일명 : 동아리 소개책자 정보 수합.csv	




		

***
<h2> #3. 아이디어 구현 및 결과 </h2>

- Background
 <p>  1. Contents-based Filtering과 Item-based Collaborative Filtering을 이용한 검색 시 유사 동아리 추천  <br/>
 2. Text Mining, NLP, wordcloud  <br/>
 3. SVD, SVD++, NMF(Non-negative Matrix Factorizagion) <br/>
 4. Logistic Regression, Decision Tree, KNN , Weighted KNN , Random Forest ,Boosting 계열 모델(gbm, adaboost, lightbm, catboost) <br/>
 </p> 
 *보러가기: [Code](https://github.com/chaehyeon99/Datathon/tree/main/Code)*
 
 
- Summary

	<p>(1) 키워드를 이용한 동아리 탐색</br>
    	- SQL : 쿼리문을 이용하여 키워드에 속하는 동아리 선택적 출력</p>
    
	<p>(2) 검색 시 동아리 키워드 기반 유사 동아리 추천 <br/>
    	- 키워드 indicator 변수를 통해 동아리 간 코사인 유사도를 구함  <br/>
    	- 높은 유사도를 가지는 상위 5개의 동아리 출력 및 저장 <br/>
	
	- 파일명 : contents-based.ipynb <br/></p>
    
  	<p>(3) 검색 시 동아리 선호도 기반 유사 동아리 추천 (동아리 기준) <br/>
	<img width="824" alt="추천" src="https://user-images.githubusercontent.com/76843676/129180254-1d2cb572-e1a9-4c7d-a080-78a61daaaf6b.PNG"> <br/>
    	- 협업필터링 추천 알고리즘 : 기존 사용자의 행동 정보를 분석하여, 해당 사용자와 비슷한 성향의 사용자들이 기존에 좋아했던 항목을 추천<br/>
    	- 고객 기반 vs 아이템기반 : 고객기반 협업 필터링은 메모리 사용이 크고, 타 모델보다 낮은 정확도를 가졌기 때문에 추천 모델에서 제외함(일반적으로 비슷한 고객보다 아이템을 토대로 추천하는 것이 정확도가 높기 때문)<br/>
    	- 기존 평점 데이터를 행-동아리명 , 열 - 사용자, 데이터 - 평점 값 을 가지는 데이터셋으로 변환<br/>
    	- 사용자가 평점을 매긴 데이터를 토대로 동아리간 코사인 유사도 계산 후 가장 높은 동아리 출력 및 저장 <br/>
	- Contents-based Filtering과 Item-based Collaborative Filtering을 검색 시 동아리 추천에 함께 사용한 이유 <br/>
	---> Collaborative Filtering만을 사용할 경우, cold start 문제 (평점이 없을 경우 추천이 어려움), long-tail 문제(인기 있는 동아리에 대해서만 추천하는 경향이 있음) 등이 발생할 수 있기 때문에 hybrid 추천시스템과 같이 두 추천시스템 결과를 모두 보여주도록 함<br/>
	
	- 파일명 : Collaborative_Filtering.ipynb  </p>

  	<p>(4) 키워드별 2021 KU 동아리 트랜드 <br/>
  	<img width="779" alt="new" src="https://user-images.githubusercontent.com/76843676/129189423-3bb03cf6-e342-4499-bd47-57d467ec8281.PNG"> <br/>
  	- Text Mining : [R] tm 패키지 사용하여 동아리 텍스트 정보-> PlainTextDocument 리스트 구조로 변환 <br/>
	-[R] KoLNP 패키지를 사용하여 한글 어근 추출, 불용어제거, 단어문서행렬처리 <br/>
	- barplot, wordcloud 이용하여 시각화 진행  <br/>
	
	- 파일명 : LogReg.R , anova.R , textmining.R  </p>

  	<p>(5) 사용자 선호도 기반 동아리 추천 <br/>
	<img width="779" alt="new" src="https://user-images.githubusercontent.com/76843676/129188373-33be9e87-6111-4921-9d7d-7b57961a0d0a.PNG"><br/>
  	- 사용한 잠재요인 기반 모델  <br/>
   	1. SVD : 동아리-사용자 평점 행렬을 분해하여 구한 Latent Factor을 통해 사용자가 평점을 내리지 않은 동아리의 평점을 예측한다<br/>
   	2. SVD ++ : SVD에 implicit feedback 까지 반영<br/>
   	3. NMF(Non-negative Matrix Factorizagion) : 행렬 분해시, 음수를 포함하지 않는 행렬이 되지 않도록 함. <br/>
  	-단순 회귀 앙상블 추천 시스템이 각 유저에게 가장 개인화된 경험을 제공할 수 있었다<br/>
	
	- 파일명 : Collaborative_Filtering.ipynb  </p>

  	<p>(6) 개인특성 & 동아리 정보 기반 동아리 추천 <br/>
  	- train set 과 test set을 4:1 로 분리 <br/>
  	- Logistic Regression 모델 학습 및 테스트<br/>
  	- Decision Tree 모델 학습 및 테스트 <br/>
  	- KNN 모델 학습 및 테스트<br/>
  	- Weighted KNN 모델 학습 및 테스트 <br/>
  	- Random Forest 모델 학습 및 테스트 <br/>
  	- Boosting 계열 모델(gbm, adaboost, lightbm, catboost)학습 및 테스트<br/>
  	- 최종적으로 catboost 모델 accuracy는 약 0.76으로, 가장 좋은 성능을 보였다<br/>
	
	- 파일명 : 설문조사 분류 코드.ipynb </p>


		


***
<h2> #4. 웹 프로토타입 구현</h2>

- 기대효과 및 발전 가능성 

*보러가기: [웹 프로토타입](https://github.com/hbkimhbkim/Portfolio_ML/tree/master/potatosnack)*
