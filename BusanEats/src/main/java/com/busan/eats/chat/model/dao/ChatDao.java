package com.busan.eats.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.busan.eats.chat.model.vo.ChatRoomVO;
import com.busan.eats.chat.model.vo.ChatVO;

@Repository	
public class ChatDao {
	
	    public ChatRoomVO getChatRoom(SqlSession sqlSession, String roomId) {
	        return sqlSession.selectOne("chatMapper.getChatRoom", roomId);
	    }

	    public void createChatRoom(SqlSession sqlSession, ChatRoomVO chatRoomVO) {
	        sqlSession.insert("chatMapper.createChatRoom", chatRoomVO);
	    }

	    public List<ChatVO> getMessages(SqlSession sqlSession, int roomId) {
	        return sqlSession.selectList("chatMapper.getMessages", roomId);
	    }

	    public void saveMessage(SqlSession sqlSession, ChatVO chatVO) {
	        sqlSession.insert("chatMapper.saveMessage", chatVO);
	    }

}
