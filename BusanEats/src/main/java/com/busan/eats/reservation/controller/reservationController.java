package com.busan.eats.reservation.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.busan.eats.reservation.model.service.ReservationService;
import com.busan.eats.reservation.model.vo.Reservation;
import com.google.gson.Gson;

@Controller
public class reservationController {

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
	
	@ResponseBody
	@RequestMapping(value="selectReservation.do" , produces="application/json; charset=UTF-8" )
	public String selectReservation(int userNo) {
		
		
		System.out.println(reservationService.selectReservation(userNo));
		ArrayList<Reservation> list = new ArrayList();
		
		list = reservationService.selectReservation(userNo);
		
		return new Gson().toJson(list);
	}
	
	
}
