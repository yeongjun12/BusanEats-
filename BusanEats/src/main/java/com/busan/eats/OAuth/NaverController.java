package com.busan.eats.OAuth;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.busan.eats.OAuth.model.service.NaverService;
import com.busan.eats.user.model.vo.User;

@Controller
public class NaverController {

    @Autowired
    private NaverService naverService; // 네이버 서비스 (회원가입 및 로그인 처리)
    
    @RequestMapping(value="callback", method=RequestMethod.GET)
    public String callBack(){
        return "callback";
    }
    
    // 네이버 로그인 콜백을 처리하는 메서드
    @ResponseBody
    @PostMapping("naverLogin")
    public String handleNaverLogin(User user,HttpSession session) {
        
            String result ="";
            // 회원 여부 확인
            
            if (naverService.emailCheck(user.getUserEmail()) > 0) {
                // 기존 회원인 경우 로그인 처리
                System.out.println("기존 회원 로그인 처리");
                User loginUser = naverService.loginNaver(user.getUserEmail());
                result = loginUser != null ? "success" : "Fail";
                session.setAttribute("loginUser", loginUser);
            } else {
                // 신규 회원 가입 처리
                System.out.println("신규 회원 가입 처리");
                result = naverService.naverInsert(user) > 0 ? "success" : "Fail";
                session.setAttribute("loginUser", user);
            }
            
            // 성공 응답 전송
            return result;
       
    }
}
