package com.busan.eats.chat.model.vo;

import lombok.Data;

@Data
public class ChatVO {
	 private Long messageId;
	 private String roomId;
	 private String senderType;
	 private String message;
	 private String sentAt;
	 private Integer userNo;  // 새로 추가
	 private Integer ucSeq;  // 새로 추가
	 private int unread_count;  // 새로 추가
	 private String mainTitle;  // 새로 추가
	 private String userName;

}
