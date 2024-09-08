package com.busan.eats.user.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.busan.eats.review.model.service.ReviewServiceImpl;
import com.busan.eats.review.model.vo.Review;
import com.busan.eats.user.model.service.UserServiceImpl;
import com.busan.eats.user.model.vo.User;

@Controller
public class UserController {
	
	@Autowired
	private UserServiceImpl userService;
	
	@Autowired
	private ReviewServiceImpl reviewService;
	
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
	public ModelAndView myPage(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		int userNo = ((User)session.getAttribute("loginUser")).getUserNo();
		
		ArrayList<Review> reviewList = reviewService.myReviews(userNo);
		
		Map<String, Integer> map = userService.myPage(userNo); // 좋아요, 리뷰, 예약 개수 담아옴
		
		
		mv.addObject("map", map)
		  .addObject("reviewList",reviewList)
	      .setViewName("user/myPage");
		
		return mv;
	}
	
	@RequestMapping("myPage2.do")
	public String mypage2() {
		return "user/myPage2";
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
	
	@RequestMapping("deleteUser.do")
	public String deleteUser(int userNo, HttpSession session) {
		if(userService.deleteUser(userNo) > 0 ) {
			//탈퇴처리 성공 => session에서 loginUser지움, alert문구 담기 => 메인페이지 url요청
			  session.removeAttribute("loginUser");
			  session.setAttribute("alertMsg", "탈퇴 되었습니다.");
			  
			  return "redirect:/";
		}else {
			  session.setAttribute("errorMsg", "실패");
			  return "common/errorPage";
		  }
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
