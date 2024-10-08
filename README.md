# 밥뭇나
공공데이터포털 부산광역시_부산맛집정보 서비스 api 사용 https://www.data.go.kr/data/15063472/openapi.do

## 🖥️ 기획의도

- 부산의 다양한 맛집 정보를 손쉽게 접근할 수 있는 서비스 제공
- 공공데이터를 활용하여 신뢰할 수 있는 맛집 정보 제공 
- 예약 기능을 통해 사용자 편의성 증대
- 1대1 문의 기능으로 사용자와 맛집 간의 소통 창구 마련


## 🗓 개발 기간
24.08.01 - 24.09.12


## 🧑‍🤝‍🧑 제공서비스

- 검색을 통한 식당 찾기
- 구 별로 식당 찾기, 리뷰 좋아요가 많은 인기 식당 찾기
- 카카오/네이버 소셜 로그인
- 최근 본 식당
- 식당과 1대1 채팅으로 문의기능 제공


## ⚙️ 개발 환경
<div align="center">
    <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat-square&logo=Spring&logoColor=white" />
    <img src="https://img.shields.io/badge/Java-007396?style=flat&logo=Java&logoColor=white" />
    <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black" />
    <img src="https://img.shields.io/badge/jQuery-0769AD?style=flat-square&logo=jQuery&logoColor=white" />
    <img src="https://img.shields.io/badge/Ajax-0B76D1?style=flat-square&logo=jquery&logoColor=white" />
    <img src="https://img.shields.io/badge/MyBatis-0D8DBA?style=flat-square&logo=MyBatis&logoColor=white" />
    <img src="https://img.shields.io/badge/ORACLE-F80000?style=flat-square&logo=oracle&logoColor=white" />
    <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=HTML5&logoColor=white" />
    <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=CSS3&logoColor=white" />
    <img src="https://img.shields.io/badge/apache%20tomcat-F8DC75?style=flat-square&logo=apachetomcat&logoColor=white" />
    <img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=GitHub&logoColor=white" />
    <img src="https://img.shields.io/badge/Kakao%20API-FFCD00?style=flat-square&logo=Kakao&logoColor=black" />
    <img src="https://img.shields.io/badge/Naver%20API-03C75A?style=flat-square&logo=Naver&logoColor=white" />
    <img src="https://img.shields.io/badge/Socket.io-010101?style=flat-square&logo=Socket.io&logoColor=white" />
</div>


## DB설계
![image (1)](https://github.com/user-attachments/assets/892d5611-0c2a-4401-bc88-dfc0c6ae62ea) 



<ul>
<h2>메인페이지</h2>
  <li>메뉴바로 음식 카테고리별 식당 조회</li>
  <li>지도를 활용한 구별로 식당 조회</li>
  <li>쿠키를 이용해서 최근 본 식당 구현</li>
  <li>실시간 맛집 - 구별로 좋아요수와 리뷰수가 많은 식당 조회</li>
</ul>

![image](https://github.com/user-attachments/assets/8de7a064-99d5-48e6-927b-27b88b453d03)

<ul>
<h2>로그인 화면</h2>
  <li>카카오, 네이버 소셜로그인 구현</li>
  <li>쿠키를 이용해서 ID저장 기능 구현</li>
  <li>일반 회원과 식당 회원 로그인 분리</li>
</ul>

![image (2)](https://github.com/user-attachments/assets/11b58dbd-1621-47c7-b5e1-0df1487c317d)



<ul>
<h2>식당리스트 화면</h2>
  <li>해당 매장에 평점, 메뉴, 조회수, 좋아요, 리뷰수를 볼 수 있음</li>
  <li>좋아요 기능을 구현</li>
  <li>모달로 지역을 선택하여 조회 할 수 있음</li>
  <li>리뷰 수, 좋아요 수, 조회 수로 정렬 순서 변경 가능</li>
</ul>

![image (3)](https://github.com/user-attachments/assets/91d1c18b-1649-4f72-a97c-b2f411c7de0a)
![image (4)](https://github.com/user-attachments/assets/027184ce-dcad-41ad-9d57-b36b86e39795)




<ul>
<h2>매장 상세 정보 화면</h2>
  <li>매장 상세 정보 조회</li>
  <li>해당 매장에 남겨진 리뷰 조회</li>
  <li>해당 매장 리뷰 작성, 리뷰 수정</li>
  <li>모달로 예약 기능 구현</li>
  <li>1:1 문의 클릭시 소켓 활용한 채팅 문의 기능 구현</li>
</ul>

![image (5)](https://github.com/user-attachments/assets/ae225cb8-4db4-4714-bea3-634fd32eff04) 
![image (6)](https://github.com/user-attachments/assets/ca65a1f4-eaa9-43d9-bfda-2bba9363e6f4) 
![image (7)](https://github.com/user-attachments/assets/3701be84-3aa8-43ed-9ea3-8d33ab875e28) 
![image (8)](https://github.com/user-attachments/assets/dba2ceb1-3098-4b25-9e40-e996bb12205f) 
![image (9)](https://github.com/user-attachments/assets/53fe9962-665c-4923-8aca-95710482adfe)  


<ul>
<h2>마이페이지 화면</h2>
  <li>좋아요한 식당, 내가 남긴 리뷰, 예약 내역 조회</li>
  <li>회원정보 수정</li>
</ul>

![image (10)](https://github.com/user-attachments/assets/b8810ff6-e627-4ce9-a4a9-5142a31e41c5)
![image (11)](https://github.com/user-attachments/assets/16a772ae-0c1f-4aa1-a105-13b4706af2bf)
![image (12)](https://github.com/user-attachments/assets/d03cf1d6-267d-4504-85d5-9f7e5bda0886)
![image (13)](https://github.com/user-attachments/assets/a0bb4e18-185c-42cc-ab43-f5ab71277da7)
![image (14)](https://github.com/user-attachments/assets/dc347fdb-a6e1-4af6-9763-aa1e13083f7d)

<ul>
<h2>채팅 기능</h2>
  <li>채팅이 왔을 시 헤더바에 표시되도록 구현</li>
  <li>채팅리스트와 안 읽은 메시지 표시</li>
</ul>

![image (15)](https://github.com/user-attachments/assets/15a21200-5d58-468e-9c42-5aab364ff78c)
![image (16)](https://github.com/user-attachments/assets/1f3f733e-62d0-406f-bfe0-7b4a3d55254f)
![image (17)](https://github.com/user-attachments/assets/f751fc3e-ddf7-40a8-acf5-7972b705ad52)


<ul>
<h2>식당 회원 페이지</h2>
  <li>본인 매장 정보 조회</li>
  <li>새로운 채팅이 오면 안읽은 메시지 수가 표시됨, 클릭하면 채팅리스트가 보암</li>

</ul>

![image (18)](https://github.com/user-attachments/assets/7ae7a8e6-a880-407a-a3aa-16a83bb40a10)
![image (19)](https://github.com/user-attachments/assets/d70f5117-b841-46ef-8018-bed4e5f04571)
