package com.busan.eats.user.model.vo;

import lombok.Data;

@Data
public class User {
	
	int userNo; //USER_NO	NUMBER
	String userId; //USER_ID	VARCHAR2(20 BYTE)
	String userPwd; //USER_PWD	VARCHAR2(20 BYTE)
	String userPhone; //USER_PHONE	VARCHAR2(20 BYTE)
	String userBirthDate; //USR_BIRTH	DATE
	String userEmail;  //USER_EMAIL	VARCHAR2(20 BYTE)
	String userStatus; //USER_STATUS	VARCHAR2(1 BYTE)

}
