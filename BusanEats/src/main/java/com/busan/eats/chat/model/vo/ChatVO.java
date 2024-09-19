package com.busan.eats.chat.model.vo;

import lombok.Data;

@Data
public class ChatVO {
	 private Long messageId;
	 private String roomId;
	 private String senderType;
	 private String message;
	 private String sentAt;
	 private int userNo;  // 새로 추가
	 private int ucSeq;  // 새로 추가

}
