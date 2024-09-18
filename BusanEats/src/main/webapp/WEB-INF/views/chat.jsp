<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebSocket 채팅 테스트</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        #chat {
            margin: 0 auto;
            max-width: 600px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        #messageList {
            height: 300px;
            overflow-y: auto;
            border: 1px solid #ccc;
            padding: 5px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
        }
        #messageList li {
            margin-bottom: 5px;
        }
        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin-right: 10px;
        }
        button {
            padding: 10px;
        }
    </style>
</head>
<body>
    <div id="chat">
        <h2>WebSocket 채팅</h2>
        <div id="messageListContainer">
            <ul id="messageList"></ul>
        </div>
        <input type="text" id="messageInput" placeholder="메시지를 입력하세요" />
        <button onclick="sendMessage()">보내기</button>
    </div>

    <script>
        // USER_NO 및 UC_SEQ 설정
        const userNo = 9;  // 테스트 사용자 번호
        const ucSeq = 953; // 테스트 식당 ID

        // WebSocket 연결 설정
        const socket = new WebSocket('ws://localhost:8051/eats/sc');

        // WebSocket 연결 성공
        socket.onopen = function(event) {
            console.log("WebSocket 연결 성공");
        };

        // WebSocket으로부터 메시지를 수신
        socket.onmessage = function(event) {
        	console.log(event);
            const message = JSON.parse(event.data);
            displayMessage(message.senderType, message.message);
        };

        // WebSocket 연결 종료
        socket.onclose = function(event) {
            console.log("WebSocket 연결 종료");
        };

        // WebSocket 에러 처리
        socket.onerror = function(event) {
            console.error("WebSocket 에러: ", event);
        };

        // 메시지 전송 함수
        function sendMessage() {
            const input = document.getElementById("messageInput").value;
            if (input.trim() === "") {
                alert("메시지를 입력하세요");
                return;
            }

            // 서버로 보낼 메시지 객체
            const message = {
                roomId: ucSeq.toString(),  // UC_SEQ 값으로 채팅방 식별
                senderType: "user",        // USER_NO에 따라 발신자 구분
                userNo: userNo,            // 발신자의 USER_NO
                message: input,
                sentAt: new Date().toLocaleTimeString()  // 메시지 전송 시간
            };

            // 메시지를 서버로 전송
            socket.send(JSON.stringify(message));

            // 입력 필드를 비우기
            document.getElementById("messageInput").value = "";
        }

        // 메시지를 화면에 표시하는 함수
        function displayMessage(senderType, message) {
            const messageList = document.getElementById("messageList");
            const newMessage = document.createElement("li");
            newMessage.textContent = `${senderType}: ${message}`;
            messageList.appendChild(newMessage);
            messageList.scrollTop = messageList.scrollHeight;  // 스크롤을 최신 메시지로
        }
    </script>
</body>
</html>