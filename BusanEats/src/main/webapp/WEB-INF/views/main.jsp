<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
		
		.right-section .real-time-section {
		    margin-bottom: 20px; /* 원하는 여백 크기로 조정 */
		}
		
		.header {
            background-color: #ff6600;
            padding: 10px;
            text-align: center;
        }
        .header a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
            font-weight: bold;
        }
        .header a:hover {
            text-decoration: underline;
        }
        
    </style></head><body>
    
    <jsp:include page="common/header.jsp" />
    

    <div class="header">
        <a href="selectStoreList.do?type=한식">한식</a>
        <a href="selectStoreList.do?type=양식">양식/레스토랑</a>
        <a href="selectStoreList.do?type=고기">고기/구이류</a>
        <a href="selectStoreList.do?type=씨푸드">씨푸드</a>
        <a href="selectStoreList.do?type=세계">일/중/세계음식</a>
        <a href="selectStoreList.do?type=카페">카페/디저트</a>
    </div>

    <div class="main">
        <!-- Left Section -->
        <div class="left-section">
            <!-- Map Section -->
            <div class="map-section">
            
            
               <div role="img" class="noresize" style="width: 400px; line-height: 1; text-align: center; background-color: #ffffff; position: relative;">
    <span typeof="mw:File">
            <img alt="부산광역시 행정 지도" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/65/Map_Busan-gwangyeoksi.svg/400px-Map_Busan-gwangyeoksi.svg.png" decoding="async" width="550" height="311" class="mw-file-element" 
                srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/65/Map_Busan-gwangyeoksi.svg/600px-Map_Busan-gwangyeoksi.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/65/Map_Busan-gwangyeoksi.svg/800px-Map_Busan-gwangyeoksi.svg.png 2x" 
                data-file-width="600" data-file-height="466">
    </span>

    <!-- 지도에 표시되는 지역들 -->
    <div style="font-size: 0.75em; line-height: 20px;">
        <div style="position:absolute; text-align:center; left:120px; top:200px"><a href="selectStoreList.do?gugunNm=강서구" title="강서구 (부산광역시)">강서구</a></div>
        <div style="position:absolute; text-align:center; left:180px; top:192px"><a href="selectStoreList.do?gugunNm=사상구" title="사상구">사상구</a></div>
        <div style="position:absolute; text-align:center; left:180px; top:248px"><a href="selectStoreList.do?gugunNm=사하구" title="사하구">사하구</a></div>
        <div style="position:absolute; text-align:center; left:240px; top:188px"><a href="selectStoreList.do?gugunNm=부산진구" title="부산진구">부산진구</a></div>
        <div style="position:absolute; text-align:center; left:240px; top:212px"><a href="selectStoreList.do?gugunNm=동구" title="동구 (부산광역시)">동구</a></div>
        <div style="position:absolute; text-align:center; left:240px; top:232px"><a href="selectStoreList.do?gugunNm=중구" title="중구 (부산광역시)">중구</a></div>
        <div style="position:absolute; text-align:center; left:270px; top:268px"><a href="selectStoreList.do?gugunNm=영도구" title="영도구">영도구</a></div>
        <div style="position:absolute; text-align:center; left:230px; top:139.6px"><a href="selectStoreList.do?gugunNm=북구" title="북구 (부산광역시)">북구</a></div>
        <div style="position:absolute; text-align:center; left:300.6px; top:112.4px"><a href="selectStoreList.do?gugunNm=금정구" title="금정구">금정구</a></div>
        <div style="position:absolute; text-align:center; left:290.6px; top:147.6px"><a href="selectStoreList.do?gugunNm=동래구" title="동래구">동래구</a></div>
        <div style="position:absolute; text-align:center; left:290.6px; top:172.8px"><a href="selectStoreList.do?gugunNm=연제구" title="연제구">연제구</a></div>
        <div style="position:absolute; text-align:center; left:320.6px; top:184.8px"><a href="selectStoreList.do?gugunNm=수영구" title="수영구">수영구</a></div>
        <div style="position:absolute; text-align:center; left:230px; top:248px"><a href="selectStoreList.do?gugunNm=서구" title="서구 (부산광역시)">서구</a></div>
        <div style="position:absolute; text-align:center; left:350.6px; top:164.4px"><a href="selectStoreList.do?gugunNm=해운대구" title="해운대구">해운대구</a></div>
        <div style="position:absolute; text-align:center; left:400px; top:70px"><a href="selectStoreList.do?gugunNm=기장군" title="기장군">기장군</a></div>
        <div style="position:absolute; text-align:center; left:300.6px; top:212.4px"><a href="selectStoreList.do?gugunNm=남구" title="남구 (부산광역시)">남구</a></div>
    </div>
