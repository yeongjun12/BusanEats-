<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .header {
            display: flex;
            align-items: center;
        }
        .header-left {
            display: flex;
            align-items: center;
            margin-right: 15px;
        }
        .header-left img {
            border-radius: 50%;
            margin-right: 10px;
        }
        .title-container {
            display: flex;
            align-items: center;
        }
        .title {
            font-size: 1.8em;
            font-weight: bold;
            margin-right: 10px;
        }
        .rating {
            font-size: 1.5em;
            color: #ff6600;
            margin-right: 10px;
        }
        .tag {
            background-color: #ff3333;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9em;
            margin-right: 5px;
        }
        .stats {
            display: flex;
            align-items: center;
            font-size: 0.9em;
            color: #555;
            margin: 5px 0;
        }
        .stats span {
            margin-right: 15px;
            display: flex;
            align-items: center;
        }
        .stats span i {
            margin-right: 5px;
        }
        .location {
            font-size: 1em;
            color: #007bff;
            margin-top: 10px;
        }
        .navigation {
            margin: 20px 0;
            background-color: #ff6600;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
        .navigation a {
            color: white;
            margin: 0 10px;
            text-decoration: none;
            font-weight: bold;
        }
        .content {
            margin-top: 20px;
        }
        .content h2 {
            font-size: 1.2em;
            margin-bottom: 10px;
            border-bottom: 2px solid #ff6600;
            padding-bottom: 5px;
        }
        .store-intro, .store-info {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
        }
        .store-info {
            display: flex;
            justify-content: space-between;
        }
        .store-info-left {
            flex: 1;
            margin-right: 20px;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 5px;
        }
        .store-info-left p {
            margin: 5px 0;
        }
        .map {
            flex: 1;
            min-width: 300px;
            height: 200px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #e0e0e0;
        }
        .review-section {
            margin-top: 20px;
        }
        .review-section h3 {
            font-size: 1.1em;
            margin-bottom: 10px;
        }
        .review-form {
            display: none;
            margin-bottom: 20px;
        }
        .review-form textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }
        .review-form .rating {
            font-size: 1.5em;
            color: #ff6600;
            margin-bottom: 10px;
        }
        .review-form .submit-btn {
            background-color: #ff6600;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .review-list {
            margin-top: 20px;
        }
        .review-list .review-item {
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }
        .review-list .review-item:last-child {
            border-bottom: none;
        }
        .review-list .review-item .rating {
            color: #ff6600;
            font-weight: bold;
        }
        .review-toggle {
            cursor: pointer;
            color: #ff6600;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <div class="header">
        <div class="header-left">
            <img src="${requestScope.s.mainImgThumb }" alt="Restaurant Logo" width="80" height="80">
        </div>
        <div>
            <div class="title-container">
                <div class="title">${requestScope.s.mainTitle }</div>
                <div class="rating">4.4</div>
                <div class="tag" style="background-color: #ff6600;">HOT</div>
            </div>
            <div class="stats">
                <span><img src="resources/images/bg_ico_s_click.png">&nbsp 78914</span>
                <span><img src="resources/images/bg_ico_s_like.png">&nbsp 200</span>
                <span><img src="resources/images/bg_icon_bookmark2.png" width="11">&nbsp 84</span>
            </div>
        </div>
    </div>

    <div class="navigation">
        <a href="#">홈으로</a>
        <a href="#">메뉴 보기</a>
        <a href="#">리뷰 쓰기</a>
        <a href="#">즐겨찾기</a>
    </div>

    <div class="content">
        <h2>매장소개</h2>
        <div class="store-intro">
            <p>${requestScope.s.itemCntnts }</p>
        </div>

        <h2>매장정보</h2>
        <div class="store-info">
            <div class="store-info-left">
                <p><strong>영업시간:</strong> ${requestScope.s.usageDayWeekAndTime }</p>
                <p><strong>메뉴:</strong> ${requestScope.s.reprsntvMenu }</p>
                <p><strong>주소:</strong> ${requestScope.s.addr1 }</p>
                <p><strong>전화번호:</strong> ${requestScope.s.cntctTel }</p>
            </div>
            <input type="hidden" id="lat" value="${requestScope.s.lat}">
			<input type="hidden" id="lng" value="${requestScope.s.lng}">
            	        <!-- 지도를 표시할 div 입니다 -->
		<div id="map" style="width:50%;height:350px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=baf41b3f50d76c8b3aefa017c15e2227"></script>
		<script>
		
				var mapContainer = document.getElementById('map'); // 지도를 표시할 div
				var lat = $('#lat').val();  // Parse the latitude value to float
				var lng = $('#lng').val();  // Parse the longitude value to float
				
				
				var mapOption = {
				    center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
				    level: 1 // 지도의 확대 레벨
				};
				
				// 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(lat, lng); 
		
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});
		
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
		</script>
        </div>

        <div class="review-section">
            <div class="review-toggle" onclick="toggleReviewForm()">리뷰 작성 ^</div>
            <div class="review-form" id="reviewForm">
                <h3>이 가게를 추천하시겠어요?</h3>
                <div class="rating">★★★☆☆ 3.5</div>
                <textarea rows="5" placeholder="매장에 대한 리뷰를 작성해주세요. (필수)"></textarea>
                <button class="submit-btn">등록</button>
            </div>
            <div class="review-list">
                <div class="review-item">
                    <p><strong>빈아리퍼펙트</strong></p>
                    <p class="rating">★★★★☆ 4.0</p>
                    <p>이 곳에서 정말 멋진 시간을 보냈어요. 음식이 정말 훌륭하고 서비스도 굉장히 좋았습니다.</p>
                </div>
                <div class="review-item">
                    <p><strong>고구마슈타이거</strong></p>
                    <p class="rating">★★★☆☆ 3.5</p>
                    <p>음식은 좋았지만, 가격이 조금 비싸다고 생각합니다. 위치는 좋습니다만, 다시 방문할지는 잘 모르겠어요.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleReviewForm() {
        var form = document.getElementById('reviewForm');
        if (form.style.display === "none" || form.style.display === "") {
            form.style.display = "block";
        } else {
            form.style.display = "none";
        }
    }

    // 지도 API를 삽입하는 스크립트 예시
    function initMap() {
        var mapOptions = {
            center: new naver.maps.LatLng(37.5665, 126.9780),
            zoom: 10
        };
        var map = new naver.maps.Map('map', mapOptions);
    }
</script>

<!-- FontAwesome 사용을 위한 링크 추가 -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<!-- 네이버 지도 API 스크립트 추가 -->
<script>initMap();</script>

</body>
</html>

