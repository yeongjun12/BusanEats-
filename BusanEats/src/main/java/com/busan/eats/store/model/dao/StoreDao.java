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
		
		System.out.println("dao" + gugunNm);
		
		
		
		return (ArrayList)sqlSession.selectList("storeMapper.selectStoreList",gugunNm);
		
		
	}

}
