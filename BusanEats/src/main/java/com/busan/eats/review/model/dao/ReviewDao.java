package com.busan.eats.review.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.common.model.PageInfo;
import com.busan.eats.review.model.vo.Review;

@Repository
public class ReviewDao {
	
	public int insertReview(Review r, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("reviewMapper.insertReview", r);
	}
	
	public List<Review> selectReview(int ucSeq, PageInfo pi,SqlSessionTemplate sqlSession){
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return (List)sqlSession.selectList("reviewMapper.selectReview", ucSeq, rowBounds);
	}
	
	public int reviewCount(int ucSeq, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reviewMapper.reviewCount", ucSeq);
	}
	
	public ArrayList<Review> selectList(int ucSeq, PageInfo pi, SqlSessionTemplate sqlSession){
		
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectList", ucSeq, rowBounds);
		
	}
	
	public int updateReview(Review r, SqlSessionTemplate sqlSession) {
		return sqlSession.update("reviewMapper.updateReview",r);
	}
	
	public ArrayList<Review> myReviews(int userNo, SqlSessionTemplate sqlSession){
		return (ArrayList)sqlSession.selectList("reviewMapper.myReviews",userNo);
	}
	
	public int deleteReview(int reviewNo, SqlSessionTemplate sqlSession) {
		return sqlSession.update("reviewMapper.deleteReview", reviewNo);
	}
	
}
