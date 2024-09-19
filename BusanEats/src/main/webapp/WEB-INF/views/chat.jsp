<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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
            console.log(message.senderType);
            console.log(message.message,);
            console.log(message.userNo);
            displayMessage(message.senderType, message.message, message.userNo);  // 수신된 메시지 표시
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
            const input = $("#messageInput").val();
            if (input.trim() === "") {
                alert("메시지를 입력하세요");
                return;
            }
			
            // 현재 날짜 및 시간
            const now = new Date();

            // 날짜 형식: YYYY-MM-DD
            const formattedDate = now.getFullYear() + '-' + 
                                  String(now.getMonth() + 1).padStart(2, '0') + '-' + 
                                  String(now.getDate()).padStart(2, '0');

            // 시간 형식: HH:MM:SS (24시간 형식)
            const formattedTime = String(now.getHours()).padStart(2, '0') + ':' + 
                                  String(now.getMinutes()).padStart(2, '0') + ':' + 
                                  String(now.getSeconds()).padStart(2, '0');

            // 날짜와 시간을 합친 형식: YYYY-MM-DD HH:MM:SS
            const formattedDateTime = formattedDate + ' ' + formattedTime;

            console.log(`Formatted DateTime: ${formattedDateTime}`);

            // 서버로 보낼 메시지 객체
            const message = {
                roomId: ucSeq.toString()+"-"+ userNo.toString(),  // UC_SEQ 값으로 채팅방 식별
                senderType: "user",        // USER_NO에 따라 발신자 구분
                userNo: userNo,            // 발신자의 USER_NO
                ucSeq: ucSeq,
                message: input,            // 메시지 내용
                sentAt: formattedDateTime  // 메시지 전송 날짜 및 시간 (YYYY-MM-DD HH:MM:SS)
            };

            // 메시지를 서버로 전송
            socket.send(JSON.stringify(message));

            // 보낸 메시지를 화면에 표시
            //displayMessage("나", input, true);

            // 입력 필드를 비우기
            document.getElementById("messageInput").value = "";
        }

        // 메시지를 화면에 표시하는 함수
        function displayMessage(sender, message, userNo) {
            const messageList = document.getElementById("messageList");
            const newMessage = document.createElement("li");
			
            // 보낸 메시지는 '나'로 표시
            if (userNo == 9) {
                newMessage.textContent = `나:` + message;
                newMessage.style.color = 'blue'; // 보낸 메시지 색상
            } else {
                newMessage.textContent = `${sender}: ` + message;
                newMessage.style.color = 'green'; // 받은 메시지 색상
            }

            messageList.appendChild(newMessage);
            messageList.scrollTop = messageList.scrollHeight;  // 스크롤을 최신 메시지로
        }
    </script>
</body>
</html>
