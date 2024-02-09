<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 
 
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    body {
      margin: 0;
      font-family: 'Arial', sans-serif;
    }

    .container {
      display: flex;
    }

    .sidebar {
      width: 250px; /* Increased width */
      height:500px;
      background-color: #2c3e50; /* Darker color */
      padding: 20px;
      box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
      color: #ecf0f1; /* Light text color */
    }

    .sidebar ul {
      list-style: none;
      padding: 0;
    }

    .sidebar li {
      margin-bottom: 10px;
    }

    .sidebar a {
      text-decoration: none;
      color: #ecf0f1;
      font-weight: bold;
      display: block;
      padding: 10px;
      border-radius: 5px;
      transition: background-color 0.3s;
    }

    .sidebar a:hover {
      background-color: #34495e; /* Darker color on hover */
    }

    .content {
      padding: 20px;
      flex: 1;
    }

    /* Additional styling for better aesthetics */
    h2 {
      color: #2c3e50;
    }

    p {
      color: #34495e;
    }
    
    .userLogin {
	  text-align: center;
	}
	
	 /* 예약 내역 스타일 */
        .reservation {
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 10px;
            display: flex;
        }

       /* 예약 정보 스타일 */
        .reservation-date {
            font-weight: bold;
            cursor: pointer;
        }
        
        .reservation-details {
			width : 500px;     
        }
        
        .cancelArea {
        text-align: center;
        }

      <!-- 리뷰-->
       #review-write-area, #store-report-area{
        position: fixed;
        width: 600px;
        height:900px;
        background-color: rgb(253, 219, 219);
        border-radius: 20px;
        /* position: fixed; */
        left: 50%;
        top: 50%;
        /* -webkit-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        -moz-transform: translate(-50%, -50%);
        -o-transform: translate(-50%, -50%); */
        transform: translate(-50%, -50%);
        display: none;
        z-index: 1000;
    }

    #review-write-area .close, #store-report-area .close{
        font-size: 40px;
        background-color:rgba(95, 152, 124, 0);
        border: 1px solid rgba(245, 245, 220, 0);
        cursor: pointer;
        color:rgb(0, 0, 0);
        padding-left: 560px;
    }

    #review-write-area .modal-title{
        text-align: center;
    }

    .modal-content p {
        margin-left: 25px;
        font-size: 20px;
        font-weight: 700;
        margin-bottom: 5px;
    }

    #review-write-area .modal-title h2{
        /* margin-left: 20px; */
        font-size: 30px;
        font-weight: 900;
        color: black;
    }
    
    

    #checked-meal-type {
        width: 600px;
        height:120px;
    }

    #checked-meal-type img{
        margin-bottom: 10px;
        margin-left: 10px;
    }

    #checked-meal-type input[name=menu-type] {
        display: none;
    }

    #checked-meal-type label{
        width:80px;
        height:60px;
        display: inline-block;
        text-align: center;
        margin: auto;
        font-weight: 800;
        margin: 0 10px;
    }

    #modal-footer {
        width: 600px;
        height: 50px;
        text-align: center;
    }

    #modal-footer input {
        width:100px;
        height: 50px;
        font-size: 17px;
        font-weight: 900;
        border-style: none;
        background-color: rgba(209, 231, 157, 0.755);
        cursor: pointer;
        margin-left: 14px;
        margin-top:10px;
    }

    #modal-footer input:hover{
        background-color: rgba(67, 70, 62, 0.755);
        color: aliceblue;
    }

    #star-area img{
        margin: 0 25px;
    }

    #star-area label{
        display: inline-block;
    }

    #star-area input[name=reviewStar] {
        display: none;
    }

    #pt-insert-table span{
        border: 1px solid black;
        display: inline-block;

    }
      
    
  </style>
