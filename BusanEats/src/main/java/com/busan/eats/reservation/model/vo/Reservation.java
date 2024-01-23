package com.busan.eats.reservation.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Reservation {
	
	int reservation_no;
	int user_no;
	int ucSeq;
	String reservation_date;
	String reservation_time;
	int number_of_guest;

}
