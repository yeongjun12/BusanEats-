package com.busan.eats.OAuth.model.service;

import com.busan.eats.user.model.vo.User;

public interface NaverService {

	// 이메일 중복 체크 메서드: 이미 가입된 이메일인지 확인
	int emailCheck(String email);
	
	// 네이버 사용자를 DB에 등록하는 메서드 (회원가입)
	int naverInsert(User user);
	
	// 네이버 사용자 정보로 로그인 처리하는 메서드
	User loginNaver(String email);
}