</head>
<body>
<div class="container">
    <div class="sidebar">
      <ul>
        <li><a href="#" onclick="showTab('profile')">프로필</a></li>
        <li><a href="#" onclick="showTab('settings')">개인 정보 수정</a></li>
        <li><a href="#" onclick="showTab('orders')">예약 내역</a></li>
      </ul>
    </div>
    <div class="content" id="profileTab">
      <!-- 프로필 내용 -->
      <h2>개인 정보 수정</h2>
      <h3>비밀번호 재확인</h3>
      <p>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요.</p>
      <hr>
      	
      <div class="userLogin" style="display: show;">
		  
		  
		    <label for="userId">아이디</label><br>
		    <input type="text" id="userId" name="userId" ><br>
		    
		    <label for="userPwd">비밀번호</label><br>
		    <input type="password" id="userPwd" name="userPwd"  ><br>
		    
		    <button onclick="pwdCheck();">확인</button>
		 
	</div>
	 <form action="update.do" method="post">
	 <div id="hiddenPage" style="display: none;">
	 		<input type="hidden" value="${loginUser.userNo }" name="userNo">
		   <label for="newPwd">새 비밀번호</label><br>
		    <input type="password" id="newPwd" name="newPwd" placeholder="새 비밀번호를 입력해주세요" ><br>
		     <label for="PwdCheck">새 비밀번호 확인</label><br>
		    <input type="password" id="pwdCheck" name="pwdCheck" placeholder="새 비밀번호를 다시 입력해주세요" >
		    <button type="button" onclick="newPwdCheck();">비밀번호 확인</button><br>
		    
		    <label for="userPhone">전화번호</label><br>
		    <input type="text" id="userPhone" value="${loginUser.userPhone }" name="userPhone" ><br>
		    
		     <label for="userEmail">이메일</label><br>
		    <input type="text" id="userEmail" value="${loginUser.userEmail }" name="userEmail" >
		    <div id="checkResult" style="font-size:0.7em; display:none;"></div><br>
		    
		     <label for="userBirth">생년월일</label><br>
		    <input type="text" id="userBirth" value="${loginUser.userBirth }" name="userBirth" ><br>
	
	
			<button >탈퇴하기</button>
			<button type="submit" id="updateButton" disabled>회원정보 수정</button>
		 </div>
      </form>
		
	 <hr>

      	
    </div>
    <div class="content" id="settingsTab" style="display:none;">
      <!-- 설정 내용 -->
      <h2>설정</h2>
      <p>사용자의 설정을 여기에 표시합니다.</p>
    </div>
    
    
    
    <div class="content" id="ordersTab" style="display:none;">
      <!-- 주문 내역 내용 -->
      <h2>예약 내역</h2>
      
         
      
  
      
      
    </div>
    
    
    <!-- 리뷰 -->
    <div id="review-write-area">
            <div class="modal fade" id="mymodal1">
                <div class="modal-dialog">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <br>
                        <div class="modal-title"><h2>리뷰쓰기📝</h2></div>
                    </div>

                    <form action="#" method="post" enctype="multipart/form-data">
                        <!-- 여기 나중에 수정해야 함  -->
                  
                  		<input type="hidden" name="memNo" value="">
					
                    <input type="hidden" name="placeNo" value=""> 
                        <div class="modal-content">
                            <p>● 별점을 메겨주세요</p>
                            <div id="star-area">

                                <label for="rate1">
                                    <input type="radio" name="reviewStar" value="1" id="rate1" checked>
                                    <img src="resources/images/star1.png" width="50" height="50" alt="">
                                </label>

                                <label for="rate2">
                                    <input type="radio" name="reviewStar" value="2" id="rate2">
                                    <img src="resources/images/star2.png" width="50" height="50" alt="">
                                </label>

                                <label for="rate3">
                                    <input type="radio" name="reviewStar" value="3" id="rate3">
                                    <img src="resources/images/star2.png" width="50" height="50" alt="">
                                </label>

                                <label for="rate4">
                                    <input type="radio" name="reviewStar" value="4" id="rate4">
                                    <img src="resources/images/star2.png" width="50" height="50" alt="">
                                </label>
                                
                                <label for="rate5">
                                    <input type="radio" name="reviewStar" value="5" id="rate5">
                                    <img src="resources/images/star2.png" width="50" height="50" alt="">
                                </label>

                            </div>

                            <br>
                          
                            </div>

                            <p>● 식당에 대해서 평가해주세용😏</p>
                            <div id="write-textarea">
                                <textarea name="content" rows="500" style="width:500px; height:120px; resize:none;" placeholder="10자 이상 입력해주세요!" required></textarea>
                            </div>

                            <br>
                            <p>● 사진 등록하기📷</p>
                            <div id="photo-insert-area">
                                <div id="pt-insert-table">
                                        <span><img width="120" height="120" id="photo-insert1" class="1" src="resources/images/plus.png"></span>
                                        <span><img width="120" height="120" id="photo-insert2" class="2" src="resources/images/plus.png"></span>
                                        <span><img width="120" height="120" id="photo-insert3" class="3" src="resources/images/plus.png"></span>
                                        <span><img width="120" height="120" id="photo-insert4" class="4" src="resources/images/plus.png"></span>
                                </div>
                            </div>

                            <div id="file-insert">
                                <input type="file" name="file1" id="file1" class="1">
                                <input type="file" name="file2" id="file2" class="2">
                                <input type="file" name="file3" id="file3" class="3">
                                <input type="file" name="file4" id="file4" class="4">
                            </div>
                       
                            <br>
                            <!-- 나중에 완성  -->
                            <p>● 태그 골라용</p>
                            <div id="tag-area">
                                <select name="tag" class="tag-opt"> <!--style="display:none;"-->
                                    <option>플레이팅이 멋져요</option>
                                    <option>매장이 청결해요</option>
                                    <option>직원이 상냥해요</option>
                                    <option>화장실이 깨끗해요</option>
                                    <option>특별한 날 가기 좋아요</option>
                                    <option>주차하기 편해요</option>
                                    <option>양이 많아요</option>
                                    <option>음식이 맛있어요</option>
                                    <option>재료가 신선해요</option>
                                    <option>가성비가 좋아요</option>
                                    <option>매장이 넓어요</option>
                                    <option>뷰가 좋아요</option>
                                    <option>모임하기 좋아요</option>
                                    <option>인테리어가 멋져요</option>
                                    <option>혼밥하기 좋아요</option>
                                    <option>사장님이 다정해요</option>
                                    <option>반려동물과 함께해요</option>
                                    <option>접근성이 좋아요</option>
                                </select>
                                <span id="tag-zone"></span>
                                <a id="tag-add" style="cursor:pointer;"> + </a>
                                <a id="tag-minus" style="cursor:pointer;"> - </a>
                            </div>
                        </div>

                        <div id="modal-footer">
                            <input type="submit" value="등록하기" disabled/>
                            <input type="reset" value="다시쓰기"/>
                        </div>
                    </form>
                </div><!-- class="modal-dialog" -->
            </div><!-- class="modal fade" id="mymodal1" -->
        </div> <!-- #review-write-area-->
 

  <script>
  
  
    function showTab(tabId) {
      // 모든 탭 숨기기
      document.querySelectorAll('.content').forEach(tab => {
        tab.style.display = 'none';
      });

      // 선택한 탭 보이기
      document.getElementById(tabId + 'Tab').style.display = 'block';
      
      if(tabId == 'orders') {
    	  
    	  var userNo = "${loginUser.userNo}";
    	  
    	  
    	  $.ajax({
    		    url: 'selectReservation.do',
    	        method: 'GET',
    	        data: { userNo: userNo },
    	        success: function(list) {
    	            // 서버 응답에 따른 동작 수행
    	            console.log(list);
    	            $('#ordersTab').empty();
    	            
    	         // 현재 날짜 생성
    	            var currentDate = new Date();
    	            
    	            list.forEach(function(item) {
    	            	
    	            	 // 예약 일자와 시간을 하이픈(-)으로 구분하여 합침
    	                var reservationDateTime = item.reservation_date + ' ' + item.reservation_time;
    	                // 예약 일시를 Date 객체로 변환
    	                var reservationDate = new Date(reservationDateTime);

    	                // 현재 날짜와 예약 일시를 비교하여 버튼 생성
    	                var buttonHtml = '';
    	                if (reservationDate.getTime() < currentDate.getTime()) {
    	                    // 예약 일시가 과거 날짜인 경우
    	                    buttonHtml = '<button onclick="writeReview()class="btn btn-danger" data-toggle="modal" data-target="#mymodal1">리뷰 작성</button>';
    	                } else {
    	                    // 아직 지나지 않은 날짜인 경우
    	                    buttonHtml = '<button onclick="cancelReservation('+item.reservation_no+')">예약 취소</button>';
    	                }

    	            	
    	            	
                        var reservationHtml =
                            '<div class="reservation">' +
                            '<img src="' + item.mainImgThumb + '" alt="식당 사진" width="200" height="150">' +
                            
                            '<div class="reservation-details">' +
                            '<a>'+ item.mainTitle +'</a>' +
                            '<p>예약 일시: ' + item.reservation_date +'-' +item.reservation_time +'</p>' +
                            '<p>매장 번호: ' + item.cntctTel +'</p>' +
                            '<p>인원 수: ' + item.number_of_guest + ' 명</p>' +
                            '</div>' +
                            '<div class="cancelArea">' +
                            '<div class="cancelArea">' + buttonHtml + '</div>' +
                            '</div>' +
                            '</div>';

                        $('#ordersTab').append(reservationHtml);
                    });
    	            
    	        },
    	        error: function(xhr, status, error) {
    	            console.error('AJAX 요청 실패:', error);
    	        }
    	  });
    	  
      }
      
    }
    
    
    function pwdCheck(){
    	//사용자가 입력한 아이디와 비밀번호를 Controller에 가져가서 session에 있는 userId와 (암호화된)userPwd와 비교
    	$.ajax({
    		url : 'pwdCheck.do',
        	data : 
        		{
        		 userId : $('#userId').val(),
        		 userPwd : $('#userPwd').val()
        		
        		},
        		
        		success : function(result){
        			console.log(result);
        			
        			
        			if (result == 'success') {
                        // 성공한 경우, 숨겨진 페이지를 보이게 함
                       console.log(result);
                        $('#hiddenPage').show();
                        $('.userLogin').hide();
                    } else {
                    	  console.log(result);
                        alert("아이디와 비밀번호를 확인해주세요.");
                    }
        		},
        		error:function(){
        			console.log('실패');
        		}
    	});
    }
    //비밀번호 2중체크 하기
    function newPwdCheck(){
    	if($('#newPwd').val() == $('#pwdCheck').val()){
    		$('#updateButton').prop('disabled', false);
    		
    	}
    }
    
    function isValidEmail(email) {
	    // 이메일 형식을 정의합니다.
	    let emailPattern = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
	   
	    // 입력된 이메일 주소를 검사합니다.
	    return emailPattern.test(email);
	}
    
    //메일 유효성 검사
    const mailInput=$('#userEmail');
    
    mailInput.keyup(function(){
    	
    	if(isValidEmail(mailInput.val())){
    		//메일유효성 성공 시
    		$('#checkResult').show();
			$('#checkResult').css('color','green').text('사용가능한 메일 형식입니다');
    	}else{
    		$('#checkResult').show();
			$('#checkResult').css('color','red').text('올바른 이메일 주소를 입력하세요');
    	}
    	
    })
    
    <!----------- 예약 취소 함수 ------------------>
	function cancelReservation(reservation_no) {
		$.ajax({
			url: 'cancelReservation.do',
			method: 'POST',
			data: {reservation_no : reservation_no },
			success: function(result){
				
				alert('예약이 취소되었습니다.');
				showTab('orders'); // 취소하고 화면 새로 생성할 수 있도록 호출
			},
			error: function(){
				console.log(reservation_no);
				console.log('통신실패');
			}
		});
		
	}
	<!------------- 리뷰 작성 모달 ------------------>
	

	
	
	
	
  </script>

</body>
</html>