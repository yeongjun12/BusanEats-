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
        /* 채팅 목록 스타일 */
        .chat-item {
            padding: 10px;
            border: 1px solid #ddd;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        #chatList {
            margin-top: 20px;
        }
        #chatMessages {
            max-height: 300px;
            overflow-y: auto;
            margin-bottom: 10px;
        }
        .chat-message.sent {
            text-align: right;
        }
        .chat-message.received {
            text-align: left;
        }
        .message-bubble {
            display: inline-block;
            padding: 10px;
            border-radius: 10px;
            background-color: #f1f1f1;
            margin: 5px 0;
        }
        
        /* 채팅 모달 스타일 */
	    #chatModal .modal-dialog {
	        max-width: 600px;
	        margin: 30vh auto;
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
	    
	    /* 채팅 2222*/
	    .chat-messages {
	        padding: 10px;
	        overflow-y: scroll; /* 항상 스크롤바 표시 */
	        max-height: 800px;
	        height : 685px;
	    }
	    .chat-message {
	        margin-bottom: 10px;
	        display: flex;
	        align-items: center;
	    }
	    .chat-message.received .message-bubble {
	        background-color: #e1e1e1;
	        max-width: 60%; /* 버블 최대 너비 설정 */
	        word-wrap: break-word; /* 긴 단어 줄바꿈 처리 */
	    }
	    
	    .chat-message.sent .message-bubble {
		    background-color: #ff6600;
		    color: #fff;
		    margin-left: 0; /* 왼쪽 여백 제거 */
		    margin-right: 0; /* 오른쪽 여백 필요 시 추가 */
		    max-width: 60%; /* 버블 최대 너비 설정 */
		    word-wrap: break-word; /* 긴 단어 줄바꿈 처리 */
		    text-align: left; /* 텍스트 정렬 왼쪽 */
		}
		
		.chat-message.sent {
		    justify-content: flex-end; /* 버블을 오른쪽에 배치 */
		    width: 100%; /* 부모 요소가 전체 너비를 가짐 */
		}
		
	    .message-bubble {
	        display: inline-block;
	        padding: 8px 12px;
	        border-radius: 20px;
	    }
	    .chat-message .sender {
	        font-weight: bold;
	        margin-right: 10px;
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

        <!-- 채팅 목록 -->
        <div id="chatList" class="chat-list-container">
            <!-- 여기서 동적으로 채팅 목록이 추가됩니다 -->
        </div>
    </div>

    
    
    <!-- 1:1 채팅 모달 -->
    <div class="modal fade" id="chatModal" tabindex="-1" role="dialog" aria-labelledby="chatModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="chatModalLabel">1:1 채팅</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="chat">
                        <h2>WebSocket 채팅</h2>
                        <div class="chat-messages" id="chatMessages">
					        <!-- 채팅 메시지가 여기에 표시됩니다. -->
					        <div class="chat-message received">            
					        </div>
					        <div class="chat-message sent">
					        </div>
					        <!-- 이하 생략 -->
					    </div>
                        <input type="text" id="messageInput" placeholder="메시지를 입력하세요" />
                        <button onclick="sendMessage()">보내기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery 및 Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

    <!-- 새로운 채팅 여부 확인 스크립트 -->
    <script type="text/javascript">
    let socket;  // WebSocket 객체
    let roomId;  // 선택된 채팅방 ID

    $(document).ready(function() {
        var ucSeq = parseInt("${loginStore.ucSeq}", 10);  // EL로 ucSeq 값을 가져옴
        console.log(ucSeq);  // 제대로 값이 넘어오는지 확인

        // 페이지 로드 시 즉시 채팅 확인
        checkNewChat(ucSeq);

        // 일정 시간마다 채팅 확인 (예: 30초마다)
        setInterval(function() {
            checkNewChat(ucSeq);  // ucSeq 값을 넘겨주며 checkNewChat 함수 실행
        }, 30000);  // 30초마다 실행
    });

    function checkNewChat(ucSeq) {
        console.log("UC_SEQ:", ucSeq);
        $.ajax({
            type: 'GET',
            url: 'checkNewChat.do',
            data: { ucSeq: ucSeq },  // 서버에 넘길 ucSeq 값
            dataType: 'json',
            success: function(response) {
                console.log(response);
                if (response.length > 0) {
                    // 채팅 목록 업데이트 함수 호출
                    updateChatList(response);
                    $('#newChatAlert').show();  // 새로운 채팅이 있으면 알림 표시
                } else {
                    $('#newChatAlert').hide();
                }
            },
            error: function(error) {
                console.log("채팅 확인 중 오류 발생: ", error);
            }
        });
    }

    function updateChatList(chatMessages) {
        var chatListContainer = $('#chatList');
        chatListContainer.empty();  // 기존 채팅 목록 초기화
        chatMessages.forEach(function(chat) {
            var chatItem = `
                <div class="chat-item" onclick="openChatModal('\${chat.roomId}')">
                    <p><strong>Room ID:</strong> \${chat.roomId}</p>
                    <p><strong>Message:</strong> \${chat.message}</p>
                    <p><strong>Sent At:</strong> \${chat.sentAt}</p>
                </div>
                <hr />
            `;
            chatListContainer.append(chatItem);
        });
    }

    // 채팅 목록에서 채팅을 클릭하면 해당 roomId에 따라 모달을 열고 WebSocket 연결 설정
    function openChatModal(roomIdParam) {
    	
    	
        roomId = roomIdParam;  // 선택된 roomId 저장
        
        console.log(roomId);
        $('#chatModal').modal('show');  // 모달 열기
        connectWebSocket(roomId);       // WebSocket 연결
        getMessages(roomId);            // 이전 메시지 가져오기
    }

    // WebSocket 연결 설정
    function connectWebSocket(roomId) {
        socket = new WebSocket("ws://" + location.host + "/eats/sc/" + roomId);

        // WebSocket 연결 성공
        socket.onopen = function(event) {
            console.log("WebSocket 연결 성공: Room ID = " + roomId);
        };

        // WebSocket으로부터 메시지 수신
        socket.onmessage = function(event) {
            const message = JSON.parse(event.data);
            displayMessage(message.senderType, message.message, message.sentAt ,message.userNo);
        };

        // WebSocket 연결 종료
        socket.onclose = function(event) {
            console.log("WebSocket 연결 종료");
        };

        // WebSocket 에러 처리
        socket.onerror = function(event) {
            console.error("WebSocket 에러: ", event);
        };
    }

    // 메시지 전송 함수
    function sendMessage() {
        const input = $("#messageInput").val();
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

        // 로컬 시간으로 YYYY-MM-DD HH:MM 형식 만들기
        const formattedDateTime = `\${year}-\${month}-\${day} \${hours}:\${minutes}`;
        
        
        const message = {
            roomId: roomId,
            senderType: "store",
            userNo: 9999,  // 로그인한 사용자 번호
            ucSeq: ${loginStore.ucSeq},               // 매장 고유 ID
            message: input,
            sentAt: formattedDateTime
        };
        socket.send(JSON.stringify(message));  // 메시지를 WebSocket을 통해 전송
        $("#messageInput").val("");  // 입력 필드 비우기
    }
	
 	// 날짜 구분을 위한 변수 저장
    let lastDate = '';
 	
    // 채팅 메시지 화면에 표시하는 함수
    function displayMessage(senderType, message, sentAt ,userNo) {
        
    	let msg = '';
        
        const currentDate = sentAt.split(' ')[0]; // YYYY-MM-DD 형식에서 날짜 부분만 추출
        const time = formatTime(sentAt.split(' ')[1]); // 시간을 오전/오후 형식으로 변환
     	
        
        // 새로운 메시지마다 이전 메시지와 날짜를 비교하여 날짜가 달라지면 날짜 구분선을 추가
        if (lastDate !== currentDate) {
            msg += `<div class="date-separator"><strong>\${formatDate(currentDate)}</strong></div>`;
            lastDate = currentDate; // 마지막 메시지 날짜 업데이트
        }
        
        if (senderType == 'store') {
            // 본인이 보낸 메시지
            msg += `<div class="chat-message sent">
            	<span class="message-time-left">\${time}</span> <!-- 시간 왼쪽 -->
                <span class="message-bubble">\${message}</span>
            </div>`;
        } else {
            // 상대방이 보낸 메시지
            msg += `<div class="chat-message received">
                <span class="message-bubble">\${message}</span>
                <span class="message-time-right">\${time}</span> <!-- 시간 오른쪽 -->
            </div>`;
        }
        $("#chatMessages").append(msg);

        // 스크롤을 최신 메시지로 이동
        const chatMessages = document.getElementById("chatMessages");
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    // 이전 메시지 가져오는 함수
    function getMessages(roomId) {
        $.ajax({
            url: 'getPreviousMessages.do',
            type: 'POST',
            dataType: 'json',
            data: { roomId: roomId },
            success: function(response) {
                response.forEach(function(message) {
                    displayMessage(message.senderType, message.message, message.sentAt ,message.userNo);
                });
            },
            error: function(xhr, status, error) {
                console.error('이전 메시지를 가져오는 중 오류 발생:', status, error);
            }
        });
    }

    // 모달 닫힐 때 WebSocket 연결 종료
    $('#chatModal').on('hidden.bs.modal', function () {
        if (socket) {
            socket.close();
        }
        $("#chatMessages").empty();  // 채팅 메시지 리스트 비우기
        $('#messageInput').val('');  // 입력 필드를 비움
        
        lastDate = ''; //모달 닫으면 날짜 초기화
    });
    
 	// 날짜 형식을 'YYYY-MM-DD'에서 'YYYY년 MM월 DD일' 형식으로 변환
	 function formatDate(dateString) {
	     const date = new Date(dateString);
	     const year = date.getFullYear(); // 연도
	     const month = date.getMonth() + 1; // 월 (0부터 시작하므로 +1)
	     const day = date.getDate(); // 일
	
	     return `\${year}년 \${month}월 \${day}일`; // 'YYYY년 MM월 DD일' 형식으로 반환
	 }
	
	// 시간을 'HH:MM' 형식에서 '오전/오후 HH:MM'으로 변환
   function formatTime(timeString) {
       const [hours, minutes] = timeString.split(':'); // HH:MM:SS 중에서 HH와 MM 추출
       const hoursInt = parseInt(hours); // 정수형으로 변환
       const period = hoursInt >= 12 ? '오후' : '오전'; // 12시 이상이면 오후, 아니면 오전
       const formattedHours = hoursInt % 12 || 12; // 12시간제로 변환 (0시는 12시로 표시)
       return `\${period} \${formattedHours}:\${minutes}`; // '오전/오후 HH:MM' 형식으로 반환
   }
    
    
    
    
    </script>
</body>
</html>
