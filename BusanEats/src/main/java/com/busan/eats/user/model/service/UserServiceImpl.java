package com.busan.eats.user.model.service;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busan.eats.common.entity.CertVO;
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
		return userDao.loginUser(sqlSession,user);
	}

	@Override
	public int insertUser(User user) {
		return userDao.insertUser(sqlSession,user);
	}

	@Override
	public int updateUser(User user) {
		return userDao.updateUser(sqlSession,user);
	}

	@Override
	public int deleteUser(int userNo) {
		return userDao.deleteUser(sqlSession,userNo);
	}

	@Override
	public int idCheck(String checkId) {
		return 0;
	}

	@Override
	public Map<String, Integer> myPage(int userNo) {
		return userDao.myPage(sqlSession,userNo);
	}

	@Override
	public boolean checkUserExists(String userId) {
		return userDao.checkUserExists(sqlSession,userId);
	}

	@Override
	public int registerKakaoUser(User user) {
		return userDao.registerKakaoUser(sqlSession,user);
	}

	@Override
	public void sendMail(CertVO certVo) {
		userDao.insertSecret(sqlSession, certVo);
	}

	@Override
	public boolean validate(CertVO certVo) {
		return userDao.validate(sqlSession, certVo);
	}

}
