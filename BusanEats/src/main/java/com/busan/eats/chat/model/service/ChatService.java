package com.busan.eats.chat.model.service;

import java.util.List;

import com.busan.eats.chat.model.vo.ChatRoomVO;
import com.busan.eats.chat.model.vo.ChatVO;

public interface ChatService {
	ChatRoomVO getOrCreateRoom(int ucSeq, int userNo);  // 채팅방 조회 또는 생성
    List<ChatVO> getMessages(int roomId);                // 채팅 메시지 조회
    void saveMessage(ChatVO chatVO);                      // 메시지 저장

}
