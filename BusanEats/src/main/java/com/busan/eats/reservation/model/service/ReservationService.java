package com.busan.eats.reservation.model.service;

import java.util.ArrayList;

import com.busan.eats.reservation.model.vo.Reservation;

public interface ReservationService {
	
	//예약 insert
	int insertReservation(Reservation r);
	
	ArrayList<Reservation> selectReservation(int userNo);

}
