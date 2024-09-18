package com.busan.eats.chat.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busan.eats.chat.model.dao.ChatDao;
import com.busan.eats.chat.model.vo.ChatRoomVO;
import com.busan.eats.chat.model.vo.ChatVO;

@Service
public class CharServiceImpl implements ChatService {
	
    @Autowired
    private ChatDao chatDao;
    
    @Autowired //의존성을 주입한다. =>
	private SqlSessionTemplate sqlSession;

	@Override
	public ChatRoomVO getOrCreateRoom(int ucSeq, int userNo) {
		String roomId = ucSeq + "&" + userNo;
		ChatRoomVO chatRoom = chatDao.getChatRoom(sqlSession, roomId);
        
        if (chatRoom == null) {
            chatRoom = new ChatRoomVO();
            chatRoom.setRoomId(roomId);  // roomId 설정
            chatRoom.setUcSeq(ucSeq);    // 식당 ID 설정
            chatRoom.setUserNo(userNo);  // 사용자 ID 설정
            chatDao.createChatRoom(sqlSession, chatRoom);
        }

        return chatRoom;
	}

	@Override
	public List<ChatVO> getMessages(int roomId) {
		return chatDao.getMessages(sqlSession, roomId);
	}

	@Override
	public void saveMessage(ChatVO chatVO) {
		 chatDao.saveMessage(sqlSession, chatVO);
	} 



   

}
