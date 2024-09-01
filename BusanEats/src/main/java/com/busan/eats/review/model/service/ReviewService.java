package com.busan.eats.review.model.service;

import java.util.ArrayList;
import java.util.List;

import com.busan.eats.common.model.PageInfo;
import com.busan.eats.review.model.vo.Review;

public interface ReviewService {
	
	//리뷰 작성
	int insertReview(Review r);
	
	List<Review> selectReview(int ucSeq, PageInfo pi);
	
	//해당식당 리뷰 수 세기
	int reviewCount(int ucSeq);
	
	//리뷰 리스트 뽑기
	ArrayList<Review> selectList(int ucSeq, PageInfo pi);

}
