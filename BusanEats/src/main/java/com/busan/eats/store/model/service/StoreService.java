package com.busan.eats.store.model.service;

import com.busan.eats.store.model.vo.Store;

public interface StoreService {
	
	//DB삽입
	int saveToDataBase(Store s);

}
