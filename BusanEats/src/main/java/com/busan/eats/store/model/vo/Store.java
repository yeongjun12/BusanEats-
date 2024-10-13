package com.busan.eats.store.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Store {
	
	 	private int ucSeq;
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
	    private int count;
	    //private double averageRating; // 가게 평점 평균
	    private String storeType;
	    
	 
	    

}
