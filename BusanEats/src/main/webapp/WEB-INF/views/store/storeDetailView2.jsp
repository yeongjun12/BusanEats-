<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        
            .reviewArea {
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
        
        div {
        	border : 1px solid red;
        }
    </style>
    
    
    
    
</head>
<body>

<div class="restaurant-info">
    <div class="restaurant-details">
        <h1>${s.mainTitle }</h1>
        
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
        
         <div>
            <h2>주소 : ${s.addr1 }</h2>
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
        

      <hr>
      
      
    </div>
    
    

    
    
    
    <div>
    <br><br><br>
        <img src="${s.mainImgThumb }" alt="대표 사진">
    </div>
    
    <hr>
</div>

<div class="reviewArea">
<table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th>첨부파일</th>
                    </tr>
                </thead>
                <tbody>
                    
                    	<tr>
                    	   <td class ="bno"> b.boardNo</td>
                    	   <td> b.boardTitle</td>
                    	   <td> b.boardWriter }</td>
                    	   <td> b.count }</td>
                    	   <td> b.createDate}</td>
                    	   <td>
                    	   		***
                    	   </td>
                    	</tr>
                    	
                    	<tr>
                    	   <td class ="bno"> b.boardNo</td>
                    	   <td> b.boardTitle</td>
                    	   <td> b.boardWriter }</td>
                    	   <td> b.count }</td>
                    	   <td> b.createDate}</td>
                    	   <td>
                    	   		***
                    	   </td>
                    	</tr>
                    	
                    	<tr>
                    	   <td class ="bno"> b.boardNo</td>
                    	   <td> b.boardTitle</td>
                    	   <td> b.boardWriter }</td>
                    	   <td> b.count }</td>
                    	   <td> b.createDate}</td>
                    	   <td>
                    	   		***
                    	   </td>
                    	</tr>
                    
                </tbody>
            </table>

</div>




	
	<!-- Reservation button and form -->
	<div class="reservation-form">
		<c:choose>
				<c:when test="${ empty loginUser }" >
				로그인이 필요합니다. 
				</c:when>
			
				<c:otherwise>
	
	
	    <button class="reservation-button" onclick="toggleReservationForm()">예약하기</button>
	    <div id="reservationForm" style="display: none;">
	        <h2>예약 정보 입력</h2>
	        <form action="insertReservation.do" method="post">
	        	<input type="hidden" name="user_no" value="${loginUser.userNo }">
	        	<input type="hidden" name="ucSeq" value="${s.ucSeq }">
	        	
	        
	            <label for="guestCount">손님 수:</label>
	            <input type="number" id="guestCount" name="number_of_guest" min="1" required>
	
	            <label for="reservationDate">날짜:</label>
	            <input type="date" id="reservationDate" name="reservation_date" required>
	
	            <label for="reservationTime">시간:</label>
	            <input type="time" id="reservationTime" name="reservation_time" required>
	
	            <button type="submit">예약 완료</button>
	        </form>
	    </div>
	    </c:otherwise>
	    </c:choose>
	</div>
	

	


<script>
    function toggleReservationForm() {
        $("#reservationForm").toggle();
    }

    function submitReservation() {
        // Get values from the reservation form
        var guestCount = $("#guestCount").val();
        var reservationDate = $("#reservationDate").val();
        var reservationTime = $("#reservationTime").val();

        // Perform reservation logic (send to server, etc.)
        console.log("Reservation Details:");
        console.log("Number of Guests:", guestCount);
        console.log("Reservation Date:", reservationDate);
        console.log("Reservation Time:", reservationTime);

        // Close the form after submission
        toggleReservationForm();
    }
    
    // Dynamically set the min and max attributes for the date input
    $(document).ready(function() {
        var today = new Date();
        var nextWeek = new Date();
        nextWeek.setDate(today.getDate() + 7);

        var todayFormatted = formatDate(today);
        var nextWeekFormatted = formatDate(nextWeek);

        $("#reservationDate").attr("min", todayFormatted);
        $("#reservationDate").attr("max", nextWeekFormatted);
    });

    function formatDate(date) {
        var year = date.getFullYear();
        var month = ("0" + (date.getMonth() + 1)).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        return year + "-" + month + "-" + day;
    }
    

    function formatTime(minutes) {
        var hours = Math.floor(minutes / 60);
        var mins = minutes % 60;
        return ("0" + hours).slice(-2) + ":" + ("0" + mins).slice(-2);
    }
    
 	// 예약
 	
 	/*
 	function reservation(){
 		
 		$.ajax({
 			
 			url : 'insertReservation.do',
 			data : 
 				{
	 				user_no : $('input[name=user_no]').val(),
	 				ucSeq: $('input[name=ucSeq]').val(),
	 				number_of_guest: $('input[name=number_of_guest]').val(),
	 				reservation_date: $('input[name=reservation_date]').val(),
	 				reservation_time: $('input[name=reservation_time]').val()
 				},
 				
 				success : function(){
 					 // 예약이 성공적으로 완료되었을 때
 		            alert('예약이 완료되었습니다.');
 				},
 				
 				error:function(){//해당 통신에 실패했을 때
					console.log('ajax통신실패');
				}
 			
 		});
 		
 	}
 	
 	*/
    
    
</script>




<button class="like-button">좋아요</button>

</body>
</html>


    