package com.busan.eats.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.busan.eats.review.model.service.ReviewService;
import com.busan.eats.review.model.vo.Review;
@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@ResponseBody
	@RequestMapping("reviewInsert.do")
	public String reviewInsert( Review r, MultipartFile upfile, HttpSession session, Model model) {
			
		
		
		if(upfile != null && !upfile.getOriginalFilename().isEmpty()) {
			
			String originName = upfile.getOriginalFilename();
			
			
			// "20221226103530"(년월일시분초)
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			//12321(5자리 랜덤값)
			
			int ranNum = (int)(Math.random()*90000+10000);
			// 확장자
			String ext = originName.substring(originName.lastIndexOf("."));
			
			String changeName = currentTime + ranNum + ext;
			
			// 업로드 시키고자 하는 폴더의 물리적인 경로 알아내기
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		
			r.setFilePath(upfile.getOriginalFilename()); //원본명
			r.setChangeName("resources/uploadFiles/" + saveFile(upfile, session));
			
		} 
		
		
		if(reviewService.insertReview(r)> 0) { //성공 => 해당 식당 정보 페이지
			return "success";
			
		} else {
			return "error";
		}
	}
	
	
	//파일 첨부 관련 메소드
	public String saveFile(MultipartFile upfile, HttpSession session) { // 실제 넘어온 파일의 이름을 변경해서 서버에 업로드
		
		// 파일 명 수정 작업 후 서버에 업로드 시키기("image.png" =? 202212371232.png)
		String originName = upfile.getOriginalFilename();
		
		
		// "20221226103530"(년월일시분초)
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		//12321(5자리 랜덤값)
		int ranNum = (int)(Math.random()*90000+10000);
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ranNum + ext;
		
		// 업로드 시키고자 하는 폴더의 물리적인 경로 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
		
	}
}