</div> 
                
                
                
            </div>

            <!-- Ranking Section -->
			<div class="ranking-section">
			    <!-- 지역별 메뉴 바 -->
			    <div class="region-menu">
			        <ul class="region-links">
			            <li><a href="#" class="region-link" data-region="강서구">강서구</a></li>
			            <li><a href="#" class="region-link" data-region="사상구">사상구</a></li>
			            <li><a href="#" class="region-link" data-region="사하구">사하구</a></li>
			            <li><a href="#" class="region-link" data-region="부산진구">부산진구</a></li>
			            <li><a href="#" class="region-link" data-region="동구">동구</a></li>
			            <li><a href="#" class="region-link" data-region="중구">중구</a></li>
			            <li><a href="#" class="region-link" data-region="영도구">영도구</a></li>
			            <li><a href="#" class="region-link" data-region="북구">북구</a></li>
			            <li><a href="#" class="region-link" data-region="금정구">금정구</a></li>
			            <li><a href="#" class="region-link" data-region="동래구">동래구</a></li>
			            <li><a href="#" class="region-link" data-region="연제구">연제구</a></li>
			            <li><a href="#" class="region-link" data-region="수영구">수영구</a></li>
			            <li><a href="#" class="region-link" data-region="서구">서구</a></li>
			            <li><a href="#" class="region-link" data-region="해운대구">해운대구</a></li>
			            <li><a href="#" class="region-link" data-region="남구">남구</a></li>
			            <li><a href="#" class="region-link" data-region="기장군">기장군</a></li>
			        </ul>
			    </div>
			
			    <h2><a class="gugunNm"></a> 실시간 맛집 TOP5</h2>
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
        <!-- 최근 본 식당 목록을 쿠키에서 읽어오기 -->
		<c:set var="storeList" value="${storeList}" />
		
		<!-- JSTL을 사용하여 Store 리스트 출력 -->

        
        <div class="right-section">
            <div class="real-time-section">
                <h2>최근 본 식당</h2>
               
                <c:if test="${not empty storeList}">
				    <ul class="store-list">
				        <c:forEach items="${storeList}" var="store">
				            <li class="real-time-item" data-ucseq="${store.ucSeq}"
				                     data-url="<c:url value='/selectStoreDetail.do'/>">
				                
				                    <img src="${store.mainImgThumb}" alt="${store.mainTitle}" />
				                    <div>
				                        <h3>${store.mainTitle}</h3>
				                        <p>주소: ${store.addr1}</p>
				                    </div>
				            </li>
				        </c:forEach>
				    </ul>
				</c:if>
                
            </div>
        </div>
    </div>

</body>
<script>
    $(document).ready(function() {
    	
    	
    	 $.ajax({ //****** 여기서 리스트 받아와서!!!!!!!!!!!!
             url: 'selectRegionTop5.do', // 서버의 엔드포인트
             type: 'POST',
             data:{ region: '강서구' }, // 서버로 보낼 데이터
             dataType: 'json',
             success: function(response) {
                 // 서버로부터 받은 데이터를 처리
                 $('.gugunNm').text('깅서구');
                 updateRankingList(response); // 순위 리스트 업데이트 함수 호출
             },
             error: function(error) {
                 console.error('Error fetching data', error);
             }
         });
    	
    	
    	
    	
    	
        //최근본 식당 클릭시 해당 식당 상세정보
        $('.real-time-item').on('click', function() {
            var baseUrl = $(this).data('url');
            var ucSeq = $(this).data('ucseq');

            var url = baseUrl + '?ucSeq=' + ucSeq;
            window.location.href = url;
        });
        
        
        $('.region-link').click(function(event) { //*********** 여기서 클릭하면!!!!!!!!!!!!!
            event.preventDefault(); // 기본 링크 동작 방지
            
            var region = $(this).data('region'); // 선택한 구 데이터 가져오기
			
            console.log(region);
            // Ajax 요청 보내기
            
            
            $.ajax({ //****** 여기서 리스트 받아와서!!!!!!!!!!!!
                url: 'selectRegionTop5.do', // 서버의 엔드포인트
                type: 'POST',
                data:{ region: region }, // 서버로 보낼 데이터
                dataType: 'json',
                success: function(response) {
                    // 서버로부터 받은 데이터를 처리
                    $('.gugunNm').text(region);
                    updateRankingList(response); // 순위 리스트 업데이트 함수 호출
                },
                error: function(error) {
                    console.error('Error fetching data', error);
                }
            });
            
            
        });
        
     // 동적으로 생성된 .ranking-item에 클릭 이벤트 위임
        $(document).on('click', '.ranking-item', function(event) {
            event.preventDefault(); // 기본 링크 동작 방지
            
            var ucSeq = $(this).data('ucseq');

            // 상세 페이지로 이동
            if (ucSeq) {
                window.location.href = 'selectStoreDetail.do?ucSeq=' + ucSeq;
            } else {
                console.error('ucSeq 값이 없습니다.');
            }
        });
        
       
        function updateRankingList(data) {
            var rankingList = $('.ranking-list');
            rankingList.empty(); // 기존 리스트 제거
            console.log(data);
            
            
            // 데이터가 배열이고 길이가 0보다 클 때만 리스트 업데이트
            if (Array.isArray(data) && data.length > 0) {
                $.each(data, function(index, item) {
                	

                    var rankingItem = `
                        <div class="ranking-item" data-ucSeq="\${item.ucSeq}"> 
                    		<img src="\${item.mainImgNormal}">
                            <h3>\${index + 1}. \${item.mainTitle}</h3>
                        </div>`;
                        
                        
                    rankingList.append(rankingItem);
                });
            } else {
                rankingList.append('<p>데이터가 없습니다.</p>'); // 데이터가 없을 때 처리
            }
        }
        
        
    });
    
   
    
    
    
</script>


</html>
