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

      
        #my_modal {
                display: none;
                width: 500px;
                padding: 20px 60px;
                background-color: #fefefe;
                border: 1px solid #888;
                border-radius: 3px;
            }

             .modal_close_btn {
                position: absolute;
                top: 10px;
                right: 10px;
                 z-index: 1001; }

     
          

         /* 별점 스타일 */

             .star-rating {
            display: flex;
            flex-direction: row-reverse;
            font-size: 2.25rem;
            line-height: 2.5rem;
            justify-content: space-around;
            padding: 0 0.2em;
            text-align: center;
            width: 5em;
            }
            
            .star-rating input {
            display: none;
            }
            
            .star-rating label {
            -webkit-text-fill-color: transparent; 
            -webkit-text-stroke-width: 2.3px;
            -webkit-text-stroke-color: #2b2a29;
            cursor: pointer;
            }
            
             .star-rating :checked ~ label {
            -webkit-text-fill-color: gold;
            } 
            
            .star-rating label:hover,
            .star-rating label:hover ~ label {
            -webkit-text-fill-color: #fff58c;
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
    
     <div id="my_modal" class="modal fade" >
     
    		<div>
    		</div>

                 <form action="reviewInsert.do" method="post" enctype="multipart/form-data">
    		<a><img class="modal_close_btn"  src="resources/images/close.png" style="width: 30px; height: 30px;"></a> 
                    <h2 align="center">리뷰작성</h2>
                    <table style="width: 400px; height:200px;">
                        <tr>
                           <td><input class="storeName" type="text" value=""></td>
                            
                            <td><input name="ucSeq"  class="storeNo" type="hidden" value="" ></td>
                            <td><input name="userNo"  class="userNo" type="hidden" value="" ></td>
                         
                        </tr>
                        <tr>
                            <td><input type="text" class="reviewComment" name="reviewComment"style="width: 400px; height: 100px;"></td>
                            
                        </tr><br>
                       
                        <tr>
                          
                            <td><input type="file" class="upfile" name="upfile"></td>
                        </tr><br>
                    </table>
    
                    <!-- 별점 -->
                    <div class="star-rating space-x-4 mx-auto">
                        <input type="radio" id="5-stars"  class="rating" name="rating" value="5" v-model="ratings"/>
                        <label for="5-stars" class="star pr-4">★</label>
    
    
                        <input type="radio" id="4-stars" class="rating"  name="rating" value="4" v-model="ratings"/>
                        <label for="4-stars" class="star">★</label>
    
    
                        <input type="radio" id="3-stars" class="rating"  name="rating" value="3" v-model="ratings"/>
                        <label for="3-stars" class="star">★</label>
    
    
                        <input type="radio" id="2-stars" class="rating"  name="rating" value="2" v-model="ratings"/>
                        <label for="2-stars" class="star">★</label>
    
    
                        <input type="radio" id="1-star" class="rating"  name="rating" value="1" v-model="ratings" />
                        <label for="1-star" class="star">★</label>
                    </div>
            
                   
                    <br>
                    <div align="center">
                        
                        <button type="button" onclick="insertReview()">작성</button>
    
                    </div>
                </form> 
             
            </div>
 

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
    	                    buttonHtml = '<button type="button" class="btn btn-danger" onclick="modal(\'my_modal\', \''+item.mainTitle +'\',' +item.ucSeq+ ',' + item.user_no + ');"data-toggle="modal" data-target="#my_modal">리뷰 작성</button>';
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
	// 모달을 닫는 함수
	function closeModal() {
	    var modal = document.getElementById('my_modal');
	    if (modal) {
	        modal.style.display = 'none';
	        var backdrop = document.querySelector('.modal-backdrop');
	        if (backdrop) {
	            backdrop.remove();
	        }
	    }
	}

	// 모달을 표시하는 함수
	function showModal() {
	    var modal = document.getElementById('my_modal');
	    if (modal) {
	        modal.style.display = 'block';
	    }
	}

	// 모달 닫기 버튼에 이벤트 리스너 추가
	var closeButton = document.querySelector('.modal_close_btn');
	if (closeButton) {
	    closeButton.addEventListener('click', function() {
	        console.log('모달 닫기 버튼 클릭됨');
	        closeModal(); // 모달 닫기
	    });
	} else {
	    console.error('모달 닫기 버튼이 찾을 수 없습니다.');
	}

	// 모달을 다시 열고자 할 때 호출할 함수
	function openModal() {
	    showModal(); // 모달 열기
	}

	// 이후 필요한 곳에서 openModal() 함수를 호출하여 모달을 다시 열 수 있습니다.



	  function modal(id, storeName,storeNo,userNo) {
	      
			$('#test3').val(''); 
			//모달창 reviewContent영역 공백으로

	        $('.storeName').val(storeName);
	        $('.userNo').val(userNo);
	        $('.storeNo').val(storeNo);
	        var zIndex = 9999;
	        var modal = document.getElementById(id);

	        // 모달 div 뒤에 희끄무레한 레이어
	      

	        // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
	        /*
	        modal.querySelector('.modal_close_btn').addEventListener('click', function() {
	            
	        	console.log("ㅎㅇ");
	          
	            bg.remove();
	            modal.style.display = 'none';
	        }); 
	        */
	       

	      
	    }
	  
	

	  function insertReview() {
		    var fileInput = $('.upfile')[0];
		    var formData = new FormData();

		    // 파일이 선택되었는지 확인하고 FormData에 파일 추가
		    if (fileInput.files.length > 0) {
		        formData.append("upfile", fileInput.files[0]);
		    }

		    // 다른 필드들도 FormData에 추가
		    formData.append("mainTitle", $('.storeName').val());
		    formData.append("userNo", $('.userNo').val());
		    formData.append("ucSeq", $('.storeNo').val());
		    formData.append("rating", $('.rating').val());
		    formData.append("reviewComment", $('.reviewComment').val());

		    $.ajax({
		        url: 'reviewInsert.do',
		        method: "post",
		        data: formData,
		        enctype: 'multipart/form-data',
		        processData: false,
		        contentType: false,
		        success: function(result) {
		            alert('리뷰가 작성되었습니다.');
		            // 필요에 따라 적절한 후속 동작 수행
		             window.location.href = 'myPage.do';
    				 
		        },
		        error: function() {
		            console.log('실패');
		        }
		    });
		}


	
	
	
  </script>

</body>
</html>