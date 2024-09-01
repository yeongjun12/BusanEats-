package com.busan.eats.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Review {
	
	private int userNo;
	private String reviewerId;
	private int ucSeq;
	private int rating;
	private String reviewComment;
	private String reviewCreateDate;
	private String filePath;
	private String changeName;
	private String reviewStatus;
	

}
