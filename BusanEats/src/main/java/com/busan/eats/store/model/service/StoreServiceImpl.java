package com.busan.eats.store.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busan.eats.store.model.dao.StoreDao;
import com.busan.eats.store.model.vo.Store;

@Service
public class StoreServiceImpl implements StoreService {

	
	@Autowired
	private StoreDao storeDao;
	
	@Autowired //의존성을 주입한다. =>
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public int saveToDataBase(Store s) {
		return storeDao.saveToDataBase(sqlSession,s);
	}


	@Override
	public ArrayList<Store> selectStoreList(String gugunNm) {
		
		return storeDao.selectStoreList(sqlSession,gugunNm);
	}


	@Override
	public Store selectStoreDetail(int unSeq) {
		return storeDao.selectStoreDetail(sqlSession,unSeq);
	}


	@Override
	public ArrayList selectLikeList(int userNo) {
		return storeDao.selectLikeList(sqlSession, userNo);
	}


	@Override
	public int increaseCount(int ucSeq) {
		return storeDao.increaseCount(sqlSession, ucSeq);
	}


	@Override
	public int selectStoreLike(int ucSeq) {
		return storeDao.selectStoreLike(sqlSession, ucSeq);
	}


	@Override
	public double selectAvgRating(int ucSeq) {
		return storeDao.selectAvgRating(sqlSession, ucSeq);
	}


	@Override
	public int selectReviewCount(int ucSeq) {
		return storeDao.selectReviewCount(sqlSession,ucSeq);
	}


	

}
