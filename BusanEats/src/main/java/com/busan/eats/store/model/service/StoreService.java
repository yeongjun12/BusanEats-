package com.busan.eats.store.model.service;

import java.util.ArrayList;

import com.busan.eats.chat.model.vo.ChatVO;
import com.busan.eats.store.model.vo.Store;
import com.busan.eats.store.model.vo.StoreUser;

public interface StoreService {
	
	//DB삽입
	int saveToDataBase(Store s);
	
	//구별로 가게 리스트 select
	ArrayList<Store> selectStoreList(String gugunNm);
	
	//가게 상세 정보 select
	Store selectStoreDetail(int ucSeq);
	
	ArrayList selectLikeList(int userNo);
	
	//조회수 증가
	int increaseCount(int ucSeq);
	
	//식당 좋아요 조회
	int selectStoreLike(int ucSeq);
	
	//식당 평점 평균
	double selectAvgRating(int ucSeq);
	
	//식당 리뷰 숫자 count
	int selectReviewCount(int ucSeq);
	
	//식당 좋아요 숫자 count
	int selectLikeCount(int ucSeq);
	
	//검색창 검색해서 조회
	ArrayList<Store> searchStore(String query); 
	
	//지역 TOP5 조회
	ArrayList<Store> selectRegionTop5(String region); 
	
	//식당 회원 로그인
	StoreUser storeLogin(StoreUser s_user);
	
	//식당 채팅 조회
	ArrayList<ChatVO> checkNewChat(int ucSeq);

}
