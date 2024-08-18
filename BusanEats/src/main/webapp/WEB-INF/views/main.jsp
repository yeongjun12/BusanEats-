<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="ko"><head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .header {
            background-color: #ffffff;
            padding: 10px 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #4caf50;
        }
        .header .menu {
            display: flex;
            gap: 15px;
        }
        .header .menu a {
            color: #333;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 15px;
            background-color: #00a8ff;
            color: white;
            border-radius: 5px;
        }
        .header .menu a:hover {
            background-color: #008ae6;
        }
        .header .auth {
            color: #333;
        }
        .main {
            display: flex;
            flex-wrap: wrap;
            margin: 20px auto;
            width: 90%;
            max-width: 1200px;
        }
        .left-section {
            flex: 1;
            margin-right: 20px;
        }
        .map-section {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .map {
            width: 100%;
            height: auto;
            margin-bottom: 10px;
        }
        .weather-menu-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-top: 20px;
        }
        .weather {
            flex: 1;
            margin-right: 20px;
        }
        .weather-info {
            font-size: 24px;
            font-weight: bold;
            color: #ff7e00;
        }
        .menu-recommendation {
            flex: 1;
        }
        .menu-recommendation h3 {
            margin-bottom: 10px;
        }
        .menu-recommendation ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .menu-recommendation ul li {
            margin-bottom: 5px;
        }
        .ranking-section {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .ranking-section h2 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .ranking-list {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        .ranking-item {
            background-color: #f5f5f5;
            width: 23%;
            padding: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .ranking-item img {
            width: 100%;
            height: 100px;
            object-fit: cover;
            margin-bottom: 10px;
        }
        .ranking-item h3 {
            font-size: 16px;
            margin-bottom: 5px;
        }
        .right-section {
            width: 300px;
        }
        .real-time-section {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .real-time-section h2 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .real-time-item {
            display: flex;
            margin-bottom: 10px;
        }
        .real-time-item img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            margin-right: 10px;
            border-radius: 5px;
        }
        .real-time-item h3 {
            font-size: 16px;
            margin: 0;
            color: #333;
        }
        .real-time-item p {
            font-size: 12px;
            margin: 0;
            color: #999;
        }
        .ranking-section {
		    background-color: #fff;
		    padding: 20px;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}
		
		.region-menu {
		    margin-bottom: 20px;
		}
		
		.region-links {
		     list-style: none;
		     padding: 0;
		     margin: 0;
		     display: flex;
		     flex-wrap: wrap; /* 항목을 여러 줄로 배치 */
		     gap: 10px; /* 항목 간의 간격 조정 */
		} 
		
		.region-links li {
		    margin: 0;
		}
		
		.region-links a {
		    color: #333;
		    text-decoration: none;
		    font-weight: bold;
		    padding: 8px 12px; /* 패딩 조정 */
		    background-color: #f0f0f0;
		    border-radius: 5px;
		    transition: background-color 0.3s ease;
		    display: block;
		    font-size: 9px; /* 폰트 사이즈를 작게 설정 */
		}
		
		.region-links a:hover {
		    background-color: #ddd;
		}
		
		.ranking-list {
		    display: flex;
		    flex-wrap: wrap;
		    gap: 15px;
		}
		
		.ranking-item {
		    background-color: #f5f5f5;
		    width: 23%;
		    padding: 10px;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    text-align: center;
		}
		
		.ranking-item img {
		    width: 100%;
		    height: 100px;
		    object-fit: cover;
		    margin-bottom: 10px;
		}
		
		.ranking-item h3 {
		    font-size: 16px;
		    margin-bottom: 5px;
		}
		
		.ranking-item p {
		    font-size: 14px;
		    color: #777;
		}
        
    </style></head><body>
    
    <jsp:include page="common/header.jsp" />
    

    <div class="header">
        <div class="menu">
            <a href="#">홈</a>
            <a href="#">지역별 랭킹</a>
            <a href="#">맛집 찾기</a>
            <a href="#">TEST</a>
        </div>
    </div>

    <div class="main">
        <!-- Left Section -->
        <div class="left-section">
            <!-- Map Section -->
            <div class="map-section">
            
            
               <div role="img" class="noresize" style="width: 400px; line-height: 1; text-align: center; background-color: #ffffff; position: relative;">
    <span typeof="mw:File">
        <a href="https://commons.wikimedia.org/wiki/File:Map_Busan-gwangyeoksi.svg" class="mw-file-description">
            <img alt="부산광역시 행정 지도" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/65/Map_Busan-gwangyeoksi.svg/400px-Map_Busan-gwangyeoksi.svg.png" decoding="async" width="400" height="311" class="mw-file-element" 
                srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/65/Map_Busan-gwangyeoksi.svg/600px-Map_Busan-gwangyeoksi.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/65/Map_Busan-gwangyeoksi.svg/800px-Map_Busan-gwangyeoksi.svg.png 2x" 
                data-file-width="600" data-file-height="466">
        </a>
    </span>

    <!-- 지도에 표시되는 지역들 -->
    <div style="font-size: 0.75em; line-height: 20px;">
        <div style="position:absolute; text-align:center; left:82px; top:192px"><a href="selectStoreList.do?gugunNm=강서구" title="강서구 (부산광역시)">강서구</a></div>
        <div style="position:absolute; text-align:center; left:134px; top:192px"><a href="selectStoreList.do?gugunNm=사상구" title="사상구">사상구</a></div>
        <div style="position:absolute; text-align:center; left:122px; top:248px"><a href="selectStoreList.do?gugunNm=사하구" title="사하구">사하구</a></div>
        <div style="position:absolute; text-align:center; left:174px; top:188px"><a href="selectStoreList.do?gugunNm=부산진구" title="부산진구">부산진구</a></div>
        <div style="position:absolute; text-align:center; left:182px; top:212px"><a href="selectStoreList.do?gugunNm=동구" title="동구 (부산광역시)">동구</a></div>
        <div style="position:absolute; text-align:center; left:174px; top:232px"><a href="selectStoreList.do?gugunNm=중구" title="중구 (부산광역시)">중구</a></div>
        <div style="position:absolute; text-align:center; left:190px; top:268px"><a href="selectStoreList.do?gugunNm=영도구" title="영도구">영도구</a></div>
        <div style="position:absolute; text-align:center; left:160px; top:139.6px"><a href="selectStoreList.do?gugunNm=북구" title="북구 (부산광역시)">북구</a></div>
        <div style="position:absolute; text-align:center; left:209.6px; top:112.4px"><a href="selectStoreList.do?gugunNm=금정구" title="금정구">금정구</a></div>
        <div style="position:absolute; text-align:center; left:201.6px; top:147.6px"><a href="selectStoreList.do?gugunNm=동래구" title="동래구">동래구</a></div>
        <div style="position:absolute; text-align:center; left:209.6px; top:172.8px"><a href="selectStoreList.do?gugunNm=연제구" title="연제구">연제구</a></div>
        <div style="position:absolute; text-align:center; left:233.6px; top:184.8px"><a href="selectStoreList.do?gugunNm=수영구" title="수영구">수영구</a></div>
        <div style="position:absolute; text-align:center; left:160px; top:248px"><a href="selectStoreList.do?gugunNm=서구" title="서구 (부산광역시)">서구</a></div>
        <div style="position:absolute; text-align:center; left:261.6px; top:164.4px"><a href="selectStoreList.do?gugunNm=해운대구" title="해운대구">해운대구</a></div>
        <div style="position:absolute; text-align:center; left:221.6px; top:212.4px"><a href="selectStoreList.do?gugunNm=남구" title="남구 (부산광역시)">남구</a></div>
        <div style="position:absolute; text-align:center; left:293.6px; top:76.4px"><a href="selectStoreList.do?gugunNm=기장군" title="기장군">기장군</a></div>
    </div>
</div> 
                
                
                <div class="weather-menu-container">
                    <div class="weather">
                        <div class="location">강원도 강릉시 강남동</div>
                        <div class="weather-info">
                            <div>월요일</div>
                            <div>6°C</div>
                        </div>
                    </div>
                    <div class="menu-recommendation">
                        <h3>현재 날씨에 따른 메뉴 추천</h3>
                        <ul>
                            <li>1. 마라탕</li>
                            <li>2. 파전</li>
                            <li>3. 막걸리</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Ranking Section -->
			<div class="ranking-section">
			    <!-- 지역별 메뉴 바 -->
			    <div class="region-menu">
			        <ul class="region-links">
			            <li><a href="#">강서구</a></li>
			            <li><a href="#">사상구</a></li>
			            <li><a href="#">사하구</a></li>
			            <li><a href="#">부산진구</a></li>
			            <li><a href="#">동구</a></li>
			            <li><a href="#">중구</a></li>
			            <li><a href="#">영도구</a></li>
			            <li><a href="#">북구</a></li>
			            <li><a href="#">금정구</a></li>
			            <li><a href="#">동래구</a></li>
			            <li><a href="#">연제구</a></li>
			            <li><a href="#">수영구</a></li>
			            <li><a href="#">서구</a></li>
			            <li><a href="#">해운대구</a></li>
			            <li><a href="#">남구</a></li>
			            <li><a href="#">기장군</a></li>
			        </ul>
			    </div>
			
			    <h2>지역별 실시간 맛집 TOP5</h2>
			    <div class="ranking-list">
			        <div class="ranking-item">
			            <img src="top1.jpg" alt="Top 1">
			            <h3>와와라 가문순정</h3>
			            <p>4.0 / 강원도 신사동</p>
			        </div>
			        <div class="ranking-item">
			            <img src="top2.jpg" alt="Top 2">
			            <h3>쾌뚜드브치</h3>
			            <p>4.5 / 강원도 신사동</p>
			        </div>
			        <div class="ranking-item">
			            <img src="top3.jpg" alt="Top 3">
			            <h3>안향신</h3>
			            <p>4.2 / 강원도 강릉</p>
			        </div>
			        <div class="ranking-item">
			            <img src="top4.jpg" alt="Top 4">
			            <h3>캐나다토스트</h3>
			            <p>4.7 / 강원도 신사동</p>
			        </div>
			        <div class="ranking-item">
			            <img src="top5.jpg" alt="Top 5">
			            <h3>구스태그</h3>
			            <p>4.3 / 강원도 신사동</p>
			        </div>
			    </div>
			</div>
            
        </div>

        <!-- Right Section -->
        <div class="right-section">
            <div class="real-time-section">
                <h2>실시간 맛집 평가</h2>
                <div class="real-time-item">
                    <img src="review1.jpg" alt="Review 1">
                    <div>
                        <h3>속초물회 1호점</h3>
                        <p>더운 여름에 좋습니다!</p>
                    </div>
                </div>
                <div class="real-time-item">
                    <img src="review2.jpg" alt="Review 2">
                    <div>
                        <h3>외국</h3>
                        <p>해외음식점이라니, 정말 놀랍습니다.</p>
                    </div>
                </div>
                <div class="real-time-item">
                    <img src="review3.jpg" alt="Review 3">
                    <div>
                        <h3>밀양한우</h3>
                        <p>이곳은 소고기가 최고입니다.</p>
                    </div>
                </div>
                <div class="real-time-item">
                    <img src="review4.jpg" alt="Review 4">
                    <div>
                        <h3>후미애</h3>
                        <p>산책하기에 아주 좋습니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body></html>
