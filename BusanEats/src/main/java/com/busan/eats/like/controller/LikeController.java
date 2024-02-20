package com.busan.eats.like.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.busan.eats.like.model.service.LikeService;
import com.busan.eats.like.model.vo.Like;
import com.busan.eats.user.model.vo.User;

@Controller
public class LikeController {
	
	@Autowired
	private LikeService likeService;
	
	@ResponseBody
	@RequestMapping("insertLike.do")
	public String insertLike(int ucSeq,HttpSession session) {
		System.out.println(ucSeq);
		
		int userNo = ((User)session.getAttribute("loginUser")).getUserNo();
		
		Like like = new Like(userNo,ucSeq); 
		
		int result = likeService.insertLike(like);
		
		// 성공 또는 실패 여부에 따라 적절한 응답 반환
	    if (result > 0) {
	        return "success"; // 성공 시 success 문자열 반환
	    } else {
	        return "failure"; // 실패 시 failure 문자열 반환
	    }
	}

}
