package com.busan.eats.reservation.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.busan.eats.reservation.model.service.ReservationService;
import com.busan.eats.reservation.model.vo.Reservation;
import com.busan.eats.user.model.vo.User;
import com.google.gson.Gson;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService reservationService;
	
	@RequestMapping("insertReservation.do")
	public ModelAndView insertReservation(ModelAndView mv, Reservation r) {
		
		int result = reservationService.insertReservation(r);	
		
		if(result > 0) {
			System.out.println("성공!");
		} else {
			System.out.println("실패!");
		}
		
		return mv;
	}
	
	//예약 정보 select
	@ResponseBody
	@RequestMapping(value="selectReservation.do" , produces="application/json; charset=UTF-8" )
	public String selectReservation(HttpSession session) {
		ArrayList<Reservation> list = new ArrayList();
		int userNo = ((User)session.getAttribute("loginUser")).getUserNo();
		
		list = reservationService.selectReservation(userNo);
		System.out.println(list);
		return new Gson().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping("cancelReservation.do")
	public String cancelReservation(int reservation_no) {
		
		reservationService.cancelReservation(reservation_no);
		
		return "success";
	}
	
}
