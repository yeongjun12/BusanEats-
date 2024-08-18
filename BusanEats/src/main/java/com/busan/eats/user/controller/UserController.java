package com.busan.eats.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	
	@RequestMapping("login.do")
	public ModelAndView login(User user, ModelAndView mv,  HttpSession session) {
		
		
		User loginUser = userService.loginUser(user);
		
		if(loginUser != null && bcryptPasswordEncoder.matches(user.getUserPwd(),loginUser.getUserPwd())) {
			session.setAttribute("loginUser",loginUser);
		    mv.setViewName("redirect:/");
			  
	    } else {
		 // model.addAttribute("키","밸류");
		 mv.addObject("errorMsg","응 안돼!");
	     mv.setViewName("common/errorPage");
	    }
		
		
		return mv;
	}
	
	@RequestMapping("logout.do")
	public String logoutUser(HttpSession session) {
		
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("myPage.do")
	public String MyPage() {
		return "user/myPage";
	}
	
	@RequestMapping("test.do")
	public String Test() {
		return "user/NewFile";
	}
	
	
	@RequestMapping("update.do")
	public String updateUser(String newPwd,User user ) {
		
		
		 String encPwd = bcryptPasswordEncoder.encode(newPwd);
			
		 user.setUserPwd(encPwd);
		
		userService.updateUser(user);
		
		return "redirect:myPage.do";
	}
	
	@ResponseBody
	@RequestMapping(value="pwdCheck.do", produces="text/html; charset=UTF-8")
	public String pwdCheck(String userId, String userPwd, HttpSession session) {
		
		 // 세션에 저장된 사용자 아이디와 비밀번호 가져오기
		User loginUser = (User) session.getAttribute("loginUser");
        String storedUserId = loginUser.getUserId();
        String storedUserPwd = loginUser.getUserPwd();
        
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // 입력한 아이디와 비밀번호가 세션에 저장된 값과 일치하는지 확인
        if (userId.equals(storedUserId) && encoder.matches(userPwd, storedUserPwd)) {
        	return "success"; // 아이디와 비밀번호 모두 일치
        } else {
            return "failure"; // 아이디 또는 비밀번호가 일치하지 않음
        }
	}
	
	
	
}
