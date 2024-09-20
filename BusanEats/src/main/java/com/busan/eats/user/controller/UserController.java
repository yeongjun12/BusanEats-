package com.busan.eats.user.controller;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.busan.eats.common.entity.CertVO;
import com.busan.eats.review.model.service.ReviewServiceImpl;
import com.busan.eats.review.model.vo.Review;
import com.busan.eats.store.model.service.StoreService;
import com.busan.eats.store.model.vo.Store;
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
	
	@Autowired //전제조건? 빈등록을 해야 한다?
	private StoreService storeService;
	
	@Autowired
	private JavaMailSender sender;
	
	@RequestMapping("joinEnrollForm")
	public String joinEnrollForm() {
		
		return "user/joinEnrollForm";
	}
	
	@RequestMapping("main")
	public ModelAndView welcomePage(HttpServletRequest request) {
	    ModelAndView mv = new ModelAndView();
	    System.out.println("dsds");
	    // 쿠키에서 최근 방문한 식당 ID 읽기
	    List<Store> storeList = getStoresFromCookie(request);

	    // 모델에 최근 방문한 식당 목록 추가
	    mv.addObject("storeList", storeList);
	    mv.setViewName("main"); // 웰컴 페이지 JSP 뷰 이름
	    return mv;
	}
	
	private List<Store> getStoresFromCookie(HttpServletRequest request) {
	    Cookie[] cookies = request.getCookies();
	    List<Store> storeList = new ArrayList<>();
	    
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("recentStores".equals(cookie.getName())) {
	                String cookieValue = cookie.getValue();
	                if (cookieValue != null && !cookieValue.isEmpty()) {
	                    String[] storeIds = cookieValue.split("\\|");
	                    for (String storeId : storeIds) {
	                        if (!storeId.isEmpty()) {
	                            Store store = storeService.selectStoreDetail(Integer.parseInt(storeId));
	                            if (store != null) {
	                                storeList.add(store);
	                            }
	                        }
	                    }
	                }
	                break;
	            }
	        }
	    }
	    
	    return storeList;
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
			  return "redirect:/main";
			  
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
	public ModelAndView login(User user, ModelAndView mv,  HttpSession session, HttpServletResponse response
			, HttpServletRequest request) {
		
		
		User loginUser = userService.loginUser(user);
		
		if(loginUser != null && bcryptPasswordEncoder.matches(user.getUserPwd(),loginUser.getUserPwd())) {
			session.setAttribute("loginUser",loginUser);
		    mv.setViewName("redirect:/main");
		    
		    
		    // "아이디 저장" 체크박스 상태 확인
	        String rememberMe = request.getParameter("rememberMe");
	        if ("on".equals(rememberMe)) {
	            // 체크박스가 체크된 경우 쿠키 생성
	            Cookie saveId = new Cookie("saveId", loginUser.getUserId());
	            saveId.setMaxAge(604800); // 쿠키를 7일간 유지 (단위: 초)
	            response.addCookie(saveId);
	        } else {
	            // 체크박스가 해제된 경우 쿠키 삭제
	            Cookie saveId = new Cookie("saveId", null);
	            saveId.setMaxAge(0); // 쿠키 즉시 삭제
	            response.addCookie(saveId);
	        }
			  
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
		return "redirect:/main";
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
			  
			  return "redirect:/main";
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
	
	
	@ResponseBody
	@PostMapping("input")
	public String input(String email, HttpServletRequest request) throws javax.mail.MessagingException {
		
		System.out.println(email);
		
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message,true,"UTF-8");
		
		
		String ip = request.getRemoteAddr();
		String secret = generateSecret();
		CertVO certVo = CertVO
						.builder()
						.who(ip)
						.secret(secret)
						.build();
		
		userService.sendMail(certVo);
		
		// 발신자 설정 (보내는 사람)
		helper.setFrom("BusanEat"); // "your-email@example.com"을 발신자 이메일로 설정
		helper.setTo(email);
		helper.setSubject("BusanEat 인증번호입니다.");
		helper.setText("인증번호 : " + secret);
		sender.send(message);
		
		return "success";
		
	}
	
	public String generateSecret() {
		Random r = new Random();
		int n = r.nextInt(100000);
		Format f = new DecimalFormat("000000");
		String secret = f.format(n);
		
		return secret;
	}
	
	@ResponseBody
	@PostMapping("check")
	public String check(String secret, HttpServletRequest request) {
		CertVO certVo = CertVO.builder()
				 .who(request.getRemoteAddr())
				 .secret(secret).build();
		
		
		boolean result = userService.validate(certVo);
		
		return "result : " + result;
	}
	
}
