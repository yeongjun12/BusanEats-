package com.busan.eats.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.busan.eats.reservation.model.service.ReservationService;
import com.busan.eats.reservation.model.vo.Reservation;

@Controller
public class reservationController {

	@Autowired
	private ReservationService reservationService;
	
	@RequestMapping("insertReservation.do")
	public ModelAndView insertReservation(ModelAndView mv, Reservation r) {
		
		System.out.println(r);
		int result = reservationService.insertReservation(r);	
		
		if(result > 0) {
			System.out.println("성공!");
		} else {
			System.out.println("실패!");
		}
		
		
		
		return mv;
	}
}
