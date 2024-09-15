package com.busan.eats.user.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.common.entity.CertVO;
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
	
	public Map<String, Integer> myPage(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("userMapper.myPage", userNo);
	}
	
	public int deleteUser(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.update("userMapper.deleteUser",userNo);
	}
	
	public boolean checkUserExists(SqlSessionTemplate sqlSession,String userId) {
		// MyBatis Mapper에 정의된 쿼리를 호출하여 COUNT(*) 결과를 가져옵니다.
	    Integer count = sqlSession.selectOne("userMapper.checkUserExists", userId);
	    
	    // count가 null이 아니고 0보다 크면 true, 그렇지 않으면 false 반환
	    return count != null && count > 0;
	}
	
	public int registerKakaoUser(SqlSessionTemplate sqlSession, User user) {
		return sqlSession.insert("userMapper.registerKakaoUser",user);
	}
	
	public void insertSecret(SqlSessionTemplate sqlSession, CertVO certVo) {
		sqlSession.insert("userMapper.insertSecret", certVo);
	}
	
	public boolean validate(SqlSessionTemplate sqlSession, CertVO certVo) {
		
		CertVO result = sqlSession.selectOne("userMapper.validate",certVo);
		if(result != null) {
			sqlSession.delete("userMapper.remove",certVo);
		}
		
		return result != null;
	}
}
