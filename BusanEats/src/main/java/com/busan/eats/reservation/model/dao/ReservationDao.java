package com.busan.eats.reservation.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.reservation.model.vo.Reservation;

@Repository
public class ReservationDao {

	public int insertReservation(Reservation r, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("reservationMapper.insertReservation",r);
	};
	
	public ArrayList<Reservation> selectReservation(int userNo, SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reservationMapper.selectReservation", userNo);
	}
}
