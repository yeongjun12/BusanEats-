package com.busan.eats.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.user.model.vo.User;

@Repository
public class UserDao {
	
	public int insertUser(SqlSessionTemplate sqlSession, User user) {
		
		return sqlSession.insert("userMapper.insertUser", user);
	}

}
