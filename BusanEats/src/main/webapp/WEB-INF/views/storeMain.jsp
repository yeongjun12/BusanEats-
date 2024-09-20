<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매장 로그인용 메인페이지</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
        }
        .container {
            margin-top: 50px;
        }
        .store-info, .chat-info {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .store-info h2, .chat-info h2 {
            font-size: 20px;
            font-weight: bold;
        }
        .store-info p, .chat-info p {
            font-size: 16px;
            margin: 10px 0;
        }
        .chat-info {
            position: relative;
        }
        .new-chat-alert {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: red;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 14px;
            display: none; /* 채팅 알림 표시 여부 */
        }
    </style>
</head>
<body>

	<jsp:include page="common/header.jsp" />
    <div class="container">
        <!-- 매장 정보 표시 -->
        <div class="store-info">
            <h2>매장 정보</h2>
            <p>매장 이름: ${loginStore.mainTitle}</p>
            <p>매장 위치: ${loginStore.addr1}</p>
        </div>

        <!-- 채팅 알림 표시 -->
        <div class="chat-info">
            <h2>채팅 알림</h2>
            <p>현재 새로운 채팅 메시지 여부 확인 중...</p>
            <div class="new-chat-alert" id="newChatAlert">새로운 채팅!</div>
        </div>
    </div>

    <!-- jQuery 및 Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

    <!-- 새로운 채팅 여부 확인 스크립트 -->
    <script type="text/javascript">
        $(document).ready(function() {
            // 서버에서 새로운 채팅 메시지가 있는지 확인
            
        	var ucSeq = parseInt("${loginStore.ucSeq}", 10);
            console.log(ucSeq);
            
            // 페이지 로드 시 즉시 채팅 확인
            checkNewChat(ucSeq);
        	  
            function checkNewChat(ucSeq) {
                $.ajax({
                    type: 'GET',
                    url: 'checkNewChat.do', // 새로운 채팅 확인용 서버 엔드포인트
                    data: {ucSeq : ucSeq},
                    dataType: 'json',
                    success: function(response) {
                        if (response.newChatExists) {
                            // 새로운 채팅이 있는 경우 알림 표시
                            $('#newChatAlert').show();
                        } else {
                            // 새로운 채팅이 없는 경우 알림 숨김
                            $('#newChatAlert').hide();
                        }
                    },
                    error: function(error) {
                        console.log("채팅 확인 중 오류 발생: ", error);
                    }
                });
            }

            // 페이지 로드 시 채팅 확인
            checkNewChat();

            // 일정 시간마다 채팅 확인 (예: 30초마다)
            setInterval(checkNewChat, 30000);
        });
    </script>
</body>
</html>
