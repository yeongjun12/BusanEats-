package com.busan.eats.store.model.service;

import java.util.ArrayList;

import com.busan.eats.store.model.vo.Store;

public interface StoreService {
	
	//DB삽입
	int saveToDataBase(Store s);
	
	ArrayList<Store> selectStoreList(String gugunNm);
	
	
	

}
