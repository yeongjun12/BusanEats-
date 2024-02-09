package com.busan.eats.reservation.model.vo;

import com.busan.eats.store.model.vo.Store;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Reservation {
	
	
	int reservation_no;
	int user_no;
	int ucSeq;
	String reservation_date;
	String reservation_time;
	int number_of_guest;
	
	private String mainTitle;
    private String gugunNm;
    private String addr1;
    private String cntctTel;
    private String usageDayWeekAndTime;
    private String reprsntvMenu;
    private String mainImgNormal;
    private String mainImgThumb;
    private String itemCntnts;
    private double lat;
    private double lng;
  

 

}
