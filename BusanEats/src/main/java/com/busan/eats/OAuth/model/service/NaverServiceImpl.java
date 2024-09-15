package com.busan.eats.OAuth.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busan.eats.OAuth.model.NaverDao.NaverDao;
import com.busan.eats.user.model.vo.User;

@Service
public class NaverServiceImpl implements NaverService {
	

	@Autowired
	private NaverDao naverDao;

	@Autowired //의존성을 주입한다. =>
	private SqlSessionTemplate sqlSession; // 기존의 mybatis의 sqlSession 대체
	
	@Override
	public int emailCheck(String email) {
		return naverDao.emailCheck(sqlSession, email);
	}

	@Override
	public int naverInsert(User user) {
		return naverDao.naverInsert(sqlSession, user);
	}

	@Override
	public User loginNaver(String email) {
		return naverDao.loginNaver(sqlSession,email);
	}

}
