package com.busan.eats.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.user.model.vo.User;

@Repository
public class UserDao {
	
	
	public User loginUser(SqlSessionTemplate sqlSession, User user) {
		return sqlSession.selectOne("userMapper.loginUser",user);
	}
	
	public int insertUser(SqlSessionTemplate sqlSession, User user) {
		
		return sqlSession.insert("userMapper.insertUser", user);
	}
	
	public int updateUser(SqlSessionTemplate sqlSession, User user) {
		return sqlSession.update("userMapper.updateUser", user);
	}

}
