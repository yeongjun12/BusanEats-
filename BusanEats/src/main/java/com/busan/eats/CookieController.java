package com.busan.eats;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CookieController {
	
	@RequestMapping("create")
	public String  create(HttpServletResponse response) {
		//응답 정보에 첨부
		//쿠키는 객체를 생성한 다음 응답정보에 첨부해야 완전히 발급
		// -name, value는 필수 exprie등은 선택
		// 쿠키는 name과 value가 모두 문자열만 가능(아스키 코드)
		
		Cookie ck = new Cookie("test","yj");
		
		//setMaxAge == 만료시간
		// ck.setMaxAge(10); - 10초
		
		ck.setMaxAge(1 * 24 * 60 * 60); //하루
		
		
		response.addCookie(ck);
		
		return "main2";
		
	}
	
	
	
}
 