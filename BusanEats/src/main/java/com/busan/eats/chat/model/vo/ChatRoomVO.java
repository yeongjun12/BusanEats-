package com.busan.eats.chat.model.vo;

import lombok.Data;

@Data
public class ChatRoomVO {
	 private String roomId;
	 private int ucSeq;
	 private int userNo;
	 private String createdAt;
	 private String lastMessageAt;

}
