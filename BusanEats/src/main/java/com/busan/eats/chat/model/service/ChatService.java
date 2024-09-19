package com.busan.eats.chat.model.service;

import java.util.List;

import com.busan.eats.chat.model.vo.ChatRoomVO;
import com.busan.eats.chat.model.vo.ChatVO;

public interface ChatService {
	ChatRoomVO getOrCreateRoom(String roomId,int userNo, int ucSeq);  // 채팅방 조회 또는 생성
    List<ChatVO> getMessages(String roomId);                // 채팅 메시지 조회
    void saveMessage(ChatVO chatVO);                      // 메시지 저장
    

}
