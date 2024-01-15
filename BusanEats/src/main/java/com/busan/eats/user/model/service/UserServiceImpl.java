package com.busan.eats.user.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busan.eats.user.model.dao.UserDao;
import com.busan.eats.user.model.vo.User;


@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;

	@Autowired //의존성을 주입한다. =>
	private SqlSessionTemplate sqlSession; // 기존의 mybatis의 sqlSession 대체
	

	@Override
	public User loginUser(User user) {
		return null;
	}

	@Override
	public int insertUser(User user) {
		return userDao.insertUser(sqlSession,user);
	}

	@Override
	public int updateUser(User user) {
		return 0;
	}

	@Override
	public int deleteUser(String userId) {
		return 0;
	}

	@Override
	public int idCheck(String checkId) {
		return 0;
	}

}
