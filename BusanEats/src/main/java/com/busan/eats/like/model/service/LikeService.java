package com.busan.eats.like.model.service;

import java.util.ArrayList;

import com.busan.eats.like.model.vo.Like;

public interface LikeService {
	
	int insertLike(Like like);
	
	int deleteLike(Like like);
	
	ArrayList<Like> selectLikeList(int userNo);

}
