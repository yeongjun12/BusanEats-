package com.busan.eats.review.model.vo;

import lombok.Data;

@Data
public class Review {
	
	private int userNo;
	private int ucSeq;
	private int rating;
	private String reviewComment;
	private String reviewCreateDate;
	private String filePath;
	private String changeName;
	private String reviewStatus;
	

}
