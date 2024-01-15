package com.busan.eats.store.model.service;

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

}
