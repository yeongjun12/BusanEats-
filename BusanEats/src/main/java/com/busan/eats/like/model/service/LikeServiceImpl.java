package com.busan.eats.like.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busan.eats.like.model.dao.LikeDao;
import com.busan.eats.like.model.vo.Like;

@Service
public class LikeServiceImpl implements LikeService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;	
	@Autowired
	private LikeDao likeDao;
	
	@Override
	public int insertLike(Like like) {
		return likeDao.insertLike(sqlSession,like);
	}

}
