<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅 리스트</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- CSS 스타일 추가 -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: #333;
        }

        #chatList {
            width: 90%;
            max-width: 600px;
            margin: 20px auto;
            padding: 10px;
        }

        .chat-item {
            position: relative;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 15px;
            margin-bottom: 15px;
            transition: background-color 0.3s;
            cursor: pointer; /* 클릭 가능하게 표시 */
        }

        .chat-item:hover {
            background-color: #f0f0f5;
        }

        .chat-item h3 {
            margin: 0 0 10px 0;
            font-size: 18px;
            color:  #ff6600;
        }

        .chat-item p {
            margin: 0 0 5px 0;
            font-size: 16px;
        }

        .chat-item small {
            font-size: 12px;
            color: #888;
        }

        .no-chat {
            text-align: center;
            font-size: 16px;
            color: #888;
        }

        .unread-count-bubble {
            display: inline-block;
            background-color: #ff6600;
            border-radius: 50%;
            padding: 5px 10px;
            font-size: 14px;
            position: absolute;
            top: 15px;
            right: 20px;
            margin: 0;
            color: white;
        }
    </style>

    <script>
        let g_messageCount = 0;

        $(document).ready(function () {
            console.log('채팅 리스트 로딩 중...');

            // 페이지 로드 시 첫 채팅 목록 가져오기
            loadChatList();

            // 1초마다 새로운 메시지 확인 및 UI 업데이트
            setInterval(loadChatList, 1000);
        });
        // AJAX로 채팅 목록을 새로 불러와서 업데이트하는 함수
        function loadChatList() {
            $.ajax({
                url: "getChatList.do",
                method: "GET",
                data: {
                    userNo: '${sessionScope.loginUser.userNo}',
                    senderType: 'store'
                },
                success: function (response) {
                    // 채팅 리스트가 있는 경우
                    if (response.length > 0) {
                        // 전체 채팅 리스트를 다시 그리기 위해 초기화
                        $("#chatList").empty();
                        g_messageCount = 0;

                        // 채팅 데이터를 반복 처리
                        $.each(response, function (index, chat) {
                            g_messageCount = chat.unread_count;
							
                            const formattedTimestamp = formatChatTimestamp(chat.sentAt);
                            const dateDisplay = formattedTimestamp.date; // e.g., "2024-10-07"
                            const timeDisplay = formattedTimestamp.time; // e.g., "2:53 AM"
                            
                            // unread_count가 0보다 클 경우에만 숫자 버블을 표시
                            var unreadCountBubble = chat.unread_count > 0
                                ? `<p class="unread-count-bubble" id="unreadBubble_\${chat.roomId}">\${chat.unread_count}</p>`
                                : '';

                            // 각 채팅 데이터를 DOM에 추가, 클릭 시 채팅방 열기
                            $("#chatList").append(`
                                <div class='chat-item' onclick='openChatWindow("\${chat.roomId}", "\${chat.ucSeq}","\${chat.mainTitle}")'>
                                    <h3>\${chat.mainTitle}</h3>
                                    <p>\${chat.message}</p>
                                    <small>\${chat.sentAt}</small>
                                    \${unreadCountBubble}
                                </div>
                            `);
                        });
                    } else {
                        // 채팅 리스트가 없는 경우
                        $("#chatList").html("<p class='no-chat'>채팅이 없습니다.</p>");
                    }
                },
                error: function (error) {
                    console.log("채팅 리스트 불러오기 실패:", error);
                }
            });
        }

        // 채팅방을 새 창에서 여는 함수
        function openChatWindow(roomId, ucSeq , mainTitle) {
            console.log("roomId : " + roomId);
            console.log("ucSeq : " + ucSeq);
            console.log("mainTitle : " + mainTitle);
            
            const userNo = '${sessionScope.loginUser.userNo}';
            
            // 새로운 창에서 채팅방을 열기
            const chatWindow = window.open("chatRoom.do?userNo=" + userNo + "&roomId=" + roomId + "&ucSeq=" + ucSeq + "&mainTitle="+mainTitle, "_blank", "width=500,height=700");

            if (!chatWindow) {
                alert("팝업이 차단되었습니다. 팝업 차단을 해제하고 다시 시도하세요.");
            }
        }
        
        function formatChatTimestamp(chatSentAt) {
            // Convert to Date object
            const dateObj = new Date(chatSentAt);

            // Extract the date in YYYY-MM-DD format
            const datePart = dateObj.toISOString().split('T')[0]; // "2024-10-07"

            // Extract the time in 12-hour format
            let hours = dateObj.getHours();
            const minutes = String(dateObj.getMinutes()).padStart(2, '0'); // Ensure two digits
            const ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12; // Convert to 12-hour format
            hours = hours ? String(hours) : '12'; // Adjust '0' to '12'

            const timePart = `${hours}:${minutes} ${ampm}`; // e.g., "2:53 AM"

            return {
                date: datePart,
                time: timePart
            };
        }
    </script>
</head>
<body>
<h1>문의 채팅</h1>
<div id="chatList">
    <!-- 채팅 리스트가 여기에 동적으로 추가됨 -->
</div>
</body>
</html>
