package com.busan.eats.store.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.store.model.vo.Store;

@Repository
public class StoreDao {
	
	public int saveToDataBase(SqlSessionTemplate sqlSession, Store s) {
		return sqlSession.insert("storeMapper.saveToDataBase",s);
	}

}
