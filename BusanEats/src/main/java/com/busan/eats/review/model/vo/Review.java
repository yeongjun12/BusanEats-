package com.busan.eats.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Review {
	
	private Integer reviewNo;
	private int userNo;
	private String userId;
	private int ucSeq;
	private int rating;
	private String reviewComment;
	private String reviewCreateDate;
	private String filePath;
	private String changeName;
	private String reviewStatus;
	private String mainTitle;
	

}
