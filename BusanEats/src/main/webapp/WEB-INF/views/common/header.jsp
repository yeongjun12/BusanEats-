<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="en"><head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        html, body {
            max-width: 1000px;
            margin: 0 auto;
            font-family: Arial, sans-serif;
        }
        header {
            background-color: white;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .search-bar {
            flex: 1;
            margin: 0 10px;
        }
        .login-signup {
            display: flex;
            gap: 10px;
        }
        .login-signup a {
            color: black;
            text-decoration: none;
        }
        .login-signup a:hover {
            color: red;
        }
        .search {
            position: relative;
            width: 300px;
            display: flex;
            align-items: center;
        }
        .search input {
            width: 100%;
            border: 1px solid #bbb;
            border-radius: 8px;
            padding: 10px 35px 10px 12px;
            font-size: 14px;
        }
        .search img {
            position: absolute;
            width: 17px;
            top: 50%;
            right: 15px;
            margin-top: -8.5px;
        }
        .unread-bubble {
            display: inline-block;
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 2px 5px;
            font-size: 14px;
            position: absolute;
            top: -10px;
            right: -10px;
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
    </style>
    <title>Header Example</title></head><body><c:if test="${not empty alertMsg}">
    <script>
        alert('${alertMsg}');
    </script>
    <c:remove var="alertMsg" scope="session"/></c:if><header>
    <div class="logo"><img src="resources/images/mainLogo.png" width="150" height="90"></div>
    <div class="search">
        <form class="search" action="search.do" method="get">
            <input type="text" name="query" placeholder="검색어 입력">
            <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
        </form>
    </div>
    <div class="login-signup">
        <c:choose>
            <c:when test="${empty loginUser}">
                <a href="loginForm">로그인</a>
                <a href="joinEnrollForm">회원가입</a>
            </c:when>
            <c:otherwise>
                <label>${loginUser.userName}님 환영합니다</label>
                &nbsp;&nbsp;

                <div style="position: relative;">
                    <a href="#" onclick="openChatWindow()">
                        <img src="resources/images/chatBubble.png" alt="채팅 로고" style="width: 30px; height: 30px;">
                    </a>
                    
                        <div class="unread-bubble" id="unreadBubble"></div>
                    
                </div>

                <a href="myPage.do">마이페이지</a>
                <a href="logout.do">로그아웃</a>
            </c:otherwise>
        </c:choose>
    </div>
    
    </header>
    
    

<script>
    // 새로운 창을 열어 채팅 목록을 표시하는 함수 (크기와 속성 조절 가능)
    function openChatWindow() {
        window.open('chatOpen.do', 'chatWindow', 'width=400,height=600');
    }
	
    
    
    
    // 주기적으로 새로운 알림이 있는지 확인하는 AJAX 함수
    function checkForNewMessages() {
    	
    	let g_messageCount = 0;
    	
    	
        $.ajax({
            url: 'getChatList.do', // 백엔드에서 읽지 않은 메시지 개수를 가져오는 API 엔드포인트
            method: 'GET',
            data: {
                userNo: '${sessionScope.loginUser.userNo}',
                senderType: 'store'
            },
            success: function(response) {
            	
            	
            	 $.each(response, function (index, chat) {
            		 g_messageCount += chat.unread_count;
            	 });
            	
            	
                if (g_messageCount > 0) {
                    $('#unreadBubble').text(g_messageCount).show();
                } else {
                    $('#unreadBubble').hide();
                }
            },
            error: function(error) {
                console.log('알림 수 불러오기 실패:', error);
            }
        });
    }

    // 페이지가 로드될 때와 일정 시간마다 알림 확인
    $(document).ready(function() {
        checkForNewMessages();
        setInterval(checkForNewMessages, 2000); // 5초마다 새 메시지 확인
    });
</script></body></html>