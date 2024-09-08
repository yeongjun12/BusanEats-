package com.busan.eats.user.model.service;

import java.util.Map;

import com.busan.eats.user.model.vo.User;

public interface UserService {
	
	//로그인 서비스 (select)
	User loginUser(User user);
	
	//회원가입 서비스 (insert)
	int insertUser(User user);
	
	//회원정보수정 서비스(update)
	int updateUser(User user);
	
	//회원 탈퇴 서비스(update)
	int deleteUser(int userNo);
	
	//아이디 중복체크 서비스(select)
	int idCheck(String checkId);
	
	Map<String, Integer> myPage(int userNo);

}
