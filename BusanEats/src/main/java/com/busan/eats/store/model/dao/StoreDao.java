package com.busan.eats.store.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.chat.model.vo.ChatVO;
import com.busan.eats.store.model.vo.Store;
import com.busan.eats.store.model.vo.StoreUser;

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
	
	public ArrayList<Store> searchStore(SqlSessionTemplate sqlSession,String query) {
		return (ArrayList)sqlSession.selectList("storeMapper.searchStore",query);
	}
	
	public int selectLikeCount(SqlSessionTemplate sqlSession, int ucSeq) {
		return sqlSession.selectOne("storeMapper.selectLikeCount",ucSeq);
	}
	
	public ArrayList<Store> selectRegionTop5(SqlSessionTemplate sqlSession,String region) {
		return (ArrayList)sqlSession.selectList("storeMapper.selectRegionTop5",region);
	}
	
	public StoreUser storeLogin(SqlSessionTemplate sqlSession, StoreUser s_user) {
		return sqlSession.selectOne("storeMapper.storeLogin",s_user);
	}
	
	


}
