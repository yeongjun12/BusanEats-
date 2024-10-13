package com.busan.eats.store.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.store.model.vo.Store;
import com.busan.eats.store.model.vo.StoreUser;

@Repository
public class StoreDao {
	
	public int saveToDataBase(SqlSessionTemplate sqlSession, Store s) {
		return sqlSession.insert("storeMapper.saveToDataBase",s);
	}
	
	
	public ArrayList<Store> selectStoreList(SqlSessionTemplate sqlSession,Store store, String orderBy) {
		Map<String, Object> params = new HashMap<>();
		params.put("storeType",store.getStoreType());
		params.put("gugunNm",store.getGugunNm());
		params.put("orderBy", orderBy); //map에 담아서 쿼리에서 좋아요,리뷰,조회순 정렬
		
		return (ArrayList)sqlSession.selectList("storeMapper.selectStoreList",params);
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
	
	public ArrayList<Store> selectStoreTypeList(SqlSessionTemplate sqlSession, String type){
		return (ArrayList)sqlSession.selectList("storeMapper.selectStoreTypeList",type);
	}
	
	


}
