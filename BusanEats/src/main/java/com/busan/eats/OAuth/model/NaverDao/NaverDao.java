package com.busan.eats.OAuth.model.NaverDao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.user.model.vo.User;

@Repository
public class NaverDao {
	
	public int emailCheck(SqlSessionTemplate sqlSession, String email) {
		System.out.println(email);
		return sqlSession.selectOne("userMapper.emailCheck",email);
	}
	
	public int naverInsert(SqlSessionTemplate sqlSession, User user) {
		return sqlSession.selectOne("userMapper.naverInsert",user);
	}
	
	public User loginNaver(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("userMapper.loginNaver",email);
	}

}
