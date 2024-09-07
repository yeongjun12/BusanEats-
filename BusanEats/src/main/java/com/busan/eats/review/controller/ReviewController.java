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
import com.busan.eats.user.model.vo.User;
import com.google.gson.Gson;
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
	
	@RequestMapping("updateReview.do")
	public String updateReview(Review r,String reloadPath, HttpSession session,Model model) {
		
		System.out.println(reloadPath);
		if(reviewService.updateReview(r) > 0) {
			session.setAttribute("alertMsg","리뷰가 수정 되었습니다.");
			
			if(reloadPath.equals("myPage.do")) {
				return "redirect:myPage.do"; //마이페이지에서 삭제, 수정시 마이페이지로 redirect
			}else {
				return "redirect:selectStoreDetail.do?ucSeq="+r.getUcSeq();
			}
		}else {
			model.addAttribute("errorMsg","리뷰 수정 실패..");
			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "myReviews.do", produces="application/json; charset=UTF-8")
	public String myReviews(HttpSession session) {
		int userNo = ((User)session.getAttribute("loginUser")).getUserNo();
		ArrayList<Review> list = reviewService.myReviews(userNo);
		
		
		System.out.println(list);
		 return new Gson().toJson(list);
	}
	
	@RequestMapping("deleteReview.do")
	public String deleteReview(int reviewNo, int ucSeq, HttpSession session, Model model, String filePath ) {
		
		if(reviewService.deleteReview(reviewNo) > 0) { //삭제 성공
			if (!filePath.equals("")) { // 만약에 첨부파일이 존재했을 경우
				// 기존에 존재하는 첨부파일을 삭제
				// resources/xxxxxx/xxxx.jpg 요걸 찾ㅇ,려면

				//new File(session.getServletContext().getRealPath(filePath)).delete();
				// 파일 객체를 만들어서 삭제
			}
			session.setAttribute("alertMsg", "삭제 되었습니다.");
			return "redirect:selectStoreDetail.do?ucSeq="+ucSeq;
		}else {//삭제 실패
			model.addAttribute("errorMsg", "리뷰 삭제 실패 ");
			return "common/errorPage";
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
