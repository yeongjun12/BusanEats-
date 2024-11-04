package com.busan.eats.OAuth;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.busan.eats.user.model.service.UserServiceImpl;
import com.busan.eats.user.model.vo.User;

@Controller
public class KakaoController {
	
	@Autowired
	private UserServiceImpl userService;
	
	@PostMapping("kakaoLogin")
	@ResponseBody
	public ResponseEntity<String> kakaoLogin(User user, HttpSession session) {
	    // userId를 이용해 사용자 확인 및 로그인 처리
		boolean userExists = userService.checkUserExists(user.getUserId());

	    if (!userExists) {
	        // 회원가입 로직
	        userService.registerKakaoUser(user);
	    }
	    // 로그인 처리 (세션 설정 등)
	    User loginUser = userService.loginUser(user);
	    session.setAttribute("loginUser", loginUser);
	    // 성공 메시지를 반환하여 클라이언트에서 페이지 이동 처리
	    return ResponseEntity.ok("success");
	}
 

}
