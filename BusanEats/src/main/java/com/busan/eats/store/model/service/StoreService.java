package com.busan.eats.store.model.service;

import java.util.ArrayList;

import com.busan.eats.store.model.vo.Store;

public interface StoreService {
	
	//DB삽입
	int saveToDataBase(Store s);
	
	//구별로 가게 리스트 select
	ArrayList<Store> selectStoreList(String gugunNm);
	
	//가게 상세 정보 select
	Store selectStoreDetail(int unSeq);
	
	ArrayList selectLikeList(int userNo);

}
