package com.busan.eats.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.busan.eats.user.model.service.UserServiceImpl;
import com.busan.eats.user.model.vo.User;

@Controller
public class UserController {
	
	@Autowired
	private UserServiceImpl userService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	@RequestMapping("joinEnrollForm")
	public String joinEnrollForm() {
		
		return "user/joinEnrollForm";
	}
	
	//회원가입
	@RequestMapping("insertUser")
	public String insertUser(User user, Model model) {
		
		//암호화 작업(암호문을 만들어내는 과정)
		 String encPwd = bcryptPasswordEncoder.encode(user.getUserPwd());
		
		 user.setUserPwd(encPwd); //User객체에 userPwd 필드에 평문이 아닌 암호문으로 세팅
		
		 System.out.println(user);
		 
		int result = userService.insertUser(user);
		
		if(result > 0 ) { //성공 => 메인페이지 url재요청
			  return "redirect:/";
			  
		  } else { //실패 => 여러 문구를 담아서 에러페이지로 포워딩
			  model.addAttribute("errorMsg","회원가입 실패");
			  
			 // /WEB-INF/views      common/errorPage     .jsp 
			  return "common/errorPage";
		  }
	}
	
	@RequestMapping("loginForm")
	public String loginForm() {
		return "user/loginForm";
	}
}
