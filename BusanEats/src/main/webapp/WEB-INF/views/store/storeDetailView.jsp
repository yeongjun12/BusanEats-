<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>식당 상세 정보</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .restaurant-info {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 800px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .restaurant-details {
            max-width: 60%;
        }

        h1 {
            color: #333;
            margin-bottom: 10px;
        }

        h2 {
            color: #555;
            margin-bottom: 8px;
        }

        img {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
            margin-bottom: 12px;
        }

        p {
            color: #666;
        }

        .like-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="restaurant-info">
    <div class="restaurant-details">
        <h1>${s.mainTitle }</h1>
		 <div>
            <h2>주소 : ${s.addr1 }</h2>
        </div>


        <div>
            <h2>메뉴 : ${s.reprsntvMenu }</h2>
        </div>

        <div>
            <h2>영업시간</h2>
            <p>${s.usageDayWeekAndTime }</p>
        </div>

        <div>
            <h2>매장 소개</h2>
            <p>${s.itemCntnts }</p>
            
        </div>

        <div>
            <h2>전화번호</h2>
            <p>${s.cntctTel }</p>
        </div>
        
        <input type="hidden" id="lat" value="${s.lat}">
		<input type="hidden" id="lng" value="${s.lng}">
        
        <!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=baf41b3f50d76c8b3aefa017c15e2227"></script>
<script>

		var mapContainer = document.getElementById('map'); // 지도를 표시할 div
		var lat = $('#lat').val();  // Parse the latitude value to float
		var lng = $('#lng').val();  // Parse the longitude value to float
		
		
		var mapOption = {
		    center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
		    level: 3 // 지도의 확대 레벨
		};
		
		// 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);
</script>
        

      <hr>
    </div>
    <div>
        <h2>식당 대표 사진</h2>
        <img src="${s.mainImgThumb }" alt="대표 사진">
    </div>
    
    <hr>
</div>




<button class="like-button">좋아요</button>

</body>
</html>


    