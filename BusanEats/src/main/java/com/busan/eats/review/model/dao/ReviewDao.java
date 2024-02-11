package com.busan.eats.review.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.review.model.vo.Review;

@Repository
public class ReviewDao {
	
	public int insertReview(Review r, SqlSessionTemplate sqlSession) {
		System.out.println("reviewDao"+ r);
		return sqlSession.insert("reviewMapper.insertReview", r);
	}
	
}
