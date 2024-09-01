package com.busan.eats.review.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busan.eats.common.model.PageInfo;
import com.busan.eats.review.model.dao.ReviewDao;
import com.busan.eats.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private ReviewDao reviewDao;
	
	
	@Override
	public int insertReview(Review r) {
		return reviewDao.insertReview(r,sqlSession);
	}


	@Override
	public List<Review> selectReview(int ucSeq, PageInfo pi) {
		System.out.println("서비스 : " + ucSeq);
		return reviewDao.selectReview(ucSeq, pi,sqlSession);
	}


	@Override
	public int reviewCount(int ucSeq) {
		return reviewDao.reviewCount(ucSeq,sqlSession);
	}


	@Override
	public ArrayList<Review> selectList(int ucSeq, PageInfo pi) {
		return reviewDao.selectList(ucSeq,pi,sqlSession);
	}

}
