package com.busan.eats.chat.handler;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.busan.eats.chat.model.vo.ChatVO;
import com.fasterxml.jackson.databind.ObjectMapper;

public class WebSocketBasicServer extends TextWebSocketHandler {

    // roomId를 키로 하고, 해당 방에 속한 세션들을 값으로 가지는 맵
    private static Map<String, Set<WebSocketSession>> chatRooms = new HashMap<>();
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("새로운 WebSocket 연결: " + session.getId());
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        ChatVO chatMessage = objectMapper.readValue(payload, ChatVO.class);
        
        System.out.println(message);
        // roomId를 기준으로 해당 방에 있는 세션들에게만 메시지 전송
        String roomId = chatMessage.getRoomId();
        Set<WebSocketSession> roomSessions = chatRooms.get(roomId);

        if (roomSessions == null) {
            roomSessions = new HashSet<>();
            chatRooms.put(roomId, roomSessions);
        }

        // 현재 세션이 해당 roomId에 없으면 추가
        roomSessions.add(session);

        // roomId에 있는 모든 세션에 메시지 전송
        for (WebSocketSession s : roomSessions) {
            if (s.isOpen()) {
                s.sendMessage(new TextMessage(objectMapper.writeValueAsString(chatMessage)));
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, org.springframework.web.socket.CloseStatus status) throws Exception {
        // 모든 채팅방에서 해당 세션을 제거
        chatRooms.values().forEach(sessions -> sessions.remove(session));
        System.out.println("WebSocket 연결 종료: " + session.getId());
    }
}