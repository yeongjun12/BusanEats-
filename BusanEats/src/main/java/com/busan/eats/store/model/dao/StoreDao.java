package com.busan.eats.store.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.store.model.vo.Store;

@Repository
public class StoreDao {
	
	public int saveToDataBase(SqlSessionTemplate sqlSession, Store s) {
		return sqlSession.insert("storeMapper.saveToDataBase",s);
	}
	
	
	public ArrayList<Store> selectStoreList(SqlSessionTemplate sqlSession,String gugunNm) {
		return (ArrayList)sqlSession.selectList("storeMapper.selectStoreList",gugunNm);
	}
	
	public Store selectStoreDetail(SqlSessionTemplate sqlSession, int unSeq) {
		return sqlSession.selectOne("storeMapper.selectStoreDetail",unSeq);
	}
	
	public ArrayList selectLikeList(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("storeMapper.selectLikeList", userNo);
	}
	
	public int increaseCount(SqlSessionTemplate sqlSession, int ucSeq) {
		return sqlSession.update("storeMapper.increaseCount", ucSeq);
	}
	
	public int selectStoreLike(SqlSessionTemplate sqlSession, int ucSeq) {
		return sqlSession.selectOne("storeMapper.selectStoreLike", ucSeq);
	}
	
	public double selectAvgRating(SqlSessionTemplate sqlSession, int ucSeq) {
		return sqlSession.selectOne("storeMapper.selectAvgRating", ucSeq);
	}
	public int selectReviewCount(SqlSessionTemplate sqlSession, int ucSeq) {
		return sqlSession.selectOne("storeMapper.selectReviewCount", ucSeq);
	}


}
