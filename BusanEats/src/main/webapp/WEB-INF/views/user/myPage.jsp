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
        #my_modal {
                display: none;
                width: 500px;
                padding: 20px 60px;
                background-color: #fefefe;
                border: 1px solid #888;
                border-radius: 3px;
            }

            #my_modal .modal_close_btn {
                position: absolute;
                top: 10px;
                right: 10px; }

             /* 수정 모달 시작 */
             #my_modal2 {
                display: none;
                width: 500px;
                padding: 20px 60px;
                background-color: #fefefe;
                border: 1px solid #888;
                border-radius: 3px;
            }

            #my_modal2 .modal_close_btn {
                position: absolute;
                top: 10px;
                right: 10px; }

          

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
    
     <div class="modal fade" id="my_modal">

                <form action="reviewInsert.re" method="post" enctype="multipart/form-data">
                    <h2 align="center">후기작성</h2>
                    <table style="width: 400px; height:200px;">
                        <tr>
                           <td><input class="storeName" type="text" value=""></td>
                            
                            <td><input name="ucSeq"  class="storeNo" type="text" value="" ></td>
                            <td><input name="userNo"  class="userNo" type="text" value="" ></td>
                         
                        </tr>
                        <tr>
                            <td><input type="text" name="reviewComment"style="width: 400px; height: 100px;"></td>
                            
                        </tr><br>
                       
                        <tr>
                          
                            <td><input type="file" name="upfile"></td>
                        </tr><br>
                    </table>
    
                    <!-- 별점 -->
                    <div class="star-rating space-x-4 mx-auto">
                        <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
                        <label for="5-stars" class="star pr-4">★</label>
    
    
                        <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
                        <label for="4-stars" class="star">★</label>
    
    
                        <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
                        <label for="3-stars" class="star">★</label>
    
    
                        <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
                        <label for="2-stars" class="star">★</label>
    
    
                        <input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
                        <label for="1-star" class="star">★</label>
                    </div>
            
                    <a class="modal_close_btn">  <img  src="resources/images/close.png" style="width: 30px; height: 30px;"></a>
                    <br>
                    <div align="center">
                        
                        <button type="submit">작성</button>
    
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
    	                    buttonHtml = '<button type="button" class="btn btn-danger" onclick="modal(\'my_modal\', \''+item.mainTitle +'\',' +item.ucSeq+ ',' + item.user_no + ')" data-toggle="modal" data-target="#my_modal">리뷰 작성</button>';
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
	
	
	  function modal(id, storeName,storeNo,userNo) {
	      
			$('#test3').val(''); //모달창 reviewContent영역 공백으로

	        $('.storeName').val(storeName);
	        $('.userNo').val(userNo);
	        $('.storeNo').val(storeNo);
	        var zIndex = 9999;
	        var modal = document.getElementById(id);

	        // 모달 div 뒤에 희끄무레한 레이어
	        var bg = document.createElement('div');
	        bg.setStyle({
	            position: 'fixed',
	            zIndex: zIndex,
	            left: '0px',
	            top: '0px',
	            width: '100%',
	            height: '100%',
	            overflow: 'auto',
	            // 레이어 색갈은 여기서 바꾸면 됨
	            backgroundColor: 'rgba(0,0,0,0.4)'
	        });
	        document.body.append(bg);

	        // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
	        modal.querySelector('.modal_close_btn').addEventListener('click', function() {
	            
	          
	            bg.remove();
	            modal.style.display = 'none';
	        });

	        modal.setStyle({
	            position: 'fixed',
	            display: 'block',
	            boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

	            // 시꺼먼 레이어 보다 한칸 위에 보이기
	            zIndex: zIndex + 1,

	            // div center 정렬
	            top: '50%',
	            left: '50%',
	            transform: 'translate(-50%, -50%)',
	            msTransform: 'translate(-50%, -50%)',
	            webkitTransform: 'translate(-50%, -50%)'
	        });
	    }

	
	
	
	
  </script>

</body>
</html>