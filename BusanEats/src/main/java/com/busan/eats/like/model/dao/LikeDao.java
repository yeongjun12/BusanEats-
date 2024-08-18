package com.busan.eats.like.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.like.model.vo.Like;

@Repository
public class LikeDao {
	
	public int insertLike(SqlSessionTemplate sqlSession, Like like){
		return sqlSession.insert("likeMapper.insertLike", like);
	}
	
	public int deleteLike(SqlSessionTemplate sqlSession, Like like) {
		return sqlSession.delete("likeMapper.deleteLike", like);
	}

}
