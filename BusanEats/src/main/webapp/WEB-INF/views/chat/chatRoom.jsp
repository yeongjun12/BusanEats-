<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>채팅방</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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

        .chat-messages {
            padding: 10px;
            overflow-y: scroll;
            max-height: 800px;
            height: 600px;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }

        .chat-message {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .chat-message.received .message-bubble {
            background-color: #e1e1e1;
            max-width: 60%;
            word-wrap: break-word;
            border-radius: 20px;
            padding: 8px 12px;
            margin-left: 10px;
        }

        .chat-message.sent .message-bubble {
            background-color: #ff6600;
            color: #fff;
            max-width: 60%;
            word-wrap: break-word;
            border-radius: 20px;
            padding: 8px 12px;
            margin-right: 10px;
            text-align: left;
        }

        .chat-message.sent {
            justify-content: flex-end;
        }

        .message-time {
            font-size: 0.85em;
            color: #888;
            margin-left: 10px;
        }

        .send-button {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .send-button:hover {
            background-color: #e65c00;
        }

        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
        .message-time-left {
	        font-size: 0.85em;
	        color: #888;
	        margin-right: 10px; /* 버블과 시간 간격 */
	    }	
				
		.message-time-right {
	        font-size: 0.85em;
	        color: #888;
	        margin-left: 10px; /* 버블과 시간 간격 */
	        margin-right: 0; /* 오른쪽 여백 제거 */
	    }
	    
	    .date-separator {
	        text-align: center;
	        color: #555;
	        font-weight: bold;
	        margin: 10px 0;
	    }

    </style>
</head>
<body>
    <div class="container">
        <h1>${requestScope.mainTitle }</h1>
        <div class="chat-messages" id="chatMessages">
            <!-- 채팅 메시지가 여기에 표시됩니다. -->
        </div>

        <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
        <button class="send-button" onclick="sendMessage()">전송</button>
    </div>

    <script>
    
	    $(document).ready(function() {
	    	
	    	var roomIdParam = "${requestScope.roomId}";  // JSP 변수 값을 자바스크립트 변수에 할당

	    	
	    	$.ajax({
	    		 url : 'readMessage.do',
	    		 type : 'POST',
	    		 data : {
	    			 roomId : roomIdParam,
	    			 senderType : 'store' //일반 유저입장에서는 store가 보낸거만 읽음처리되게
	    			 },
	    		 success: function(response) {
	    				// roomIdParam에 해당하는 알림 수 버블 숨기기
	    	            //$("#unreadBubble_" + roomIdParam).hide();
	             },
	             error: function(xhr, status, error) {
	                 console.error('오류 발생:', status, error);
	             }
	    	 });
	    	
	    	
	    	
	    });
    
    
        // WebSocket 연결 설정
        const userNo = '${sessionScope.loginUser.userNo}';
        const ucSeq = '${requestScope.ucSeq}';
        const roomId = '${requestScope.roomId}';
        const socket = new WebSocket("ws://" + location.host + "/eats/sc/" + roomId);

        // WebSocket 연결 성공
        socket.onopen = function(event) {
            console.log("WebSocket 연결 성공!!!");
            getMessages();  // 이전 메시지 가져오기
            triggerFakeMessage(roomId);
        };

        // WebSocket으로부터 메시지를 수신
        socket.onmessage = function(event) {
            const message = JSON.parse(event.data);
            displayMessage(message.senderType, message.message, message.sentAt);
        };

        // WebSocket 연결 종료
        socket.onclose = function(event) {
            console.log("WebSocket 연결 종료");
        };
        
     	// 메시지 입력 필드에서 엔터 키를 누르면 메시지 전송
        $('#messageInput').keypress(function(event) {
            if (event.which === 13) {  // 'Enter' 키의 keycode는 13
                event.preventDefault(); // 기본 엔터 동작(줄바꿈) 방지
                sendMessage(); // 메시지 전송 함수 호출
            }
        });

        // 메시지 전송 함수
        function sendMessage() {
            const input = document.getElementById("messageInput").value;
            if (input.trim() === "") {
                alert("메시지를 입력하세요");
                return;
            }

            const now = new Date();                  
            const year = now.getFullYear();  // 연도
            const month = String(now.getMonth() + 1).padStart(2, '0');  // 월 (0부터 시작하므로 +1), 2자리로 변환
            const day = String(now.getDate()).padStart(2, '0');  // 일, 2자리로 변환
            const hours = String(now.getHours()).padStart(2, '0');  // 시, 2자리로 변환
            const minutes = String(now.getMinutes()).padStart(2, '0');  // 분, 2자리로 변환
            const seconds = String(now.getSeconds()).padStart(2, '0');  // 초, 2자리로 변환
    		
            
            // 로컬 시간으로 YYYY-MM-DD HH:MM:SS 형식 만들기
            const formattedDateTime = `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}`;

            const message = {
                roomId: roomId,
                senderType: "user",
                userNo: userNo,
                ucSeq: ucSeq,
                message: input,
                sentAt: formattedDateTime
            };

            socket.send(JSON.stringify(message));

            document.getElementById("messageInput").value = "";
        }

     	// 날짜 구분을 위한 변수 저장
        let lastDate = '';
        
        
        // 메시지를 화면에 표시하는 함수
        function displayMessage(senderType, message ,sentAt) {
            
        	
        	
        	
        	let msg = '';
            const time = formatTime(sentAt.split(' ')[1]);
			
            const currentDate = sentAt.split(' ')[0]; // YYYY-MM-DD 형식에서 날짜 부분만 추출
            
            
            
            // 새로운 메시지마다 이전 메시지와 날짜를 비교하여 날짜가 달라지면 날짜 구분선을 추가
            if (lastDate !== currentDate) {
                msg += `<div class="date-separator"><strong>\${formatDate(currentDate)}</strong></div>`;
                lastDate = currentDate; // 마지막 메시지 날짜 업데이트
            }
            
            if (senderType == 'user') {
            	msg += `<div class="chat-message sent">
    				<span class="message-time-left">\${time}</span> <!-- 시간 왼쪽 -->
    				<span class="message-bubble">\${ message }</span>
    			</div>`;
            	
            } else {
            	msg += `<div class="chat-message received">
    				<span class="sender">${data.USR_NM}</span>
    				<span class="message-bubble">\${message}</span>
    				<span class="message-time-right">\${time}</span> <!-- 시간 오른쪽 -->
    			</div>`;
            }

            document.getElementById("chatMessages").innerHTML += msg;
            document.getElementById("chatMessages").scrollTop = document.getElementById("chatMessages").scrollHeight;
        }

        
	     // 날짜 형식을 'YYYY-MM-DD'에서 'YYYY년 MM월 DD일' 형식으로 변환
	   	 function formatDate(dateString) {
	   	     const date = new Date(dateString);
	   	     const year = date.getFullYear(); // 연도
	   	     const month = date.getMonth() + 1; // 월 (0부터 시작하므로 +1)
	   	     const day = date.getDate(); // 일
	   	
	   	     return `\${year}년 \${month}월 \${day}일`; // 'YYYY년 MM월 DD일' 형식으로 반환
	   	 }
        // 시간을 오전/오후 형식으로 변환
        function formatTime(timeString) {
            const [hours, minutes] = timeString.split(':');
            const hoursInt = parseInt(hours);
            const period = hoursInt >= 12 ? '오후' : '오전';
            const formattedHours = hoursInt % 12 || 12;
            return `\${period} \${formattedHours}:\${minutes}`;
        }
        
        
        // 이전 메시지를 가져오는 함수
        function getMessages() {
            $.ajax({
                url: 'getPreviousMessages.do',
                type: 'POST',
                dataType: 'json',
                data: {
                    roomId: ucSeq + "-" + userNo
                },
                success: function(response) {
                	
                	console.log(response);
                    response.forEach(function(message) {
                        displayMessage(message.senderType, message.message, message.sentAt);
                    });
                },
                error: function(xhr, status, error) {
                    console.error('이전 메시지를 가져오는 중 오류 발생:', status, error);
                }
            });
        }
        
        function triggerFakeMessage(roomId) {
        	
            const message = {
                    roomId: roomId,  // UC_SEQ와 USER_NO로 채팅방 식별
                    senderType: "fake",        // 사용자 발신
                    userNo: 0,            // 발신자의 USER_NO
                    ucSeq: 0,
                    message: "fake",            // 메시지 내용
                    sentAt: "fake"  // 메시지 전송 날짜 및 시간
                };
     
                // 메시지를 서버로 전송
                socket.send(JSON.stringify(message));
        }
        
        
    </script>
</body>
</html>