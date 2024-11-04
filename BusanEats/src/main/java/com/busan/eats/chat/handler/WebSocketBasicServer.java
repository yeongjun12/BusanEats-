package com.busan.eats.chat.handler;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.busan.eats.chat.model.service.ChatServiceImpl;
import com.busan.eats.chat.model.vo.ChatVO;
import com.fasterxml.jackson.databind.ObjectMapper;
public class WebSocketBasicServer extends TextWebSocketHandler {

    @Autowired
    private ChatServiceImpl chatService;
    
    // roomId를 키로 하고, 해당 방에 속한 세션들을 값으로 가지는 맵
    private static Map<String, Set<WebSocketSession>> chatRooms = new HashMap<>();
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("새로운 WebSocket 연결: " + session.getId());
        // 세션이 방에 추가되기 전에는 어떤 초기화 작업을 할 수 있습니다.
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        ChatVO chatMessage = objectMapper.readValue(payload, ChatVO.class);
        
        int userNo = chatMessage.getUserNo();
        int ucSeq = chatMessage.getUcSeq();
        
        System.out.println("메시지 : "  + chatMessage.getMessage());
        System.out.println("payload : " + payload);
        
        // roomId를 기준으로 해당 방에 있는 세션들에게만 메시지 전송
        String roomId = chatMessage.getRoomId();
        
        
        // 해당 방의 세션 가져오기
    	Set<WebSocketSession> roomSessions = chatRooms.get(roomId);
        
        if (roomSessions == null) {
            roomSessions = new HashSet<>();
            chatRooms.put(roomId, roomSessions); // 방에 세션 추가
        }

        // 현재 세션이 해당 roomId에 없으면 추가
        if (!roomSessions.contains(session)) {
            roomSessions.add(session);
        }
        
        chatService.getOrCreateRoom(roomId, userNo, ucSeq); //채팅방 먼저 만들고
        // 방이 존재하지 않으면 생성하고 메시지 저장
        if (!"fake".equals(chatMessage.getMessage()) ) { //fake메시지만 거르기
        	
        	//!"fake".equals(chatMessage.getMessage())

            // 현재 열린 방의 세션 수 확인
            // 서로 채팅방 열려있을떄는 읽은 상태인 메시지 전송
            if (roomSessions.size() > 1 ) {
               chatMessage.setUnread_count(1);
               
               chatService.saveMessage(chatMessage); // 다른 요청 메소드 호출
            }else {
               // 메시지 저장
                chatService.saveMessage(chatMessage); // 메시지 저장
            }

        }
        
	     // roomId에 있는 모든 세션에 메시지 브로드캐스트
	        for (WebSocketSession s : roomSessions) {
	            if (s.isOpen()) {
	                s.sendMessage(new TextMessage(objectMapper.writeValueAsString(chatMessage)));
	            }
	        }
        
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, org.springframework.web.socket.CloseStatus status) throws Exception {
        // 모든 채팅방에서 해당 세션을 제거
        chatRooms.forEach((roomId, sessions) -> {
            if (sessions.remove(session)) {
                System.out.println("세션 " + session.getId() + "이(가) 채팅방 " + roomId + "에서 제거되었습니다.");
            }
        });
        System.out.println("WebSocket 연결 종료: " + session.getId());
    }
}
